# Competitor Research — BLW Tracker (pt-BR)

Snapshot date: **2026-05-22**
Source: iTunes Search API (BR storefront), top results for terms `BLW`, `introdução alimentar`, `papinha`, `comida bebê`.

---

## Tier 1 — Direct competitors (head-of-niche, high social proof)

### 1. BLW Brasil — Alimentação bebês  ⭐️ MAIN COMPETITOR
- **ID**: 1478347645  ·  **Seller**: BLW SOCIAL PTE. LTD.
- **Released**: 2019-09-23  ·  **Last update**: 2026-05-12
- **Reviews**: **1,829** (rating 4.68 ★)  ·  **Genre**: Food & Drink + Lifestyle
- **IAP**: yes (paid content + subscription)
- **Why it's the benchmark**:
  - Owns the exact head-keyword stack we want (`BLW` + `introdução alimentar` + `alimentação bebê`)
  - 1.8K reviews = 5+ years of organic SEO accumulation — Apple weights review count heavily
  - Description leads with social proof (3 testimonials before features)
  - Cross-promo with sister app Garfinho (same publisher)
- **Take from them**: descriptive copy density (every feature gets a benefit sentence), testimonial-led description hook
- **Don't copy**: they hide pricing behind subscription wall — we're free in v1, that's our advantage

### 2. Garfinho — Alimentação infantil  ⭐️ SAME PUBLISHER AS #1
- **ID**: 1630738243  ·  **Seller**: BLW SOCIAL PTE. LTD.
- **Released**: 2022-06-28  ·  **Last update**: 2026-04-14
- **Reviews**: 346 (rating **4.94 ★** — highest in the niche)
- **Position**: targets 2-7y old kids (post-BLW phase) — adjacent but not direct overlap
- **Why notable**: same publisher as BLW Brasil ⇒ they segment by child age. Tells us there's room for an app that owns the **6m-2y BLW phase specifically** (gap between newborn trackers and the 2y+ Garfinho).
- **Don't fight them on 2y+ kw**; double down on `6 meses`, `primeiros alimentos`, `BLW`

### 3. Mundo BLW
- **ID**: 1483927674  ·  **Seller**: MUNDO BLW TECH SERVICOS DE TECNOLOGIA LTDA
- **Released**: 2019-10-25  ·  **Last update**: 2024-02-19 (~21 months stale)
- **Reviews**: 228 (rating 4.45 ★)  ·  **Genre**: Education
- **Position**: BLW guide + recipes + subscription, focus on cortes/texturas seguras + manobras de desengasgo (safety)
- **Why they're vulnerable**: stale (no update in 21 months), 96MB app size (vs our 14MB) — Apple ranking penalises stale apps
- **Take from them**: emphasis on **safety / desengasgo / cortes seguros** — high-emotion ASO keyword we should test

---

## Tier 2 — Adjacent / second-rank

### 4. Bebê de Nutri
- **ID**: 6477542492  ·  **Released**: 2024-02-09
- **Reviews**: 212 (rating ~4.5 ★)  ·  **Genre**: Health & Fitness
- **Position**: nutricionista-led (Franciele Loss @bebedenutri) — covers 0-6y, evidence-based content
- **Why notable**: piggybacks on Instagram brand (high-conversion if user already follows)
- **Lesson**: authority/credentialed-expert angle is a moat we don't have (we're a tool, not a personality)

### 5. Pippin — Introdução Alimentar  🆕 NEWEST DIRECT THREAT
- **ID**: 6754761404  ·  **Released**: 2026-01-30 (~4 months old)
- **Reviews**: 12 (early)
- **Position**: nearly identical to ours — "registre alimentos, reações, receitas, BLW + tradicional"
- **Why watch closely**: this is the newest competitor doing exactly what we do. They have 12 reviews vs our (unknown but low) baseline — both at the same stage. Will likely become a benchmark by month 3.

### 6. BLW: Introdução Alimentar  (foreign-built)
- **Bundle**: baby.starts.solid.food.blw.meals.tracker  ·  Reviews: 18
- **Genre**: Education
- Generic ASO play, foreign publisher. Low quality but eats some impressions for `BLW + tracker` exact match.

---

## Tier 3 — Adjacent / high-volume but different intent

### 7. Meu Bebê — Diário da Amamentação
- **ID**: com.neumandev.mybaby  ·  **Reviews**: 26,109 (rating 4.7 ★)
- **Why it matters for us**: dominates `bebê` + `diário` queries. We share these head-keywords but their intent is **amamentação** (breastfeeding) — adjacent user base, not direct competitor for `introdução alimentar` long-tail.
- **Implication**: don't waste keyword slots on `bebê` + `diário` solo — they'll never outrank this app. Instead pair them inside long-tail (`diário alimentar`, `bebê 6 meses`).

### 8. Kinedu — Desenvolvimento do Bebê
- **Reviews**: 12,097  ·  **Genre**: Education
- General baby development, big brand. Not a competitor for food specifically but absorbs `bebê desenvolvimento` searches.

---

## ASO takeaways (what to test in iter-01 + iter-02)

| Insight | Action |
|---|---|
| BLW Brasil owns `BLW` head-kw with 1.8K reviews | Don't compete on `BLW` alone — we lose. Compete on **long-tail combos** (`BLW receitas`, `BLW 6 meses`, `introdução alimentar BLW`) where review count matters less. |
| Mundo BLW is **stale (21mo)** | Their rank is decaying. Strong opportunity to overtake their unique angle: **`cortes seguros`, `desengasgo`, `texturas`** — high emotional intent. |
| Pippin (newest direct competitor) shipped Jan 2026 | They use **`primeiros alimentos`, `reações`, `BLW + tradicional`** — test these terms quickly before they accumulate reviews. |
| Garfinho (4.94★) targets **2-7y** explicitly | Vacuum exists for **6m-2y BLW phase**. Our positioning: **`introdução alimentar 6 meses`, `papinha 6 meses`** specifically. |
| `bebê` + `diário` head-kw owned by Meu Bebê (26K reviews) | Don't burn keyword slots on solo `bebê` or solo `diário`. Use them only inside long-tails. |
| BR top 3 apps all use **`alimentação`** prominently | Confirms `alimentação` as a must-have head-kw |
| All competitors are paid/freemium with subscription | **Our v1-is-free moat** — promotional_text should signal `grátis e sem anúncios` (we already do, keep) |

---

## Open questions for Astro tracking (iter-01)

Need real popularity/difficulty numbers from Astro for these terms before deciding final keywords/subtitle:

- `introdução alimentar` (head, our current name)
- `introdução alimentar bebê`, `introdução alimentar blw`, `introdução alimentar 6 meses`
- `BLW`, `BLW receitas`, `BLW 6 meses`, `BLW tradicional`
- `papinha`, `papinha bebê`, `papinha 6 meses`, `papinha caseira`
- `comida bebê`, `comida 6 meses`
- `desengasgo` (Mundo BLW angle, possibly low-comp gold)
- `cortes seguros bebê`, `texturas bebê`
- `primeiros alimentos`, `primeiros alimentos bebê`
- `diário alimentar`, `diário alimentar bebê`
- `receitas bebê`, `receitas papinha`, `receitas 6 meses`
- `alergia alimentar bebê`, `alergênicos bebê`
- `cardápio bebê`, `cardápio infantil`
- `nutrição infantil`, `pediatria alimentar`
- `tracker bebê`, `rastreador bebê` (English+PT)
- `maternidade alimentação`, `mãe primeira viagem`
