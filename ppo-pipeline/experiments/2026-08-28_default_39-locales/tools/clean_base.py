#!/usr/bin/env python3
"""Smooth the headline band of the reconstructed base: thin vertical shadow
tails survive the per-locale recovery; a median (kills lines < ~10 px) plus a
soft blur, feathered at the band edges, hides them on an already-bokeh sky."""
import sys
from pathlib import Path
import numpy as np
from PIL import Image, ImageFilter

ROOT = Path(__file__).resolve().parent.parent
Y0, Y1, FEATHER = 95, 375, 24
raw = ROOT / "base_raw"
raw.mkdir(exist_ok=True)
for n in range(1, 6):
    p = ROOT / f"base/0{n}.png"
    src = raw / p.name
    if not src.exists():
        src.write_bytes(p.read_bytes())
    im = Image.open(src).convert("RGB")
    band = im.crop((0, Y0 - FEATHER, im.width, Y1 + FEATHER))
    smooth = band.filter(ImageFilter.MedianFilter(21)).filter(ImageFilter.GaussianBlur(5))
    h = band.height
    w = np.ones(h, dtype=np.float32)
    ramp = np.linspace(0, 1, FEATHER, dtype=np.float32)
    w[:FEATHER] = ramp
    w[-FEATHER:] = ramp[::-1]
    a = np.array(band).astype(np.float32)
    b = np.array(smooth).astype(np.float32)
    out = a * (1 - w[:, None, None]) + b * w[:, None, None]
    im.paste(Image.fromarray(np.clip(out, 0, 255).astype(np.uint8)), (0, Y0 - FEATHER))
    im.save(p)
    print(p.name, "cleaned")
