#!/usr/bin/env python3
"""Generates current_pool_pt-BR.csv + candidates_pt-BR.csv (Astro 14-col format)
from the Astro JSON pull (astro_br_2026-08-18.json).

Pool = every word of the term is a token of the LIVE pt-BR fields (v1.5.1 —
name + subtitle + keywords). NOTE: the editable 1.5.2 keywords (iter-03) are
NOT used here because they are not live/indexed yet."""
import csv
import json
import unicodedata
from pathlib import Path

HERE = Path(__file__).resolve().parent
APP_NAME = "Introdução Alimentar BLW Baby"
APP_ID = "6758321287"
STORE_DOMAIN = "br"
STORE = "🇧🇷 Brazil"

COLS = ["App Name", "App Id", "Platform", "Keyword", "Store Domain", "Store", "Note",
        "Last Update", "Ranking", "Change", "Popularity", "Difficulty", "Apps in Ranking", "Tags"]

# Tokens of the LIVE pt-BR fields (name + subtitle + keywords, v1.5.1)
# name: Introdução Alimentar BLW Baby
# subtitle: Papinha, Receitas Solid Starts
# keywords: papinha caseira,papinha 6 meses,receitas papinha,baby weaning,baby feeding,desengasgo,cortes seguros
FIELD_TOKENS = set("""introdução introducao alimentar blw baby papinha receitas
solid starts caseira 6 meses weaning feeding desengasgo cortes seguros""".split())


def norm(s: str) -> str:
    return unicodedata.normalize("NFC", s.strip().lower())


def is_pool(kw: str) -> bool:
    return all(w in FIELD_TOKENS for w in norm(kw).split())


def main() -> None:
    data = json.load(open(HERE / "astro_br_2026-08-18.json"))
    pool_rows, cand_rows = [], []
    for e in sorted(data, key=lambda x: (x.get("currentRanking", 1000), -x.get("popularity", 0))):
        kw = norm(e["keyword"])
        rank = e.get("currentRanking", "")
        row = {
            "App Name": APP_NAME, "App Id": APP_ID, "Platform": "iphone",
            "Keyword": kw, "Store Domain": STORE_DOMAIN, "Store": STORE,
            "Note": e.get("note", ""),
            "Last Update": (e.get("lastUpdate") or "")[:10],
            "Ranking": "OUT" if rank == 1000 else rank,
            "Change": e.get("rankingChange", ""),
            "Popularity": e.get("popularity", ""),
            "Difficulty": e.get("difficulty", ""),
            "Apps in Ranking": e.get("appsCount", ""),
            "Tags": ";".join(e.get("tags", [])) if e.get("tags") else "",
        }
        (pool_rows if is_pool(kw) else cand_rows).append(row)

    for name, rows in [("current_pool_pt-BR.csv", pool_rows), ("candidates_pt-BR.csv", cand_rows)]:
        with open(HERE / name, "w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=COLS)
            w.writeheader()
            w.writerows(rows)
        print(f"{name}: {len(rows)} rows")


if __name__ == "__main__":
    main()
