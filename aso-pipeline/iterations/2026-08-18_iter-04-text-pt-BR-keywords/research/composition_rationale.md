# Composição final — iter-04 (2026-08-18)

Base: LIVE 1.5.1 (a editable 1.5.2 carrega iter-03 e é SUPERSEDED por esta composição).
Fontes: `protection_map.md`, `serp_winnability_{br,us,es}.csv`, `term_fit_*.csv`. Char counts validados com `len()` Python.

## pt-BR

**name** — sem mudança (`Introdução Alimentar BLW Baby`, 29). Todos os 4 tokens protegem #1-17 (br).

**subtitle** — `Papinha, Receitas Solid Starts` → `Papinha, Receitas e Weaning` (27)

| Token | Ação | Motivo |
|---|---|---|
| papinha | MANTÉM | protege #1 papinha caseira, #2 papinha, #3 papinha 6 meses |
| receitas | MANTÉM | protege #1 receitas de papinha caseira, #3 receitas 6 meses, #5 receitas papinha |
| solid, starts | SAIU | único par do subtitle pt com folga (protegia só br #20/#28) e a cobertura FICA: subtitle en-US "First Foods & Solid Starts Log" tem solid+starts e a store br indexa en-US — composições #20/#28 continuam cobertas. Custo aceito pelo coordenador. |
| weaning | ENTROU | direção do serp-analyst: promover `baby weaning` (CLIMB #1 br, pop 25 diff 5) de peso. baby(name pt) + weaning(subtitle pt) compõe com peso name/subtitle >> kw. Também sobe weaning solo (br #18, pop 16 diff 5). |

**keywords** — 100/100
`starting solids,bebe,guia,papinha caseira,papinha 6 meses,receitas papinha,desengasgo,cortes seguros`

| Token | Ação | Motivo |
|---|---|---|
| baby weaning | SAIU do kw (coberto via name+subtitle) | frase promovida: baby→name, weaning→subtitle. Composição #24 br preservada com MAIS peso (e name en-US também cobre). Não é corte de proteção, é upgrade de campo. |
| baby feeding | SAIU | slot livre confirmado — zero composição rankeada (feeding = mamadas na SERP). OUT sem retorno. |
| starting solids | ENTROU (aposta 1) | CLIMB br #18 → top 8-10, pop 28 diff 5, SERP fraquíssima (SS 57 ratings no br). Hoje só indexa via kw en-US; frase exata no pt adiciona peso de locale na store br. |
| bebe | ENTROU (aposta 2) | feeder: destrava composições OUT/CLIMB diff≤17 — introdução alimentar bebê (13), papinha bebê (5), alergia alimentar bebê (11), receitas bebê 6 meses (5), comida caseira bebê (9), primeiros... — "top 10 se token entrar". Sem acento (iOS normaliza bebê=bebe). |
| guia | ENTROU (aposta 3) | feeder 4-chars: guia blw (9), guia introdução alimentar (12), guia baby led weaning (5) — 3 composições CLIMB "top 10 se token entrar". |
| papinha caseira / papinha 6 meses / receitas papinha | MANTÉM | mapa de proteção: #1 / #3 / #5. Frases exatas ficam como estão (regra 1). |
| desengasgo | MANTÉM | #1, zero competição. |
| cortes seguros | MANTÉM | #2, SERP com 6 resultados. |

Front-loading: starting solids (CLIMB pop 28) → bebe, guia (feeders de bets) → frases protegidas (#1-5, rank não depende de posição).

Warning 27/30 no subtitle justificado: os 3 chars não cabem nenhum token honesto — blw/baby dupariam o name pt (blocker), e qualquer outro seria filler (regra 5).

## en-US

**name/subtitle** — sem mudança. Name protege #3-30 nas 3 stores (weaning #3-4 US = crown jewel). Subtitle: first/foods/solid/starts/log protegem #19-53 + composições br; regra 7 não disparou (nenhum dup exato no subtitle).

**keywords** — 91/100
`starting solids,introduction,finger food,guide,100,puree,recipes,allergen,meal plan,6 month`

| Token | Ação | Motivo |
|---|---|---|
| feeding, infant, toddler, nutrition | SAÍRAM | slots livres confirmados — nenhuma composição rankeada ≤30. OUT sem retorno. 33 chars liberados. |
| weaning | SAIU do kw | dup exato do name en-US ("...Led Weaning Tracker") — blocker do validador (regra 4: Apple já indexa do name a 7x). O resumo do mapa listava o token no kw, mas TODA composição com weaning cita o name en-US como protetor (us #3-4, br #18/#24) — cobertura integral pelo name, zero perda. 8 chars reinvestidos. |
| introduction | ENTROU (aposta 1) | feeder ≥3 CLIMB: food introduction tracker (diff 5), solid food introduction (9), allergen introduction tracker (15), introduction to solids (#192, diff 9) — "top 10 se token entrar". |
| finger food | ENTROU (aposta 2) | finger food recipes (diff 11, CLIMB top 10 se entrar; recipes já no kw). O token `food` amplifica a aposta 1 (food introduction tracker, solid food introduction) e compõe food allergen log (diff 5, allergen kw + log subtitle) de graça. |
| guide | ENTROU (aposta 3) | weaning guide JÁ #37 diff 7 → top 18 (weaning no name) + starting solids guide diff 11 top 10 se entrar. 2 composições CLIMB por 5 chars. |
| 100 | ENTROU (aposta 4, 3 chars) | 100 foods baby #175 diff 7 (all-field-tokens com 100: name baby + subtitle foods) — term_fit: "feature central do diário". Endossada pelo coordenador ("en 100/..."). Estica o cap de ~3 pra 4 porque a saída forçada do dup weaning liberou 8 chars e esta custa 3. |
| starting solids | MANTÉM | protegido (br #18, us #22); CLIMB "promover peso" → front-loaded. |
| puree, recipes, allergen, meal plan, 6 month | MANTÉM | mapa de proteção (puree tracker #51, weaning recipes #20 br, blw meals #23 br/#26 es, papinha 6 meses cross, etc.). |

Aposta considerada e descartada: `choking` — baby choking é PARTIAL (solo bet vetado) com feed único LOTTERY, falha a barra de ≥2 composições; "choking prevention" NÃO existe nos arquivos de research (não invento termo). Warning de 91/100 justificado: os 9 chars restantes não têm token honesto — todo candidato remanescente é dup de name/subtitle (blocker), PARTIAL-solo ou UNWINNABLE. 91 honestos > 100 com token morto (regra 5).

## es-ES (es-MX = cópia)

**name/subtitle** — sem mudança. Name protege #2-8; subtitle blw/bebé/papillas protegem #8-26. `comida` (subtitle) é slot livre mas regra 7 exige dup exato pra reescrever subtitle — não disparou, subtitle fica.

**keywords** — 100/100
`introduccion,guia,atragantamiento,starting solids,baby led weaning,recetas,destete,solidos,alergenos`

| Token | Ação | Motivo |
|---|---|---|
| blw | SAIU | dup exato do subtitle es ("BLW, Comida Bebé...") — iOS não indexa 2x; mapa de proteção atribui as composições blw ao SUBTITLE, não ao kw. 4 chars liberados sem perda. |
| solid starts | SAIU | slot livre confirmado — nenhuma composição rankeada; starting+solids (protegido) segue no kw e solid+starts seguem no subtitle en-US (store es indexa en-US). |
| lactancia | SAIU | off-scope (slot livre confirmado). |
| introduccion | ENTROU (aposta 1) | direção do serp-analyst (diff 5): destrava introducción alergenos (5), introducción de sólidos (5), introducción alimentos bebé (5) — CLIMB "top 10 se token entrar". Também cobre a forma sem acento do head (alimentacion complementaria já DOMINATE via name). |
| atragantamiento | ENTROU (aposta 2) | direção do serp-analyst (diff 5): atragantamiento bebé (bebé no subtitle, all-field-tokens) LOTTERY top 20 se entrar; prevención atragantamiento FIT diff 5 fica semi-coberta (prevencion não coube — anotado). |
| guia | ENTROU (aposta 3) | guía blw (5, blw no subtitle) + guía alimentación complementaria (5, name) — 2 composições CLIMB por 4 chars. |
| sólidos → solidos | MANTÉM (renormalizado sem acento) | era slot livre, mas ganha propósito com a aposta 1: introducción de sólidos (diff 5). |
| alérgenos → alergenos | MANTÉM (renormalizado) | idem: introducción alergenos (diff 5) + registro alergias parcial. |
| starting solids, baby led weaning, recetas, destete | MANTÉM | mapa de proteção: #15-16, #10/#22, #2/#8-11, #11. |

Front-loading: introduccion, guia, atragantamiento (bets) → starting solids/baby led weaning (CLIMB rankeados) → recetas/destete/solidos/alergenos (protect/feeders).

## Mapa de proteção — cobertura pós-composição

Toda composição rankeada ≤30 do mapa continua com todos os tokens em campo:
- br #1-17 (name/subtitle/kw pt intactos exceto o par solid starts → coberto por subtitle en-US); #18 starting solids (kw en + AGORA kw pt); #20/#28 (subtitle en-US); #24 baby weaning (name pt "Baby" + subtitle pt "Weaning" + name en-US); #23 blw meals (name pt + kw en "meal plan").
- us #3-30: name/subtitle en intactos; kw en manteve todos os protetores.
- es #2-26: name/subtitle es intactos; kw es manteve recetas/destete/baby led weaning/starting solids; composições "blw *" seguem pelo subtitle.
