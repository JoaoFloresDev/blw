#!/usr/bin/env python3
"""Push a screenshot folder to the DEFAULT product page of an app store version.

Reads <dir>/<locale>/NN_*.png and, for every locale, reconciles the version
localization's screenshot set for one display type: keeps the shots whose
sourceFileChecksum already matches the local file, deletes the rest, uploads
what is missing, then pins the order.

Reconciling by checksum rather than by file name is what makes a re-run cheap
and idempotent — ASC keeps the old shots under the same 01..05 names, so a
name comparison would call a stale set "already correct" (LEARNINGS #35).

Irmão de parallel_upload.py, que faz o mesmo para um TRATAMENTO de PPO. Os dois
existem porque o alvo difere: lá o set pendura em appStoreVersionExperimentTreatment-
Localization, aqui em appStoreVersionLocalization. Mexeu num, olhe o outro.

Usage:
  push_default_page.py <dir> --version <appStoreVersionId> [--locales a,b] [--dry-run]

Env: APP_STORE_CONNECT_KEY_ID / ISSUER_ID / KEY_PATH, APP_BUNDLE_ID
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import os
import random
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

TEMPLATE = Path.home() / "Documents/GambitStudio/_GambitStudio/templates/fastlane/upload_ppo.py"


def load_template():
    spec = importlib.util.spec_from_file_location("ppo_template", TEMPLATE)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def md5(path: Path) -> str:
    return hashlib.md5(path.read_bytes()).hexdigest()


_print_lock = threading.Lock()


def say(msg: str) -> None:
    with _print_lock:
        print(msg, flush=True)


def retry(fn, *a, what: str = "", attempts: int = 4, **kw):
    """ASC answers a burst with the occasional 429/5xx or a dropped connection.
    Backing off and retrying is enough; giving up on the first blip would leave
    a locale half-uploaded."""
    for i in range(attempts):
        try:
            return fn(*a, **kw)
        except Exception as exc:
            transient = any(t in str(exc) for t in ("429", "500", "502", "503", "504",
                                                    "Connection", "timeout", "Timeout"))
            if i == attempts - 1 or not transient:
                raise
            wait = 2 ** i * 3 + random.uniform(0, 2)
            say(f"    ! {what or fn.__name__}: {str(exc)[:80]} — retry em {wait:.0f}s")
            time.sleep(wait)


def find_or_create_set(mod, headers, loc_id: str, display_type: str) -> str:
    data = retry(mod.get, headers, f"/v1/appStoreVersionLocalizations/{loc_id}/appScreenshotSets",
                 what="sets")
    for s in data.get("data", []):
        if s["attributes"].get("screenshotDisplayType") == display_type:
            return s["id"]
    body = {
        "data": {
            "type": "appScreenshotSets",
            "attributes": {"screenshotDisplayType": display_type},
            "relationships": {
                "appStoreVersionLocalization": {
                    "data": {"type": "appStoreVersionLocalizations", "id": loc_id}
                }
            },
        }
    }
    return retry(mod.post, headers, "/v1/appScreenshotSets", body, what="create set")["data"]["id"]


def sync_set(mod, headers, set_id: str, files: list[Path]) -> tuple[int, int]:
    """Return (reused, uploaded)."""
    want = {md5(f): f for f in files}
    existing = retry(mod.get, headers, f"/v1/appScreenshotSets/{set_id}/appScreenshots",
                     {"limit": 50}, what="list").get("data", [])

    keep: dict[str, str] = {}          # checksum -> screenshot id
    for s in existing:
        c = s["attributes"].get("sourceFileChecksum")
        if c in want and c not in keep and s["attributes"].get("assetDeliveryState", {}).get("state") != "FAILED":
            keep[c] = s["id"]
        else:
            retry(mod.delete, headers, f"/v1/appScreenshots/{s['id']}", what="delete")

    ids_in_order: list[str] = []
    uploaded = 0
    for f in files:
        c = md5(f)
        if c in keep:
            ids_in_order.append(keep[c])
        else:
            ids_in_order.append(retry(mod.upload_screenshot, headers, set_id, f,
                                      what=f"upload {f.name}"))
            uploaded += 1

    retry(mod.patch, headers, f"/v1/appScreenshotSets/{set_id}/relationships/appScreenshots",
          {"data": [{"type": "appScreenshots", "id": i} for i in ids_in_order]}, what="order")
    return len(keep), uploaded


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("directory")
    ap.add_argument("--version", required=True)
    ap.add_argument("--display-type", default=os.environ.get("APP_DISPLAY_TYPE", "APP_IPHONE_67"))
    ap.add_argument("--locales")
    ap.add_argument("--workers", type=int, default=6,
                    help="locales enviados em paralelo (cada um e independente)")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    root = Path(args.directory)
    mod = load_template()
    headers: dict = {}

    locs = mod.get(headers, f"/v1/appStoreVersions/{args.version}/appStoreVersionLocalizations",
                   {"limit": 200})["data"]
    by_locale = {l["attributes"]["locale"]: l["id"] for l in locs}

    wanted = args.locales.split(",") if args.locales else sorted(d.name for d in root.iterdir() if d.is_dir())
    missing = [l for l in wanted if l not in by_locale]
    if missing:
        print(f"! sem localization na versao, ignorados: {', '.join(missing)}")

    todo = []
    for loc in [l for l in wanted if l in by_locale]:
        files = sorted((root / loc).glob("[0-9][0-9]*.png"))
        if not files:
            print(f"! {loc}: pasta vazia, pulado")
            continue
        todo.append((loc, files))

    if args.dry_run:
        for loc, files in todo:
            print(f"[dry] {loc}: {len(files)} prints")
        return 0

    def run(job):
        loc, files = job
        set_id = find_or_create_set(mod, headers, by_locale[loc], args.display_type)
        return loc, sync_set(mod, headers, set_id, files)

    total_up = total_keep = 0
    failures: list[tuple[str, str]] = []
    done = 0
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures = {pool.submit(run, j): j[0] for j in todo}
        for fut in as_completed(futures):
            loc = futures[fut]
            done += 1
            try:
                _, (keep, up) = fut.result()
            except Exception as exc:
                failures.append((loc, str(exc)[:200]))
                say(f"[{done:>2}/{len(todo)}] {loc:<8} FALHOU: {str(exc)[:120]}")
                continue
            total_keep += keep
            total_up += up
            say(f"[{done:>2}/{len(todo)}] {loc:<8} reusados={keep} enviados={up}")

    print(f"\nreusados: {total_keep} | enviados: {total_up} | falhas: {len(failures)}")
    for loc, err in failures:
        print(f"  FALHOU {loc}: {err}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
