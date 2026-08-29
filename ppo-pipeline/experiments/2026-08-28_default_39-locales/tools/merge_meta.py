#!/usr/bin/env python3
"""Merge meta_src/part*.json into metadata_39.json. The 4 live locales keep
their ASC name/subtitle/keywords/description (pulled once) and only get the new
whatsNew; __EN_US__/__FR_FR__ placeholders reuse another locale's description."""
import importlib.util, json, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
TEMPLATE = Path.home() / "Documents/GambitStudio/_GambitStudio/templates/fastlane/upload_ppo.py"
VERSION, APP_INFO = "520488b6-04bc-4f27-8652-d2f81152c943", "0dce2e1a-8fe5-4d0c-a072-e32eb9e848a5"
meta = {}
for p in sorted((ROOT / "tools/meta_src").glob("part*.json")):
    meta.update(json.loads(p.read_text()))
spec = importlib.util.spec_from_file_location("t", TEMPLATE); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
h = {}
names = {l["attributes"]["locale"]: l["attributes"] for l in m.get(h, f"/v1/appInfos/{APP_INFO}/appInfoLocalizations", {"limit": 50})["data"]}
for l in m.get(h, f"/v1/appStoreVersions/{VERSION}/appStoreVersionLocalizations", {"limit": 50})["data"]:
    a = l["attributes"]; loc = a["locale"]
    meta[loc] = {**meta.get(loc, {}), "description": a["description"], "keywords": a["keywords"],
                 "promotionalText": a.get("promotionalText") or "", "name": names[loc]["name"], "subtitle": names[loc]["subtitle"]}
for loc, o in json.loads((ROOT / "tools/meta_src/overrides.json").read_text()).items():
    meta[loc].update(o)
for loc, src in (("en-GB", "en-US"), ("en-AU", "en-US"), ("en-CA", "en-US"), ("fr-CA", "fr-FR")):
    if meta[loc]["description"].startswith("__"):
        meta[loc]["description"] = meta[src]["description"]
(ROOT / "tools/metadata_39.json").write_text(json.dumps(meta, ensure_ascii=False, indent=1))
print(len(meta), "locales ->", sorted(meta))
for loc, v in sorted(meta.items()):
    print(f"{loc:8} name={len(v['name']):2} sub={len(v['subtitle']):2} kw={len(v['keywords']):3} promo={len(v.get('promotionalText','')):3} desc={len(v['description'])}")
