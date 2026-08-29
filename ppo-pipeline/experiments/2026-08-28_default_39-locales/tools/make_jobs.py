#!/usr/bin/env python3
"""Build the render_headlines jobs file + copy the locales that reuse live prints.

Reads tools/headlines.json, writes out/<locale>/0N.png for every App Store locale:
  - langs rendered on base/0N.png (one render per lang, aliases copied afterwards)
  - "live:<loc>" aliases copy source/live/<loc>/0N.png byte-for-byte (checksum
    reconciliation on ASC then reuses what is already there).

Usage: make_jobs.py  -> writes tools/jobs.json, then run ./tools/render_headlines tools/jobs.json
       make_jobs.py --copy  (after rendering) -> materialize aliases
"""
import json
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SPEC = json.loads((ROOT / "tools/headlines.json").read_text())
LAYOUT = {
    "width": 1242, "height": 2688, "centerX": 621,
    "line1": {"size": 172, "baseline": 244, "maxWidth": 1060},
    "line2": {"size": 71, "baseline": 327, "maxWidth": 1060},
    "shadow": {"blur": 14, "dx": 0, "dy": 6, "alpha": 0.55},
}


def main() -> int:
    if "--copy" in sys.argv:
        for loc, target in SPEC["aliases"].items():
            src = ROOT / "source/live" / target[5:] if target.startswith("live:") else ROOT / "out" / target
            dst = ROOT / "out" / loc
            dst.mkdir(parents=True, exist_ok=True)
            for n in range(1, 6):
                shutil.copyfile(src / f"0{n}.png", dst / f"0{n}.png")
            print(f"{loc} <- {target}")
        return 0

    jobs = []
    for lang, cfg in SPEC["langs"].items():
        for n, (l1, l2) in enumerate(cfg["prints"], start=1):
            jobs.append({
                "base": str(ROOT / f"base/0{n}.png"),
                "out": str(ROOT / "out" / lang / f"0{n}.png"),
                "lang": lang, "line1": l1, "line2": l2,
                "scale1": cfg.get("scale1", 1.0), "scale2": cfg.get("scale2", 1.0),
                "uppercase": cfg.get("uppercase", True),
            })
    (ROOT / "tools/jobs.json").write_text(json.dumps({"layout": LAYOUT, "jobs": jobs}, ensure_ascii=False, indent=1))
    print(f"{len(jobs)} jobs for {len(SPEC['langs'])} langs")
    return 0


if __name__ == "__main__":
    sys.exit(main())
