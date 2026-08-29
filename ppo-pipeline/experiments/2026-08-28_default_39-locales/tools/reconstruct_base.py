#!/usr/bin/env python3
"""Rebuild the text-free art of a print set from its localized variants.

Each locale carries the same art with a different baked headline (white
glyphs + soft black shadow on blurred sky). For every pixel:
  1. if at least one locale is clean there (outside that locale's own
     glyph-mask dilated by the shadow reach), take that locale's pixel;
  2. otherwise (covered by text in every locale) fill by 2D harmonic
     diffusion from the surrounding sky — smooth, seamless on bokeh.

Usage:
  reconstruct_base.py <source_dir> <out_dir> [--band 60 470]
  source_dir/<locale>/<NN>_*.png  (same file basename order per locale)
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageFilter

WHITE_MIN = 236    # glyph fill: every channel at least this bright…
WHITE_SPREAD = 18  # …and nearly neutral
SHADOW_REACH = 41  # dilation (px, odd) covering the blurred shadow around glyphs
GLYPH_MIN_STROKE = 9  # opening kernel (px, odd): glyph strokes are thicker, foliage specks are not


def load(path: Path) -> np.ndarray:
    return np.array(Image.open(path).convert("RGB")).astype(np.float32)


def dilate(mask: np.ndarray, size: int) -> np.ndarray:
    img = Image.fromarray((mask * 255).astype(np.uint8)).filter(ImageFilter.MaxFilter(size))
    return np.array(img) > 0


def harmonic_fill(img: np.ndarray, mask: np.ndarray, y0: int, y1: int) -> np.ndarray:
    """Jacobi diffusion inside `mask` (rows y0:y1 only), multi-scale for speed."""
    out = img.copy()
    region = img[y0:y1]
    m = mask[y0:y1]
    h, w, _ = region.shape

    def solve(reg: np.ndarray, msk: np.ndarray, init: np.ndarray | None, iters: int) -> np.ndarray:
        s = reg.copy()
        if init is not None:
            s[msk] = init[msk]
        for _ in range(iters):
            pad = np.pad(s, ((1, 1), (1, 1), (0, 0)), mode="edge")
            avg = (pad[:-2, 1:-1] + pad[2:, 1:-1] + pad[1:-1, :-2] + pad[1:-1, 2:]) * 0.25
            s[msk] = avg[msk]
        return s

    def down(a: np.ndarray, f: int, is_mask: bool = False) -> np.ndarray:
        src = Image.fromarray((a * 255).astype(np.uint8)) if is_mask else Image.fromarray(np.clip(a, 0, 255).astype(np.uint8))
        r = src.resize((max(1, w // f), max(1, h // f)), Image.BILINEAR)
        return (np.array(r) > 0) if is_mask else np.array(r).astype(np.float32)

    def up(a: np.ndarray, size: tuple[int, int]) -> np.ndarray:
        return np.array(Image.fromarray(np.clip(a, 0, 255).astype(np.uint8)).resize(size, Image.BICUBIC)).astype(np.float32)

    init = None
    for f, iters in ((16, 800), (8, 600), (4, 400), (2, 200), (1, 60)):
        reg_f = down(region, f) if f > 1 else region
        msk_f = down(m, f, True) if f > 1 else m
        if init is not None:
            init = up(init, (reg_f.shape[1], reg_f.shape[0]))
        init = solve(reg_f, msk_f, init, iters)
    out[y0:y1] = init
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("source")
    ap.add_argument("out")
    ap.add_argument("--band", type=int, nargs=2, default=(60, 470), help="rows that may contain headline text")
    ap.add_argument("--locales", default="en-US,pt-BR,es-ES")
    args = ap.parse_args()

    src, out = Path(args.source), Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    locales = args.locales.split(",")
    y_top, y_bot = args.band
    names = sorted(p.name for p in (src / locales[0]).glob("*.png"))
    for name in names:
        variants = [load(src / loc / name) for loc in locales]
        h, w, _ = variants[0].shape
        band = np.zeros((h, w), dtype=bool)
        band[y_top:y_bot] = True

        masks = []
        for v in variants:
            glyph = (v.min(axis=2) >= WHITE_MIN) & ((v.max(axis=2) - v.min(axis=2)) <= WHITE_SPREAD) & band
            # morphological opening: drop specks (sunlit leaves, cloud highlights) thinner than a glyph stroke
            opened = Image.fromarray((glyph * 255).astype(np.uint8)).filter(ImageFilter.MinFilter(GLYPH_MIN_STROKE)).filter(ImageFilter.MaxFilter(GLYPH_MIN_STROKE))
            strokes = np.array(opened) > 0
            # accents/diacritics are small but sit right next to a stroke: keep raw white pixels near strokes
            glyph = glyph & dilate(strokes, SHADOW_REACH)
            masks.append(dilate(glyph, SHADOW_REACH) & band)

        # Shadows only darken, glyphs are masked out: among the locales that are
        # clean at a pixel, the brightest value is the one least touched by a
        # shadow tail -> take it.
        base = variants[0].copy()
        best_lum = np.where(masks[0], -1.0, variants[0].sum(axis=2))
        covered = masks[0].copy()
        for v, m in zip(variants[1:], masks[1:]):
            lum = np.where(m, -1.0, v.sum(axis=2))
            take = lum > best_lum
            base[take] = v[take]
            best_lum = np.maximum(best_lum, lum)
            covered &= m
        # `covered` = text in every locale -> inpaint
        recovered = masks[0] & ~covered
        if covered.any():
            pad = 6  # let the fill see a little clean sky beyond the band
            base = harmonic_fill(base, covered, max(0, y_top - pad), min(h, y_bot + pad))
            feather = np.array(Image.fromarray((covered * 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(3))).astype(np.float32) / 255.0
            smooth = np.array(Image.fromarray(np.clip(base, 0, 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(6))).astype(np.float32)
            base = base * (1 - feather[..., None]) + smooth * feather[..., None]
        Image.fromarray(np.clip(base, 0, 255).astype(np.uint8)).save(out / name)
        Image.fromarray((covered * 255).astype(np.uint8)).save(out / f"_mask_{name}")
        print(f"{name}: recovered {int(recovered.sum())} px from other locales, inpainted {int(covered.sum())} px ({covered.mean() * 100:.2f}%)", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
