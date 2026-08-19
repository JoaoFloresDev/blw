# Composition rationale — iter-05 BLW (2026-08-19)

Base de comparação: campos **LIVE** em `current/metadata/` (o staged da iter-04 na 1.5.2 foi ignorado como âncora; o deployer sobrescreve).
Modelo de composição: o keywords field é indexado **palavra a palavra** e combinado com name/subtitle — o próprio protection_map lista os protetores em nível de token (`caseira`, `6`, `meses`…), não de frase. Por isso as frases live ("papinha caseira", "papinha 6 meses") foram decompostas: palavra que já está no subtitle não se repete no kw.

---

## pt-BR

Name: `Introdução Alimentar BLW Baby` (mantém — protegido inteiro)
Subtitle: `Papinha, Receitas Solid Starts` (mantém — `papinha`/`receitas`/`solid starts` protegidos; regra 7 não disparou)
Keywords (96/100): `bebe,guia,primeiros,alimentos,alergia,diario,desengasgo,cortes,seguros,caseira,6,7,meses,weaning`

### SAIU
| Token/frase live | Motivo |
|---|---|
| `papinha` (nas 3 frases) | dup do subtitle (3× já pago) — as comps continuam cobertas por sub `papinha` + kw `caseira`/`6`/`meses` |
| `receitas` (em "receitas papinha") | dup do subtitle |
| `baby` (em "baby weaning"/"baby feeding") | dup do name (`BLW Baby`, 7×) — "baby weaning" #15 segue coberto por name `baby` + kw `weaning`; validador bloqueia o token solto |
| `feeding` | única comp = baby feeding tracker #122 (CLIMB #60-90 = zero tráfego); e a loja BR segue indexando `feeding` via kw en-US |

### MANTÉM (protegidos)
| Token | Comp rankeada que sustenta |
|---|---|
| `desengasgo` | desengasgo #1 (único resultado) |
| `cortes`,`seguros` | cortes seguros #2, blw cortes #3 |
| `caseira` | papinha caseira #1, receitas de papinha caseira #1 |
| `6`,`meses` | papinha 6 meses #3, blw 6 meses #2, introdução alimentar 6 meses #3, receitas 6 meses #3 |
| `weaning` | weaning #13→top8, weaning tracker #8, baby weaning #15 |

### ENTROU (apostas)
| Token | Tese (winnability BR) |
|---|---|
| `bebe` | **aposta principal** — destrava a família `* bebê` órfã: introdução alimentar bebê → top3, desengasgo bebê → #1, papinha bebê → top3, blw bebê → top5 (~6 comps DOMINATE) |
| `guia` | guia introdução alimentar / guia blw / guia baby led weaning — 3 comps campo raso → top10 |
| `primeiros`,`alimentos` | primeiros alimentos (top10, ~8 apps), primeiros alimentos bebê (~6 apps), blw primeiros alimentos (~4 apps), registrar alimentos bebê |
| `alergia` | alergia alimentar bebê → top10 (com `bebe` + name `alimentar`), papinha alergia (FIT) |
| `diario` | diário introdução alimentar (~16 apps → top10), 6 meses diário (~1 app) |
| `7` | strengthener 2-chars: introdução alimentar 7 meses #3→#1, papinha 7 meses (campo raso) |

Front-loading: `bebe` (destrava DOMINATEs) → apostas CLIMB (`guia`,`primeiros`,`alimentos`,`alergia`,`diario`) → protegidos por último (rank não depende de posição no campo).

---

## en-US

Name: `BLW Baby Led Weaning Tracker` (mantém) · Subtitle: `First Foods & Solid Starts Log` (mantém)
Keywords (99/100): `starting solids,ideas,guide,meals,recipes,feeding,6 month,alergenicos,intro,texturas,fruta,registro`

### SAIU
| Token | Motivo |
|---|---|
| `weaning` | dup exato do name (char morto) |
| `puree` | #60 com pop 5 → ~zero tráfego, sem comp (LOTTERY "sem retorno") |
| `infant`,`toddler`,`nutrition`,`allergen` | sem composição rankeada ≤#30; todos LOTTERY (diff 42-78) |
| `meal plan` | MISMATCH (NOT-list: sem meal planner) — não pode estar em campo nenhum |

### MANTÉM (protegidos)
| Token | Comp |
|---|---|
| `starting solids` | US #18→#8-12 (pop 29) + BR starting solids #13 (cross-locale) — **front-load** |
| `recipes` | baby led weaning recipes #17→top8, blw recipes #26 + BR weaning recipes #16 (cross-locale) |
| `feeding` | blw feeding #15→top8 + BR baby feeding (cross-locale) |
| `6 month` | #42 borderline, mantido por decisão do protection map |

### ENTROU
| Token | Tese |
|---|---|
| `ideas` | blw ideas pop 39, marca fraca na loja US (34r) → top10-15 — aposta mais valiosa do US |
| `guide` | weaning guide #35 → top10 (name `weaning` + guide) |
| `meals` | analista flagou "falta meals, só se sobrar char" — sobrou: blw meals BR #24→top10 e ES #22→top10 (BR/ES indexam en-US) |
| `alergenicos`,`intro`,`texturas`,`fruta`,`registro` | **tokens hospedados p/ loja BR** (mecânica cross-locale comprovada no protection_map): alergênicos bebê → top5 (3 apps), intro alimentar → top5 (~1 app), texturas bebê (~1 app), fruta 6 meses (~1 app), registro alergia bebê (~5 apps) — todos FIT, SERPs quase vazios, custo zero pro ranking US |

Justificativa do preenchimento: depois dos cortes, o pool US restante é 100% LOTTERY/UNWINNABLE ou já coberto por stems do name/sub — re-encher com `infant/toddler/nutrition` seria devolver token morto. Os chars livres foram convertidos em apostas BR medidas em vez de filler.

---

## es-ES (es-MX = cópia, mesmo name/subtitle live)

Name: `Alimentación Complementaria` (mantém) · Subtitle: `BLW, Comida Bebé y Papillas` (mantém)
Keywords (99/100): `recetas,ideas,meals,6,meses,starting solids,baby led weaning,solid starts,destete,solidos,alergenos`

### SAIU
| Token | Motivo |
|---|---|
| `lactancia` | MISMATCH (NOT-list: sem conteúdo de amamentação), nada rankeado |
| `blw` | dup exato do subtitle (validador bloqueia) |
| acentos (`sólidos`→`solidos`, `alérgenos`→`alergenos`) | iOS normaliza acento — variante acentuada é dup; sem acento economiza risco, mesma indexação |

### MANTÉM (protegidos)
| Token | Comp |
|---|---|
| `recetas` | recetas de papillas #8→top5, blw recetas #10→top5, recetas bebé blw #8 — **front-load** |
| `starting solids` | #16→#8-12 (pop 28, diff 7) |
| `baby led weaning` | baby weaning #18→#8-12 (pop 25, diff 7), baby led weaning app #15 |
| `solid starts` | #40→#20-30 + comps |
| `destete` | destete #10, destete bebé #11 (manter em kw, não promover — ambiguidade desmame) |
| `solidos` | sólidos bebé #14→top8 |
| `alergenos` | alérgenos bebé #5→top3, alérgenos #29 |

### ENTROU
| Token | Tese |
|---|---|
| `ideas` | blw ideas pop 54 (maior aposta ES), meio de SERP fraco → top10-15 |
| `meals` | blw meals ES #22 → top10 (sub `BLW` + meals) — flag do analista "falta meals, só se sobrar char"; direto no campo ES em vez de depender só do cross-locale en-US |
| `6`,`meses` | recetas bebé 6 meses → top3 (3 apps) e papillas 6 meses → top3 (1 app!) — 2 SERPs quase vazios com sub `bebé`/`papillas` |

1 char restante — budget fechado.

---

## Description pt-BR (fix cirúrgico, fora da hipótese)
Linha `• CARDÁPIO SEMANAL…` (promessa MISMATCH — app não tem planner) → `• DICAS DE ESPECIALISTA pra cada fase — quando começar, sinais de prontidão e a diferença entre engasgo e gag` (bate com o inventário: tips quando começar / segurança / engasgo vs gag). Resto intacto.

## Cobertura do mapa de proteção — checklist
- BR: todas as comps ≤#30 seguem cobertas (papinha* via sub+kw decompostos; baby* via name; led/weaning/tracker via name en-US intacto; recipes/starting solids via kw en-US mantidos).
- US: weaning #4 (name), blw feeding #15 (kw feeding), starting solids #18 (kw), alimentación complementaria #3 (name es-MX intacto, es-MX segue cópia).
- ES: todas as comps citam name/sub intactos + kw mantidos (recetas, destete, solidos, alergenos, baby led weaning, starting solids, solid starts).

## Trade-offs declarados
1. **Regra ~3 apostas/locale esticada** (pt-BR 5 famílias + strengthener; en-US 3 US + 5 hospedadas BR) em favor da regra de budget (95-100 sem filler): cada token extra tem linha própria na winnability com SERP quase vazio e verdict FIT — nenhum é high-pop OUT bet.
2. **kw `baby` (pt-BR) não re-entra** apesar de listado como "intocável": o protetor real das comps é o `Baby` do NAME (7×) — token solto no kw seria dup/waste e blocker do validador. Comps conferidas uma a uma.
3. **Frases live decompostas em tokens** (papinha caseira → caseira etc.) — consistente com o modelo token-level do próprio protection_map.

`fields_changed`: keywords (4 locales) + description pt-BR. Name/subtitle: nenhum (regra 7 não disparou em locale algum).
