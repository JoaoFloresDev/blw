# BLW Baby — iter-02 en-US: keyword candidates (2026-08-06)

**Data:** 2026-08-06 · **Source:** Astro MCP live (91 termos trackeados, store us) + competitor-intel scrape (top 3)
**Filtro de decisão (quadrante):** diff ≤ 20 (any pop) = gold · diff 21-40 + pop ≥ 10 = sweet spot · diff 41-60 só com pop ≥ 25 · diff > 60 só com pop ≥ 40 no name

| Campo | Peso | Estratégia |
|-------|------|-----------|
| name | 7× | NÃO mexer nesta iter — "BLW Baby Led Weaning Tracker" já entrega blw/baby/weaning/tracker |
| subtitle | 3× | Manter as 2 âncoras (Solid Starts, First Foods) e trocar o token morto `Log` por `100` |
| keywords | 1× | Demolir os 7 tokens mortos (OUT, diff 45-79) e reconstruir com hub `food` + moats de feature diff 5-24 |

**Princípio:** nunca duplicar termo entre campos — Apple indexa na primeira ocorrência; dup = char desperdiçado.
**Caveat Astro:** `pop=5` é o PISO do Astro (volume abaixo do detectável). Termos pop=5 são aposta de cauda, não volume confirmado.

---

## 📐 Diff visual — antes/depois

Legenda: <span style="color:#dc3545">🔴 saiu</span> · <span style="color:#28a745">🟢 entrou novo</span> · <span style="color:#3b82f6">🔵 subiu de peso</span> · <span style="color:#1e3a8a">🔵 desceu de peso</span> · preto = mantém

| Campo | Antes | Depois |
|-------|-------|--------|
| Name | BLW Baby Led Weaning Tracker | BLW Baby Led Weaning Tracker |
| Subtitle | First Foods & <b>Solid Starts</b> <span style="color:#1e3a8a">Log</span> | <b>Solid Starts</b> & First <span style="color:#28a745">100</span> Foods |
| Keywords | starting solids, <span style="color:#dc3545">weaning</span>, puree, <span style="color:#dc3545">feeding</span>, <span style="color:#dc3545">recipes</span>, <span style="color:#dc3545">allergen</span>, <span style="color:#dc3545">infant</span>, <span style="color:#dc3545">toddler</span>, <span style="color:#dc3545">nutrition</span>, <span style="color:#dc3545">meal plan</span>, 6 month | <span style="color:#28a745">meals</span>, <span style="color:#28a745">start</span>, <span style="color:#28a745">introducing</span> solids, <span style="color:#28a745">food</span>, <span style="color:#28a745">diary</span>, <span style="color:#28a745">allergy</span>, <span style="color:#1e3a8a">log</span>, <span style="color:#28a745">finger</span>, <span style="color:#28a745">101</span>, <span style="color:#28a745">cut</span>, 6 month, starting, puree, <span style="color:#28a745">list</span> |

---

## 🏷 NAME — "BLW Baby Led Weaning Tracker" (28/30) — INALTERADO

| Palavra | Pop | Diff | Rank atual | Decisão |
|---------|-----|------|-----------|---------|
| `blw` | 19 | 17 | 28 | ✅ mantém — brand term do nicho, subindo |
| `baby` | 52* | 57 | — | mantém (só compõe; solo é ingénuo) |
| `led` | — | — | — | mantém (parte de baby led weaning r17) |
| `weaning` | 15 | 13 | 25 | ✅ mantém — head ganhável, já top-25 |
| `tracker` | 43* | 42 | OUT solo | mantém (compõe weaning tracker r5, solid starts tracker r28) |

*pop de termo solo genérico — não ganhável isolado, valor é composição.

Não mexer: o name carrega 5 composições top-30 hoje (blw baby #1, blw tracker baby led #4, weaning tracker #5, weaning log #5, baby led weaning #17). Mexer em name arrisca 5 rank-protects por ganho especulativo.

---

## 🏷 SUBTITLE — de "First Foods & Solid Starts Log" para "Solid Starts & First 100 Foods" (30/30)

Palavra-por-palavra do atual:

| Palavra | Pop | Diff | Rank atual | Decisão |
|---------|-----|------|-----------|---------|
| `first` + `foods` | 5-8 | 13-17 | first foods OUT · baby first foods 166 | mantém (âncora 2) |
| `solid` + `starts` | **61** | 41 | **50 (↑4)** | 🥇 mantém — o maior termo do nicho, nossa interceptação |
| `log` | 5 | 13-24 | weaning log 5 · solid starts log 27 | 🔵 desce pro keywords field (volume piso, não merece 3×) |

### ENTROU

| Termo | Pop | Diff | Rank atual | Por quê |
|-------|-----|------|-----------|---------|
| `100` → "first 100 foods" / "100 first foods" | 5 | **11** | OUT | 🥇 Convenção do nicho criada pelo Solid Starts ("First 100 Foods guide"); nosso 1.5.0 implementa a jornada 0/100 NATIVA (progresso no diário + 100 alimentos aos 6m). Termo virgem, diff 11, e vira posicionamento de produto — o print 1 dos nano prints vai gritar isso |

### SAIU / MUDOU DE LUGAR

| Termo | Pop | Diff | Rank | Por quê |
|-------|-----|------|------|---------|
| `log` | 5 | 13 | weaning log r5 | Vai pro keywords field (peso 1× preserva as composições r5/r27 sem gastar slot 3×) |

Ordem invertida ("Solid Starts" primeiro): front-load do termo pop-61 no campo peso 3×.

---

## 🔑 KEYWORDS FIELD — de 97 chars (7 tokens mortos) para 100/100

### SAIU

| Termo | Pop | Diff | Rank | Por quê |
|-------|-----|------|------|---------|
| `weaning` | 15 | 13 | 25 | ❌ DUP do name — char queimado à toa (rank vem do name) |
| `feeding` | 13 | 62 | OUT | ❌ morto — diff 62, solo OUT |
| `recipes` | 53 | 70 | OUT | ❌ morto solo — composições recipes (r20-42, pop 5) podem cair; risco aceito, ver Riscos #3 |
| `allergen` | 5 | 45 | OUT | ❌ morto — trocado por `allergy` (família com diff 5-21) |
| `infant` | 13 | 47 | OUT | ❌ morto |
| `toddler` | 8 | 79 | OUT | ❌ morto |
| `nutrition` | 7 | 71 | OUT | ❌ morto |
| `meal plan` | 27 | 67 | OUT | ❌ morto — pop bonito, diff proibitivo |

### ENTROU

| Termo | Pop | Diff | Rank hoje | Por quê |
|-------|-----|------|-----------|---------|
| `start` | **9** | 19 | start solids **84** | 🥈 "start" ≠ "starting" no índice; cobre start solids pop 9 + when to start solids |
| `101` | **9** | 30 | 101 before one OUT | 🥈 Marca do #4 com só **29 apps** rankeando ("before"/"one" = stopwords ignoradas — o token 101 basta) |
| `meals` | **9** | 23 | blw meals OUT | 🥈 blw(name)+meals = "blw meals" pop 9 — brand do #2 do nicho, interceptação barata |
| `introducing` (+solids) | 5 | **7** | OUT | 🥇 "introducing solids" tem só **33 apps rankeando** — nicho quase vazio, frase natural do público |
| `food` | (hub) | 5-43 | — | 🥇 HUB: destrava "baby food diary/log/chart/list/allergies/6 months" (6 caudas diff 5-43) que hoje não compõem por falta do singular |
| `diary` | 5 | 11 | baby food diary OUT | 🥇 feature real (tab principal) + diff 11 |
| `allergy` | 5 | **5** | allergy log baby 121 | 🥇 allergy+log+baby: diff 5 — nosso rastreio de alérgenos é feature de verdade agora |
| `finger` | 5 | 7-11 | baby finger foods 121 | 🥇 finger+foods(subtitle): família finger foods, diff 7-11 |
| `cut` | 5 | 21 | how to cut food for baby 174 | Apple ignora stopwords: cut+food+baby cobre "how to cut food for baby" — nossa killer feature (cortes por idade) |
| `list` | 5 | 15 | baby food list 159 | food+list: checklist de alimentos |

### MANTÉM

| Termo | Pop | Diff | Rank | Por quê |
|-------|-----|------|------|---------|
| `starting` (+solids) | 8-9 | 19 | **19** | ✅ rank-protect — starting+solids segue compondo r19 |
| `6 month` | 5 | 21 | 45 | idade âncora, compõe baby food 6 months r89 |
| `puree` | 5 | 13 | 65 | barato (5 chars), rankeando |
| `log` | 5 | 13 | r5/r27 | 🔵 desceu do subtitle — preserva weaning log r5, solid starts log r27, allergy log |

### CASE-FIX / BUGS
Nenhum bug de caps/truncamento no campo atual (o `beb` truncado era do pt-BR, corrigido na iter-01).

---

## 📋 Ordenação dos keywords (front-loading)

| Pos | Token | Pop (termo alvo) | Diff | Bucket |
|-----|-------|------------------|------|--------|
| 1 | meals | **9** (blw meals) | 23 | confirmed-pop |
| 2 | start | **9** (start solids) | 19 | confirmed-pop |
| 4 | introducing solids | 5 | 7 | gold apps-33 |
| 5 | food | hub | — | hub de composição |
| 6 | diary | 5 | 11 | feature moat |
| 7 | allergy | 5 | 5 | feature moat |
| 8 | log | 5 | 13 | rank-protect |
| 9 | finger | 5 | 7-11 | gold |
| 10 | 101 | **9** (101 before one) | 30 | confirmed-pop / brand |
| 11 | cut | 5 | 21 | feature moat |
| 12 | 6 month | 5 | 21 | rank-protect (r45) |
| 13 | starting | 8 | 19 | rank-protect (r19) |
| 14 | puree | 5 | 13 | rank-protect (r65) |
| 15 | list | 5 | 15 | speculation |

---

## 📄 Resultado final

```
name      (28/30):  BLW Baby Led Weaning Tracker
subtitle  (30/30):  Solid Starts & First 100 Foods
keywords (96/100): meals,start,introducing solids,food,diary,allergy,log,finger,101,cut,6 month,starting,puree,list
```

## Cobertura por cluster (peso composto: name 7× + subtitle 3× + kw 1×)

| Cluster | name | subtitle | kw | Total |
|---------|------|----------|-----|-------|
| blw / baby led weaning | 7× | — | — | 7× |
| solid starts (marca líder) | — | 3× | — | 3× |
| first 100 foods (jornada) | — | 3× | — | 3× |
| tracker / diary / log | 7× (tracker) | — | 1× (diary, log, list) | 8× |
| introdução (introducing/starting solids) | — | — | 1×+1× | 2× |
| segurança (allergy, cut, finger, bites) | — | — | 4×1× | 4× |
| receitas/meals | — | — | 1× | 1× |
| idade (6 month, stage 1) | — | — | 2×1× | 2× |

## Termos protegidos (verificar pós-deploy)

| Termo | Rank hoje | Proteção |
|-------|-----------|----------|
| blw baby | 1 | name intacto |
| baby led weaning tracker | 2 | name intacto |
| weaning tracker / weaning log | 5 / 5 | name + `log` preservado no kw |
| baby led weaning | 17 | name intacto |
| starting solids | **19** | `starting` mantido + solids via "introducing solids" |
| blw | 28 | name intacto |
| solid starts | **50** | subtitle intacto (âncora) |
| 6 month | 45 | mantido |
| puree | 65 | mantido |

---

## 🎯 Hipótese formal (→ meta.json)

> **If we change** o subtitle para "Solid Starts & First 100 Foods" e o keywords field para o set de 14 tokens acima, **then** impressions US ↑ ≥30% e downloads globais ↑ ≥25% em 30 dias (12.8 → ≥16), **because** (a) "first 100 foods" diff 11 entra peso 3× com feature nativa; (b) hub `food` destrava 6 caudas "baby food *"; (c) 60+ chars de tokens mortos (diff 45-79, todos OUT) viram 13 termos ganháveis diff 5-24; (d) rank-protects preservados por token.

## ⚠️ Riscos identificados

1. **"Solid Starts" é marca registrada do líder.** Já está live no nosso subtitle desde jun/2026 sem complaint, mas um trademark complaint da SolidStarts LLC derrubaria a âncora (rank 50, pop 61). Mitigation: monitorar e-mail de complaints; plano B pronto ("Starting Solids & 100 First Foods").
2. **Pop=5 em 8 dos 15 tokens** (rebalanceado: 4 jogadas de pop confirmado 9-27 na frente) — parte da tese é cauda de volume não-detectável. Mitigation: os moats casam com features reais (conversão alta quando acham) e o custo é zero (chars que estavam mortos).
3. **Perda de `recipes` token**: blw recipes r30 / weaning recipes r42 / baby led weaning recipes r20 podem cair (composição vinha do token `recipes`). Aceito: pop 5 nos três, e "meals" cobre o cluster refeições com upside maior (blw meals pop 9). Se Day 14 mostrar queda relevante, re-incluir `recipes` na iter-03 (custa 7 chars).
4. **Reshuffle da Apple** (vimos baby food tracker 27→1000 em 24h): ranks pop-5 são voláteis; não reagir a movimento de 1 checkpoint isolado.

## ⏱ Timeline + tempo do dev

| Fase | Dias | O que acontece |
|------|------|----------------|
| Apple Review (junto com 1.5.0) | D0-3 | metadata entra com o binário |
| Index propagation | D3-5 | Apple reindexa tokens |
| Initial stabilization | D5-7 | ranks novos oscilam forte |
| First reliable signal | D7-14 | tendência real aparece |
| Statistically significant | D14-21 | comparável ao baseline |
| Decision day | D28 | promote / rollback / extend |

| Checkpoint | Tempo do dev |
|------------|--------------|
| Day 0 (deploy + baseline) | ~10 min |
| Day 7 | ~15 min (olhar ranks protegidos + downloads) |
| Day 14 | ~30-45 min (tendência + rascunho iter-03) |
| Day 21 | ~30 min |
| Day 28 | ~1-2h (decisão + registro) |
| **Total** | **~3-4h em 28 dias** |

**NÃO analisar antes do Day 7 — é ruído pré-efeito.**

## 📈 Projeção quantitativa (Day 28)

**Premissas:** baseline 12.8 dl/dia global (US é fração — estimo 30-40%); CR 3-5%; impressions US baseline ≈ 100-160/dia (derivado). Heurística de impressions por termo: `pop × (101 − rank) / 100`.

| Bucket | Termos | Rank D0 → projeção D28 | Δ impressions/dia |
|--------|--------|------------------------|-------------------|
| 🥇 GOLD | first 100 foods (d11), introducing solids (d7), allergy log (d5), finger foods família (d7-11) | OUT → top 30-60 | +8 a +15 |
| MOVE UP | `100` no subtitle 3× | — | (contado acima) |
| RANK-PROTECT | starting solids r19, solid starts r50, weaning r25, blw r28, 6 month r45 | mantêm ±10 | 0 (defensivo) |
| MOAT speculation | cut, bites, stage 1, list, diary (pop=5 piso) | OUT → 50-150 | +3 a +10 (se pop real > piso) |
| PERDAS ESPERADAS | recipes composições (r20-42, pop 5) | caem 30-80 posições | −1 a −3 |
| UPSIDE marca | blw meals OUT → top 40 (pop 9) · 101 before one OUT → top 30 (29 apps) | | +3 a +7 |
| 🥇 CONFIRMED-POP | start solids (pop 9): 84 → top 40 | | **+3 a +8** |

| Cenário | Δ impressions/dia US | Downloads/dia global |
|---------|----------------------|----------------------|
| Pessimista | +5 (só protects seguram) | 12.5-13.5 (~flat) |
| Realista | +20-35 | **15-18** |
| Otimista | +50+ ("100 foods" pega + prints novos juntos) | 19-23 |

**Probabilidades:** bater conservador (≥16): **~75%** · bater bold (≥19.2): **~45%** · rollback (−30%): **<8%** (mudança preserva todos os protects).

**Trajetória esperada (dl/dia global):**
```
D0   12.8  ████████░░░░
D7   13.2  ████████░░░░  (ruído)
D14  14.5  █████████░░░
D21  15.8  ██████████░░
D28  16.5  ███████████░
```

**Sinais por checkpoint:**

| Day | SUCESSO (continuar/escalar) | FALHA (atenção/rollback) |
|-----|------------------------------|--------------------------|
| 7 | protects estáveis (±10); first 100 foods aparece ≤300 | solid starts > 100; downloads ↓ 30% |
| 14 | first 100 foods ≤ 60; allergy log ≤ 60; downloads ≥ 14 | 3+ protects caindo >30 posições; downloads < 11 |
| 21 | downloads ≥ 15; algum gold top-30 | flat em tudo com impressions flat |
| 28 | ≥ 16 dl/dia = promote; ≥ 19.2 = escalar agressivo iter-03 | < 16 = reformular (avaliar recipes de volta + es-ES) |

## 🎲 Confidence breakdown

| Premissa | Confidence | Impacto se errada |
|----------|-----------|-------------------|
| "first 100 foods" tem volume real acima do piso | 55% | Perde o headline da tese; resto segura |
| Hub `food` compõe as 6 caudas baby food * | 80% | −1/3 do upside |
| Rank-protects seguram com tokens preservados | 85% | Downside real (raro: Apple reindexa tudo) |
| Perder `recipes` custa pouco (pop 5) | 75% | −2-3 impressions/dia, recuperável iter-03 |
| CR não degrada (subtitle segue claro) | 90% | Subtitle novo é até mais "produto" |
| **Agregada** | **~70%** de bater o conservador | |
