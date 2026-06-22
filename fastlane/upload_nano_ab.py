#!/usr/bin/env python3
"""
Custom PPO upload: 2-treatment experiment comparing the Nano Banana style
against the current SwiftUI style, en-US only.

  Treatment A — "Nano Banana"  → nano/final/*.jpg
  Treatment B — "Standard"     → fastlane/screenshots/treatment_A/en-US/*.png

Control (automatic) = the current live default product page.

Reuses the same ASC API protocol as upload_ppo.py. Deletes any existing
draft experiment first (ASC allows only one draft per app).

Env vars (same as upload_ppo.py):
  APP_STORE_CONNECT_KEY_ID / ISSUER_ID / KEY_PATH, APP_BUNDLE_ID
"""

from __future__ import annotations
import hashlib, json, os, sys, time
from datetime import datetime
from pathlib import Path
from typing import Any, Optional
import jwt, requests


def _req(name: str) -> str:
    v = os.getenv(name)
    if not v:
        sys.exit(f"error: env var {name} is required")
    return v


KEY_ID = _req("APP_STORE_CONNECT_KEY_ID")
ISSUER_ID = _req("APP_STORE_CONNECT_ISSUER_ID")
KEY_PATH = os.path.expanduser(_req("APP_STORE_CONNECT_KEY_PATH"))
BUNDLE_ID = _req("APP_BUNDLE_ID")
DISPLAY_TYPE = os.getenv("APP_DISPLAY_TYPE", "APP_IPHONE_65")
LOCALE = os.getenv("APP_LOCALE", "en-US")
EXPERIMENT_NAME = os.getenv("APP_EXPERIMENT_NAME", f"Nano vs Standard {datetime.now().strftime('%Y-%m-%d')}")

ROOT = Path(__file__).resolve().parent.parent  # repo root (blw/)
BASE = "https://api.appstoreconnect.apple.com"

# (treatment label, list of image paths in display order)
TREATMENTS = [
    ("Nano Banana", sorted((ROOT / "nano" / "final").glob("*.jpg"))),
    ("Standard", sorted((ROOT / "fastlane" / "screenshots" / "treatment_A" / LOCALE).glob("*.png"))),
]


def token() -> str:
    now = int(time.time())
    return jwt.encode(
        {"iss": ISSUER_ID, "iat": now, "exp": now + 1200, "aud": "appstoreconnect-v1"},
        Path(KEY_PATH).read_text(), algorithm="ES256",
        headers={"kid": KEY_ID, "typ": "JWT"},
    )


class APIError(Exception):
    pass


def _check(r, where):
    if not r.ok:
        try:
            detail = json.dumps(r.json(), indent=2)
        except Exception:
            detail = r.text
        raise APIError(f"{where} → {r.status_code}\n{detail}")
    if r.status_code == 204 or not r.content:
        return None
    return r.json()


def get(h, p, params=None):
    return _check(requests.get(f"{BASE}{p}", headers=h, params=params), f"GET {p}")


def post(h, p, body):
    return _check(requests.post(f"{BASE}{p}", headers={**h, "Content-Type": "application/json"}, json=body), f"POST {p}")


def patch(h, p, body):
    return _check(requests.patch(f"{BASE}{p}", headers={**h, "Content-Type": "application/json"}, json=body), f"PATCH {p}")


def delete(h, p):
    return _check(requests.delete(f"{BASE}{p}", headers=h), f"DELETE {p}")


def find_app(h):
    apps = get(h, "/v1/apps", {"filter[bundleId]": BUNDLE_ID}).get("data", [])
    if not apps:
        raise APIError(f"App {BUNDLE_ID} not found")
    return apps[0]


def find_or_create_set(h, loc_id, display_type):
    data = get(h, f"/v1/appStoreVersionExperimentTreatmentLocalizations/{loc_id}/appScreenshotSets")
    for s in data.get("data", []):
        if s["attributes"].get("screenshotDisplayType") == display_type:
            return s
    body = {"data": {"type": "appScreenshotSets",
                     "attributes": {"screenshotDisplayType": display_type},
                     "relationships": {"appStoreVersionExperimentTreatmentLocalization": {
                         "data": {"type": "appStoreVersionExperimentTreatmentLocalizations", "id": loc_id}}}}}
    return post(h, "/v1/appScreenshotSets", body)["data"]


def clear_set(h, set_id):
    data = get(h, f"/v1/appScreenshotSets/{set_id}/appScreenshots")
    n = 0
    for s in data.get("data", []):
        delete(h, f"/v1/appScreenshots/{s['id']}")
        n += 1
    return n


def upload_shot(h, set_id, fp: Path):
    blob = fp.read_bytes()
    reserve = post(h, "/v1/appScreenshots", {"data": {"type": "appScreenshots",
        "attributes": {"fileName": fp.name, "fileSize": len(blob)},
        "relationships": {"appScreenshotSet": {"data": {"type": "appScreenshotSets", "id": set_id}}}}})["data"]
    sid = reserve["id"]
    for op in reserve["attributes"]["uploadOperations"] or []:
        oh = {x["name"]: x["value"] for x in op.get("requestHeaders", [])}
        chunk = blob[int(op["offset"]): int(op["offset"]) + int(op["length"])]
        rr = requests.request(op["method"].upper(), op["url"], headers=oh, data=chunk)
        if not rr.ok:
            raise APIError(f"PUT {fp.name}: {rr.status_code} {rr.text}")
    patch(h, f"/v1/appScreenshots/{sid}", {"data": {"type": "appScreenshots", "id": sid,
        "attributes": {"uploaded": True, "sourceFileChecksum": hashlib.md5(blob).hexdigest()}}})


def main():
    # Validate local files
    for label, files in TREATMENTS:
        if len(files) != 5:
            sys.exit(f"error: treatment '{label}' has {len(files)} images, expected 5")
    h = {"Authorization": f"Bearer {token()}"}
    app = find_app(h)
    print(f"App: {app['attributes']['name']} (id={app['id']})")

    # Delete existing drafts
    existing = get(h, f"/v1/apps/{app['id']}/appStoreVersionExperimentsV2").get("data", [])
    DRAFT = {"PREPARE_FOR_SUBMISSION", "READY_FOR_REVIEW", "WAITING_FOR_REVIEW", "IN_REVIEW", "REJECTED", "ACCEPTED"}
    for e in existing:
        if e["attributes"].get("state") in DRAFT:
            print(f"🧹 Deleting draft '{e['attributes'].get('name')}' (state={e['attributes'].get('state')})")
            delete(h, f"/v2/appStoreVersionExperiments/{e['id']}")
            time.sleep(2)

    print(f"\n🧪 Creating experiment: {EXPERIMENT_NAME}")
    exp = post(h, "/v2/appStoreVersionExperiments", {"data": {
        "type": "appStoreVersionExperiments",
        "attributes": {"name": EXPERIMENT_NAME, "platform": "IOS", "trafficProportion": 50},
        "relationships": {"app": {"data": {"type": "apps", "id": app["id"]}}}}})["data"]
    exp_id = exp["id"]
    print(f"   id={exp_id}")

    for label, files in TREATMENTS:
        print(f"\n▸ Treatment: {label}")
        tr = post(h, "/v1/appStoreVersionExperimentTreatments", {"data": {
            "type": "appStoreVersionExperimentTreatments",
            "attributes": {"name": label},
            "relationships": {"appStoreVersionExperimentV2": {
                "data": {"type": "appStoreVersionExperiments", "id": exp_id}}}}})["data"]
        loc = post(h, "/v1/appStoreVersionExperimentTreatmentLocalizations", {"data": {
            "type": "appStoreVersionExperimentTreatmentLocalizations",
            "attributes": {"locale": LOCALE},
            "relationships": {"appStoreVersionExperimentTreatment": {
                "data": {"type": "appStoreVersionExperimentTreatments", "id": tr["id"]}}}}})["data"]
        sset = find_or_create_set(h, loc["id"], DISPLAY_TYPE)
        cleared = clear_set(h, sset["id"])
        if cleared:
            print(f"   [{LOCALE}] cleared {cleared} inherited screenshot(s)")
        print(f"   [{LOCALE}] uploading {len(files)} screenshots…")
        for fp in files:
            upload_shot(h, sset["id"], fp)
            print(f"     ✓ {fp.name}")

    print(f"\n✅ Experiment '{EXPERIMENT_NAME}' created with 2 treatments (Nano Banana vs Standard), {LOCALE}.")
    print("   Control = current live default page. Start it in ASC → Product Page Optimization.")


if __name__ == "__main__":
    main()
