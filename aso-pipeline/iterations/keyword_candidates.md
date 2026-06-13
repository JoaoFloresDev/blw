# Análise iter — BLW (App 6758321287) — Decisões pros 3 campos ASO

**Data:** 2026-06-13
**Source:** Astro MCP (`get_app_keywords` + `get_keyword_suggestions` + `search_app_store`) — US/BR/ES
**Baseline downloads:** não medido ainda (rodar `pull_analytics.py` pré-deploy pra Day 0)
**Filtro decisão (quadrante):** diff ≤ 20 sempre · diff 21-40 + pop ≥ 10 · diff 41-60 + pop ≥ 25 OU rank histórico · diff > 60 só com pop ≥ 40

| Campo    | Char max | Peso ASO | Estratégia                                       |
| -------- | -------- | -------- | ------------------------------------------------ |
| name     | 30       | 7×       | head do nicho + brand-EN-mix (palavras que GANHAM) |
| subtitle | 30       | 3×       | heads NÃO presentes no name                      |
| keywords | 100      | 1×       | sweet spots + long-tail + modifiers, frontload por pop |

**Princípio:** cada palavra no campo de MAIOR peso possível. Não duplicar entre campos — Apple indexa na 1ª ocorrência.

**⚠️ Alavanca #1 (acima de qualquer keyword):** o app tem **1 rating**. `ranking = relevance × velocity × conversion × retention`. Com rating mínimo o teto de todos os termos é baixo. Disparar `in_app_review` após 2º–3º registro/foto + buscar 15-20 reviews orgânicas nas primeiras 4 semanas.

---
---

# 🇧🇷 pt-BR

## 📐 Diff visual — antes / depois

**Legenda:** <span style="color:#dc3545">🔴 saiu</span> · <span style="color:#28a745">🟢 entrou novo</span> · <span style="color:#3b82f6">🔵 subiu de peso</span> · <span style="color:#1e3a8a">🔵 desceu de peso</span> · preto = mantém

### Name (REESCRITO — inversão de ordem)
| Antes (atual) | Depois (proposto) |
| --- | --- |
| `BLW Baby Introdução Alimentar` | `Introdução Alimentar BLW Baby` |
| 29 chars · lidera com brand | 29 chars · lidera com termo gordo (`introdução alimentar` pop=40); BLW continua indexado |

### Subtitle (REESCRITO)
| Antes (atual) | Depois (proposto) |
| --- | --- |
| <span style="color:#dc3545">Solid Starts</span>, Papinha e <span style="color:#dc3545">Cortes</span> | Papinha, <span style="color:#28a745">Receitas</span> Solid Starts |
| 30 chars · noun-list, `cortes` redundante c/ keywords | 30 chars · adiciona `receitas` (intenção de uso); mantém `solid starts` pop=50 |

### Keywords (REESCRITO)
| Antes (atual) | Depois (proposto) |
| --- | --- |
| starting solids,baby weaning,<span style="color:#dc3545">diário alimentar</span>,<span style="color:#dc3545">primeiro alimento</span>,<span style="color:#dc3545">blw meals</span>,desengasgo,cortes seguros | <span style="color:#28a745">papinha caseira</span>,<span style="color:#28a745">papinha 6 meses</span>,<span style="color:#28a745">receitas papinha</span>,baby weaning,<span style="color:#28a745">baby feeding</span>,desengasgo,cortes seguros |
| 99 chars · `diário alimentar` r=#63 diff=44 desperdiça 16 chars | 100 chars · troca dead-weight por 3 long-tails diff=5 ainda não ranqueadas |

## 🏷 NAME — `Introdução Alimentar BLW Baby`
| Palavra | Pop | Diff | Rank atual | Decisão |
| --- | --- | --- | --- | --- |
| `Introdução` | 5 | 13 | #7 | **Sobe pra 1ª posição** — head do nicho, compõe `introdução alimentar` (#17, pop 40) |
| `Alimentar` | 5 | 9 | — | **Mantém** — compõe o bigram principal |
| `BLW` | 48 | 13 | #31 | **Mantém** (pop 48!) — desce de posição mas segue indexado peso 7× |
| `Baby` | — | — | — | **Mantém** — brand-EN-mix, compõe `blw baby` (#1) |

**Veredito:** inversão tem upside marginal (Apple pesa levemente as 1ªs palavras + match de frase exata). Não muda os tokens indexados. Alavanca real do #17→top10 = ratings, não ordem.

## 🏷 SUBTITLE — `Solid Starts, Papinha e Cortes` (REESCREVER)
**🔴 SAIU:** `Cortes` (já coberto por `cortes seguros` no keywords) · conector `e`
**🟢 ENTROU:** `Receitas` (intenção de uso forte, audience BR)
**Mantém:** `Solid Starts` (pop 50, #41 — termo EN tem volume real no BR), `Papinha` (#13)

## 🔑 KEYWORDS FIELD
### 🔴 SAIU
| Termo | Pop | Diff | Rank | Por quê |
| --- | --- | --- | --- | --- |
| `diário alimentar` | 23 | 44 | #63 | diff alto, rank fraco — 16 chars desperdiçados |
| `primeiro alimento` | 5 | 9 | #4 | já ranqueia via composição name (`primeiros alimentos` #3) |
| `blw meals` | 6 | 5 | #15 | composição via `blw` (name) + `meals` — dispensável solo |

### 🟢 ENTROU (🥇 = sweet spot / 🟢 = Gold quadrant diff≤15)
| Termo | Pop | Diff | Rank | Por quê |
| --- | --- | --- | --- | --- |
| `papinha caseira` | 5 | 5 | OUT | 🟢 Gold — long-tail intenção alta, não ranqueada |
| `papinha 6 meses` | 5 | 5 | OUT | 🟢 Gold — idade-target, audience inicial |
| `receitas papinha` | 5 | 5 | OUT | 🟢 Gold — intenção de uso |
| `baby feeding` | 36 | 38 | OUT | head EN (`baby feeding tracker` pop 36) — volume real no BR |

### 🔄 MANTÉM
`baby weaning` (pop 25, diff 9) · `desengasgo` (#1) · `cortes seguros` (#2)

## 📄 Resultado final (pt-BR)
```
NAME (REESCRITO):
Introdução Alimentar BLW Baby                                                        (29/30)

SUBTITLE (REESCRITO):
Papinha, Receitas Solid Starts                                                       (30/30)

KEYWORDS (REESCRITO):
papinha caseira,papinha 6 meses,receitas papinha,baby weaning,                       (100/100)
baby feeding,desengasgo,cortes seguros
```

### Cobertura por cluster (peso composto)
| Cluster | name (×7) | subtitle (×3) | keywords (×1) | Total |
| --- | --- | --- | --- | --- |
| Introdução alimentar | introdução, alimentar | — | — | **14×** |
| BLW (brand) | blw, baby | — | — | **14×** |
| Papinha / receitas | — | papinha, receitas | papinha caseira, papinha 6 meses, receitas papinha | 6 + 3 = **9×** |
| Solid starts (EN) | — | solid starts | — | **3×** |
| Weaning (EN) | — | — | baby weaning, baby feeding | **2×** |
| Segurança | — | — | desengasgo, cortes seguros | **2×** |

## 🎯 Hipótese formal
> **If we change** name→`Introdução Alimentar BLW Baby`, subtitle→`Papinha, Receitas Solid Starts`, keywords→long-tails papinha + baby feeding,
> **then** impressions/dia ↑ ≥15% e downloads/dia ↑ ≥10% em 30 dias,
> **because** (a) `introdução alimentar` (pop 40) liderando = match de frase exata + peso de posição · (b) 3 long-tails `papinha *` diff=5 abrem top-10 fácil · (c) `baby feeding` pop=36 head EN com volume BR · (d) drop de `diário alimentar` (r=#63) libera 16 chars · (e) char budget 29/30 + 30/30 + 100/100.

## ⚠️ Riscos
1. 🟢 `papinha *` long-tails: entrada top-10 esperada (diff=5).
2. ⚠️ Inversão do name: upside marginal (+1 a +3 pos), não a alavanca principal.
3. 🔴 Drop `diário alimentar`: era #63 (fraco) — perda baixa.
4. Rating=1 limita todo o ganho — priorizar reviews.

---
---

# 🇪🇸 es-ES

## 📐 Diff visual — antes / depois
### Name (mantém — ranqueia #2)
| Antes | Depois |
| --- | --- |
| `Alimentación Complementaria` | `Alimentación Complementaria` (igual) |
| 27 chars · #2 em "alimentación complementaria" | sem mudança |

### Subtitle (REESCRITO)
| Antes | Depois |
| --- | --- |
| <span style="color:#dc3545">Comida Bebé 6 Meses - Diario</span> | <span style="color:#28a745">BLW</span>, Comida Bebé <span style="color:#28a745">y Papillas</span> |
| 28 chars · sem BLW (termo gordo zerado) | 27 chars · injeta **BLW pop=47** + `papillas` (#7) |

### Keywords (REESCRITO)
| Antes | Depois |
| --- | --- |
| <span style="color:#dc3545">papillas</span>,recetas,<span style="color:#dc3545">primeros alimentos</span>,nutrición,alérgenos,<span style="color:#dc3545">tracker</span>,sólidos,lactancia,<span style="color:#dc3545">maternidad</span>,<span style="color:#dc3545">infant</span> | <span style="color:#28a745">blw</span>,<span style="color:#28a745">starting solids</span>,<span style="color:#28a745">solid starts</span>,<span style="color:#28a745">baby led weaning</span>,<span style="color:#28a745">destete</span>,recetas,sólidos,alérgenos,lactancia |
| 99 chars · sem cluster BLW/EN | 93 chars · cluster BLW/EN (pop alta, diff≤11) + `destete` |

## 🏷 NAME — `Alimentación Complementaria` (mantém)
| Palavra | Pop | Diff | Rank | Decisão |
| --- | --- | --- | --- | --- |
| `Alimentación` | — | — | #2 | **Mantém** — head, já #2 |
| `Complementaria` | 11 | 11 | #2 | **Mantém** — compõe o termo principal |

## 🏷 SUBTITLE — `Comida Bebé 6 Meses - Diario` (REESCREVER)
**🔴 SAIU:** `6 Meses`, `Diario` (baixa intenção) → libera chars
**🟢 ENTROU:** `BLW` (pop 47, hoje invisível!), `Papillas` (#7, sobe de keywords → subtitle peso 3×)
**Mantém:** `Comida Bebé`

## 🔑 KEYWORDS FIELD
### 🔴 SAIU
`papillas` (movido pro subtitle peso 3×) · `primeros alimentos` (composição via name) · `tracker`/`maternidad`/`infant` (dead solos diff alto)

### 🟢 ENTROU (🥇 sweet spots)
| Termo | Pop | Diff | Por quê |
| --- | --- | --- | --- |
| `blw` | 47 | 9 | 🥇 SWEET SPOT MÁXIMO — pop 47, invisível hoje, entrar abre o maior termo do nicho |
| `starting solids` | 28 | 7 | 🥇 cluster EN com volume |
| `solid starts` | 33 | 11 | 🥇 idem |
| `baby led weaning` | — | — | termo-mãe do nicho, hoje invisível no top 15 |
| `destete` | — | — | weaning em ES, intenção alinhada |

### 🔄 MANTÉM
`recetas` · `sólidos` · `alérgenos` · `lactancia`

## 📄 Resultado final (es-ES)
```
NAME (UNCHANGED):
Alimentación Complementaria                                                          (27/30)

SUBTITLE (REESCRITO):
BLW, Comida Bebé y Papillas                                                          (27/30)

KEYWORDS (REESCRITO):
blw,starting solids,solid starts,baby led weaning,destete,recetas,                   (93/100)
sólidos,alérgenos,lactancia
```

### Cobertura por cluster (peso composto)
| Cluster | name (×7) | subtitle (×3) | keywords (×1) | Total |
| --- | --- | --- | --- | --- |
| Alimentación complementaria | alimentación, complementaria | — | — | **14×** |
| BLW / baby led weaning | — | blw | blw, baby led weaning | 3 + 2 = **5×** |
| Solid starts (EN) | — | — | starting solids, solid starts | **2×** |
| Papillas / comida bebé | — | papillas, comida, bebé | — | **3×** |
| Weaning / destete | — | — | destete | **1×** |

## 🎯 Hipótese formal
> **If we change** subtitle→`BLW, Comida Bebé y Papillas` + keywords→cluster BLW/EN,
> **then** impressions/dia ↑ ≥25% em 30 dias,
> **because** (a) `blw` pop=47 diff=9 hoje INVISÍVEL — maior buraco do mercado · (b) cluster EN (`starting solids` 28, `solid starts` 33) diff≤11 · (c) `papillas` sobe pra subtitle peso 3× (era #7) · (d) char budget 27/30 + 93/100.

## ⚠️ Riscos
1. 🥇 `blw`: maior upside de todos os mercados (termo gordo zerado).
2. 🔴 Drop `papillas` do keywords: mitigado — está no subtitle peso 3×.
3. Rating baixo limita o ganho.

---
---

# 🇺🇸 en-US

## 📐 Diff visual — antes / depois
### Name (REESCRITO)
| Antes | Depois |
| --- | --- |
| `BLW Tracker - <span style="color:#dc3545">Baby Led</span>` | `BLW Baby Led <span style="color:#28a745">Weaning</span> Tracker` |
| 22 chars · "Baby Led" cortado, 8 chars desperdiçados | 28 chars · captura a frase inteira `baby led weaning` |

### Subtitle (REESCRITO)
| Antes | Depois |
| --- | --- |
| First Foods & <span style="color:#dc3545">Solid Food Diary</span> | First Foods & <span style="color:#28a745">Solid Starts Log</span> |
| 30 chars | 30 chars · `solid starts` = maior pop do nicho (61) |

### Keywords (REESCRITO)
| Antes | Depois |
| --- | --- |
| puree,feeding,starting solids,infant,toddler,<span style="color:#dc3545">meals</span>,recipes,nutrition,<span style="color:#dc3545">food log</span>,allergen,6 month <span style="color:#dc3545">old</span> | starting solids,<span style="color:#28a745">weaning</span>,puree,feeding,recipes,allergen,infant,toddler,nutrition,<span style="color:#28a745">meal plan</span>,6 month |
| 98 chars | 97 chars · + weaning, meal plan; tira dups do título |

## 🏷 NAME — `BLW Baby Led Weaning Tracker`
| Palavra | Pop | Diff | Rank | Decisão |
| --- | --- | --- | --- | --- |
| `BLW` | 19 | 39 | #45 | **Mantém** — head do nicho |
| `Baby Led Weaning` | alta | — | OUT top15 | **Captura a frase inteira** (antes cortada em "Baby Led") |
| `Tracker` | — | — | — | **Mantém** — feature |

**Veredito:** name atual desperdiçava 8 chars e cortava a keyword principal. Frase completa = composição forte com Solid Starts & cia.

## 🏷 SUBTITLE — `First Foods & Solid Food Diary` (REESCREVER)
**🔴 SAIU:** `Solid Food Diary` → **🟢 ENTROU:** `Solid Starts Log` (`solid starts` pop=61, o maior do nicho)
**Mantém:** `First Foods`

## 🔑 KEYWORDS FIELD
### 🔴 SAIU
`meals` (dup com `meal plan`) · `food log` (dup `food`+`log` já compostos) · `old` (filler de "6 month old")
### 🟢 ENTROU
`weaning` (head do nicho não capturado) · `meal plan` (intenção parental)
### 🔄 MANTÉM
`starting solids` (#39) · `puree` · `feeding` · `recipes` · `allergen` · `infant` · `toddler` · `nutrition` · `6 month`

## 📄 Resultado final (en-US)
```
NAME (REESCRITO):
BLW Baby Led Weaning Tracker                                                         (28/30)

SUBTITLE (REESCRITO):
First Foods & Solid Starts Log                                                       (30/30)

KEYWORDS (REESCRITO):
starting solids,weaning,puree,feeding,recipes,allergen,infant,                       (97/100)
toddler,nutrition,meal plan,6 month
```

### Cobertura por cluster (peso composto)
| Cluster | name (×7) | subtitle (×3) | keywords (×1) | Total |
| --- | --- | --- | --- | --- |
| Baby Led Weaning | baby, led, weaning | — | weaning | 21 + 1 = **22×** |
| BLW (brand) | blw | — | — | **7×** |
| Solid starts / first foods | — | first, foods, solid, starts | starting solids | 12 + 1 = **13×** |
| Tracker / log | tracker | log | — | **10×** |
| Puree / feeding / recipes | — | — | puree, feeding, recipes, meal plan | **4×** |
| Age / nutrition | — | — | infant, toddler, nutrition, 6 month, allergen | **5×** |

## 🎯 Hipótese formal
> **If we change** name→`BLW Baby Led Weaning Tracker`, subtitle→`First Foods & Solid Starts Log`,
> **then** impressions/dia ↑ ≥15% em 30 dias,
> **because** (a) name captura `baby led weaning` inteiro (antes cortado) · (b) `solid starts` pop=61 no subtitle peso 3× · (c) `weaning`/`meal plan` substituem dead-weight · (d) char budget 28/30 + 30/30 + 97/100.
> ⚠️ Mercado dominado por Solid Starts (38.9k reviews) — ganho mais lento que BR/ES.

## ⚠️ Riscos
1. 🔵 Mercado saturado (Solid Starts #1 em tudo) — teto baixo sem reviews.
2. 🟢 `baby led weaning` frase inteira: ganho real vs name cortado atual.
3. Rating=1 é o gargalo dominante.

---
---

# 🌎 Resumo cross-locale

## Tabela consolidada — proposed metadata
| Locale | Name | Subtitle | Keywords |
| --- | --- | --- | --- |
| **pt-BR** | `Introdução Alimentar BLW Baby` (29) | `Papinha, Receitas Solid Starts` (30) | `papinha caseira,papinha 6 meses,receitas papinha,baby weaning,baby feeding,desengasgo,cortes seguros` (100) |
| **es-ES** | `Alimentación Complementaria` (27) | `BLW, Comida Bebé y Papillas` (27) | `blw,starting solids,solid starts,baby led weaning,destete,recetas,sólidos,alérgenos,lactancia` (93) |
| **en-US** | `BLW Baby Led Weaning Tracker` (28) | `First Foods & Solid Starts Log` (30) | `starting solids,weaning,puree,feeding,recipes,allergen,infant,toddler,nutrition,meal plan,6 month` (97) |

## Ranking estratégico dos mercados
1. **🇧🇷 BR** — atacar primeiro: maior pop agregado capturável + já lidera marca + baixa diff. Maior ROI.
2. **🇪🇸 ES** — ganho rápido: só adicionar `blw` (pop 47, diff 9) abre o maior termo, hoje zerado.
3. **🇺🇸 US** — mais difícil (Solid Starts domina, 38.9k reviews); longo prazo.

## Top 3 concorrentes por mercado
| Mercado | #1 | #2 | #3 |
| --- | --- | --- | --- |
| BR | BLW Brasil (1.8k★) | Garfinho (346★) | Mundo BLW (228★) · Pippin (novo) |
| ES | BLW Ideas (838★) | Solid Starts ES (291★) | Recetas para Bebés (24★) |
| US | Solid Starts (38.9k★) | Baby Led Weaning App–BLW (686★) | BLW Meals (305★) |

## Padrões cross-locale
| Padrão | pt-BR | es-ES | en-US |
| --- | --- | --- | --- |
| Termo EN tem volume local | `solid starts` pop 50 | `blw` pop 47 | (nativo) |
| Head dormindo não capturado | `baby feeding` pop 36 | `blw` pop 47 | `solid starts` pop 61 |
| Long-tail diff=5 disponível | `papinha *` | — | — |

**Insight:** os termos em inglês (`blw`, `solid starts`, `starting solids`) têm volume real nos 3 mercados — não tratar como exclusivos do US. O gargalo universal é **rating (1 review)**.

## Próximos passos
1. ✅ Análise consolidada neste `.md` (formato GOLD)
2. ⏳ Aplicar diffs em `aso-pipeline/current/metadata/{en-US,pt-BR,es-ES}/` (+ replicar es-ES→es-MX)
3. ⏳ `release_notes.txt` (1.2.0) em todos os locales antes do sync
4. ⏳ `fastlane sync_metadata` junto do build 1.2.0
5. ⏳ Disparar `in_app_review` mais cedo — alavanca #1
