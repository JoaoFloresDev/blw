#!/usr/bin/env python3
"""Create/refresh every App Store locale of one appStoreVersion from metadata_39.json.

For each locale in the file:
  1. find-or-create the appStoreVersionLocalization (description, keywords,
     promotionalText, whatsNew, supportUrl) — POST for new locales, PATCH for
     existing ones (existing ones only get whatsNew unless --full).
  2. PATCH name/subtitle/privacyPolicyUrl on the matching appInfoLocalization
     of the editable appInfo (the POST in step 1 already creates it — a POST
     here would 409 DUPLICATE, LEARNINGS #57).

Usage: add_locales.py --version <id> --app-info <editable appInfo id> [--only a,b] [--dry-run]
Env: APP_STORE_CONNECT_KEY_ID / ISSUER_ID / KEY_PATH, APP_BUNDLE_ID
"""
import argparse
import importlib.util
import json
import sys
import time
from pathlib import Path

TEMPLATE = Path.home() / "Documents/GambitStudio/_GambitStudio/templates/fastlane/upload_ppo.py"
ROOT = Path(__file__).resolve().parent.parent
SUPPORT = "https://gambitstudiotech.com/"
PRIVACY = "https://drive.google.com/file/d/147xkp4cekrxhrBYZnzV-J4PzCSqkix7t/view?usp=sharing"
LIMITS = {"name": 30, "subtitle": 30, "keywords": 100, "promotionalText": 170, "description": 4000, "whatsNew": 4000}


def load_template():
    spec = importlib.util.spec_from_file_location("ppo_template", TEMPLATE)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def validate(meta: dict) -> list[str]:
    errs = []
    for loc, m in meta.items():
        for k, lim in LIMITS.items():
            v = m.get(k, "")
            if len(v) > lim:
                errs.append(f"{loc}.{k}: {len(v)} > {lim}")
        if not m.get("description") or not m.get("name"):
            errs.append(f"{loc}: missing description/name")
    return errs


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--version", required=True)
    ap.add_argument("--app-info", required=True)
    ap.add_argument("--only")
    ap.add_argument("--full", action="store_true", help="also rewrite description/keywords/promo on existing locales")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    meta = json.loads((ROOT / "tools/metadata_39.json").read_text())
    errs = validate(meta)
    if errs:
        print("\n".join(errs))
        return 2
    wanted = args.only.split(",") if args.only else list(meta)
    print(f"{len(wanted)} locales validated")
    if args.dry_run:
        return 0

    mod = load_template()
    h: dict = {}
    existing = {l["attributes"]["locale"]: l["id"] for l in
                mod.get(h, f"/v1/appStoreVersions/{args.version}/appStoreVersionLocalizations", {"limit": 200})["data"]}

    for loc in wanted:
        m = meta[loc]
        attrs = {"description": m["description"], "keywords": m["keywords"],
                 "promotionalText": m.get("promotionalText", ""), "whatsNew": m["whatsNew"],
                 "supportUrl": SUPPORT}
        if loc in existing:
            body = {"data": {"type": "appStoreVersionLocalizations", "id": existing[loc],
                             "attributes": attrs if args.full else {"whatsNew": m["whatsNew"]}}}
            mod.patch(h, f"/v1/appStoreVersionLocalizations/{existing[loc]}", body)
            print(f"[{loc}] version-loc PATCH")
        else:
            body = {"data": {"type": "appStoreVersionLocalizations",
                             "attributes": {"locale": loc, **attrs},
                             "relationships": {"appStoreVersion": {"data": {"type": "appStoreVersions", "id": args.version}}}}}
            for attempt in range(3):
                try:
                    existing[loc] = mod.post(h, "/v1/appStoreVersionLocalizations", body)["data"]["id"]
                    break
                except Exception as exc:
                    if attempt == 2 or "500" not in str(exc):
                        raise
                    time.sleep(5)
            print(f"[{loc}] version-loc CREATED {existing[loc]}")

    # appInfo localizations (name/subtitle) — created implicitly by the POSTs above
    infos = {l["attributes"]["locale"]: l["id"] for l in
             mod.get(h, f"/v1/appInfos/{args.app_info}/appInfoLocalizations", {"limit": 200})["data"]}
    for loc in wanted:
        m = meta[loc]
        if loc not in infos:
            print(f"[{loc}] ! no appInfoLocalization yet — creating")
            body = {"data": {"type": "appInfoLocalizations",
                             "attributes": {"locale": loc, "name": m["name"], "subtitle": m["subtitle"], "privacyPolicyUrl": PRIVACY},
                             "relationships": {"appInfo": {"data": {"type": "appInfos", "id": args.app_info}}}}}
            infos[loc] = mod.post(h, "/v1/appInfoLocalizations", body)["data"]["id"]
            continue
        body = {"data": {"type": "appInfoLocalizations", "id": infos[loc],
                         "attributes": {"name": m["name"], "subtitle": m["subtitle"], "privacyPolicyUrl": PRIVACY}}}
        mod.patch(h, f"/v1/appInfoLocalizations/{infos[loc]}", body)
        print(f"[{loc}] appInfo-loc PATCH name/subtitle")
    return 0


if __name__ == "__main__":
    sys.exit(main())
