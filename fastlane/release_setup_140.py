#!/usr/bin/env python3
"""One-shot setup for blw 1.4.0 on ASC: create the version, set whatsNew,
and replace the default product page iPhone screenshots with treatment_A."""
import sys
from pathlib import Path

import upload_ppo as ppo  # reuses token/http/upload helpers (env must be set)

APP_ID = "6758321287"
VERSION = "1.4.0"
DISPLAY_TYPE = "APP_IPHONE_65"
SHOTS_DIR = Path(__file__).parent / "screenshots" / "treatment_A"

WHATS_NEW = {
    "en-US": "Smoother, more reliable meal logging\nPremium got better — 3-day free trial on both plans\nPerformance fixes and polish throughout",
    "pt-BR": "Registro de refeições mais fluido e estável\nPremium melhorou — teste grátis de 3 dias nos dois planos\nCorreções e desempenho aprimorado",
    "es-ES": "Registro de comidas más fluido y estable\nPremium mejoró — prueba gratis de 3 días en ambos planes\nCorrecciones y mejor rendimiento",
    "es-MX": "Registro de comidas más fluido y estable\nPremium mejoró — prueba gratis de 3 días en ambos planes\nCorrecciones y mejor rendimiento",
}


def main():
    headers = {"Authorization": f"Bearer {ppo.make_token()}"}

    # 1. Find or create the 1.4.0 version
    vers = ppo.get(headers, f"/v1/apps/{APP_ID}/appStoreVersions", {"limit": 10})
    version = next((v for v in vers["data"]
                    if v["attributes"]["versionString"] == VERSION), None)
    if version:
        print(f"version {VERSION} exists: {version['id']} "
              f"({version['attributes']['appStoreState']})")
    else:
        version = ppo.post(headers, "/v1/appStoreVersions", {
            "data": {
                "type": "appStoreVersions",
                "attributes": {"versionString": VERSION, "platform": "IOS",
                               "releaseType": "AFTER_APPROVAL"},
                "relationships": {"app": {"data": {"type": "apps", "id": APP_ID}}},
            }
        })["data"]
        print(f"version {VERSION} created: {version['id']}")
    vid = version["id"]

    # 2. Localizations: whatsNew + screenshots
    locs = ppo.get(headers, f"/v1/appStoreVersions/{vid}/appStoreVersionLocalizations",
                   {"limit": 20})["data"]
    for loc in locs:
        locale = loc["attributes"]["locale"]
        lid = loc["id"]
        if locale in WHATS_NEW:
            ppo.patch(headers, f"/v1/appStoreVersionLocalizations/{lid}", {
                "data": {"type": "appStoreVersionLocalizations", "id": lid,
                         "attributes": {"whatsNew": WHATS_NEW[locale]}}
            })
            print(f"[{locale}] whatsNew set")

        src = SHOTS_DIR / locale
        if not src.is_dir():
            print(f"[{locale}] no treatment_A dir — skipping screenshots")
            continue

        sets = ppo.get(headers, f"/v1/appStoreVersionLocalizations/{lid}/appScreenshotSets")["data"]
        target = next((s for s in sets
                       if s["attributes"]["screenshotDisplayType"] == DISPLAY_TYPE), None)
        if target is None:
            target = ppo.post(headers, "/v1/appScreenshotSets", {
                "data": {
                    "type": "appScreenshotSets",
                    "attributes": {"screenshotDisplayType": DISPLAY_TYPE},
                    "relationships": {
                        "appStoreVersionLocalization": {
                            "data": {"type": "appStoreVersionLocalizations", "id": lid}
                        }
                    },
                }
            })["data"]
            print(f"[{locale}] created {DISPLAY_TYPE} set")
        cleared = ppo.clear_screenshots_in_set(headers, target["id"])
        pngs = sorted(src.glob("*.png"))
        for png in pngs:
            ppo.upload_screenshot(headers, target["id"], png)
        # verify
        final = ppo.get(headers, f"/v1/appScreenshotSets/{target['id']}/appScreenshots")["data"]
        print(f"[{locale}] cleared {cleared}, uploaded {len(pngs)}, now {len(final)} in set")
        if len(final) != 5:
            print(f"[{locale}] WARNING: expected 5, got {len(final)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
