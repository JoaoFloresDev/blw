# Mapa de proteção — iter-05 BLW (2026-08-19)

Composições rankeadas ≤#30 e o token que as sustenta. **Token protetor NUNCA sai do campo sem substituto equivalente.**
Nota de mecânica: a loja BR indexa pt-BR **+ en-US** (comprovado: "baby led weaning" #13 e "blw tracker" #5 no BR sem "led"/"tracker" nos campos pt-BR — vem do name en-US). Logo os campos en-US também protegem composições BR.

## Campos LIVE (referência)
| Locale | Name | Subtitle | Keywords |
|---|---|---|---|
| pt-BR | Introdução Alimentar BLW Baby | Papinha, Receitas Solid Starts | papinha caseira,papinha 6 meses,receitas papinha,baby weaning,baby feeding,desengasgo,cortes seguros |
| en-US | BLW Baby Led Weaning Tracker | First Foods & Solid Starts Log | starting solids,weaning,puree,feeding,recipes,allergen,infant,toddler,nutrition,meal plan,6 month |
| es-ES (=es-MX) | Alimentación Complementaria | BLW, Comida Bebé y Papillas | blw,starting solids,solid starts,baby led weaning,destete,recetas,sólidos,alérgenos,lactancia |

## BR (loja br)
| Composição | Rank | Token(s) protetor(es) — campo |
|---|---|---|
| blw baby | #1 | name: `blw`+`baby` |
| papinha caseira | #1 | sub: `papinha` + kw: `caseira` |
| desengasgo | #1 (ÚNICO resultado da busca) | kw: `desengasgo` |
| receitas de papinha caseira | #1 | sub: `receitas`+`papinha` + kw: `caseira` |
| papinha | #2 | sub: `papinha` |
| cortes seguros | #2 | kw: `cortes`+`seguros` |
| blw 6 meses | #2 | name: `blw` + kw: `6`+`meses` |
| blw tracker baby led / led weaning | #2 | name en-US: `led`+`weaning`+`tracker` (cross-locale) |
| papinha 6 meses | #3 | kw: `papinha 6 meses` |
| introdução alimentar 6/7 meses | #3 | name + kw: `6`+`meses` |
| receitas 6 meses | #3 | sub: `receitas` + kw: `6`+`meses` |
| blw baby introdução / blw cortes | #3 | name + kw: `cortes` |
| introdução alimentar blw | #4 | name completo |
| receitas papinha / receitas introdução alimentar / introdução alimentar receitas | #5 | sub: `receitas`+`papinha` + name |
| blw tracker | #5 | name: `blw` + name en-US: `tracker` |
| baby introdução alimentar | #6 | name: `baby`+`introdução`+`alimentar` |
| baby introdução | #7 | name |
| weaning tracker | #8 | kw: `weaning` + name en-US: `tracker` |
| introdução alimentar e blw | #8 | name |
| blw receitas | #10 | name: `blw` + sub: `receitas` |
| papinhas | #11 | sub: `papinha` (stem) |
| app introdução alimentar | #12 | name |
| introdução / weaning / starting solids / baby led weaning | #13 | name · kw: `weaning` · sub: `solid starts` (stem) + kw en-US · name en-US |
| solid starts baby first foods | #15 | sub: `solid`+`starts` + sub en-US: `first`+`foods` |
| baby weaning | #15 | kw: `baby weaning` |
| weaning recipes / baby led weaning app | #16 | kw: `weaning` + kw en-US: `recipes` · name en-US |
| start solids | #21 | sub: `starts` (stem) + kw en-US |
| baby first foods | #23 | sub en-US: `first foods` |
| blw meals | #24 | name: `blw` (meals via ?—frágil) |
| baby meals recipes | #25 | tokens en-US |
| baby solids / start solid food | #27 | stems sub/kw en-US |
| baby foods tracker | #28 | name en-US |
| introdução alimentar | #30 | name (core BR — prioridade máxima de push) |

## US (loja us)
| Composição | Rank | Token(s) protetor(es) |
|---|---|---|
| weaning | #4 | name: `weaning` (top3 fraco — prêmio real do US) |
| introdução alimentar | #10 | cross-locale (não mexer nos campos que o sustentam) |
| blw feeding | #15 | name: `blw` + kw: `feeding` |
| baby led weaning / baby led weaning recipes | #17 | name completo + kw: `recipes` |
| starting solids | #18 | kw: `starting solids` + sub: `solid starts` (stem) |
| baby weaning | #24 | name: `baby`+`weaning` |
| blw recipes | #26 | name: `blw` + kw: `recipes` |
| blw | #28 | name: `blw` |
| alimentación complementaria | #3 (US) | name es-MX (cross-locale — es-MX NUNCA deixar de ser cópia com "Alimentación Complementaria") |

## ES (loja es)
| Composição | Rank | Token(s) protetor(es) |
|---|---|---|
| alimentación complementaria | #4 | name exato |
| alérgenos bebé | #5 | kw: `alérgenos` + sub: `bebé` |
| recetas de papillas / recetas bebé blw | #8 | kw: `recetas` + sub: `papillas`/`bebé`+`blw` |
| destete | #10 | kw: `destete` |
| blw recetas | #10 | sub: `blw` + kw: `recetas` |
| destete bebé / papillas | #11 | kw: `destete` + sub: `bebé` · sub: `papillas` |
| sólidos bebé / papillas bebé | #14 | kw: `sólidos` + sub: `bebé`/`papillas` |
| baby led weaning app | #15 | kw: `baby led weaning` |
| starting solids | #16 | kw: `starting solids` |
| baby weaning | #18 | kw: `baby led weaning` (parcial) |
| baby led weaning | #20 | kw: `baby led weaning` |
| blw meals | #22 | sub: `blw` |
| alimentación bebé | #25 | name: `alimentación` + sub: `bebé` |
| recetas bebé / alérgenos | #29 | kw: `recetas`+sub `bebé` · kw: `alérgenos` |

## Tokens INTOCÁVEIS por locale (resumo pro composer)
- **pt-BR**: name inteiro (`introdução alimentar blw baby`) · sub: `papinha`, `receitas`, `solid starts` · kw: `desengasgo`, `cortes`, `seguros`, `caseira`, `6`, `meses`, `weaning`, `baby`
- **en-US**: name inteiro (`blw baby led weaning tracker`) · sub: `first foods`, `solid starts`, `log`(barato) · kw: `starting solids`, `recipes`, `feeding`(protege blw feeding #15), `6 month`(borderline, #42)
- **es-ES/es-MX**: name inteiro (`alimentación complementaria`) · sub: `blw`, `comida`, `bebé`, `papillas` · kw: `starting solids`, `solid starts`, `baby led weaning`, `destete`, `recetas`, `sólidos`, `alérgenos`

## Tokens SEM composição rankeada (candidatos a corte/troca — decisão do composer)
- **pt-BR kw**: `feeding` (baby feeding tracker #122, retorno baixo — cortável se precisar de chars; `baby` é protegido por outras comps)
- **en-US kw**: `puree` (#60, pop 5 → ~zero tráfego), `infant`, `toddler`, `nutrition`, `allergen`, `meal plan`, `weaning` (DUP do name — char desperdiçado) → todos cortáveis
- **es-ES kw**: `lactancia` (nada rankeado, intent de amamentação), `blw` (DUP do subtitle) → cortáveis

## Lacunas de token (o que FALTA pra destravar DOMINATEs baratos)
- **pt-BR: `bebe`** — nenhum campo pt-BR tem "bebê"; a família inteira `* bebê` está órfã (introdução alimentar bebê → SERP fraco, top1 com 19r; desengasgo bebê; papinha bebê; blw bebê). 1 token destrava ~6 composições top-5.
- **en-US: `ideas`** — "blw ideas" pop 39, marca fraca na loja US (34r); 1 token → composição com `blw` do name.
- **es-ES: `ideas`** — "blw ideas" pop 54 ES; meio de SERP fraco.
- **en-US: `guide`** — "weaning guide" #35 com name `weaning`; token barato pra top 10.
