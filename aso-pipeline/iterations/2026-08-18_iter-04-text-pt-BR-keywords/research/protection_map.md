# Mapa de proteção — composições rankeadas ≤30 e os tokens que as sustentam

Fonte dos ranks: LIVE 1.5.1 (asc_state.json) + astro/SERPs 2026-08-18. Regra dura pro field-composer:
**nenhum token listado abaixo pode sair do campo onde está** sem aceitar perder a composição correspondente.

Campos LIVE 1.5.1:
- **pt-BR** · name `Introdução Alimentar BLW Baby` · subtitle `Papinha, Receitas Solid Starts` · kw `papinha caseira,papinha 6 meses,receitas papinha,baby weaning,baby feeding,desengasgo,cortes seguros`
- **en-US** · name `BLW Baby Led Weaning Tracker` · subtitle `First Foods & Solid Starts Log` · kw `starting solids,weaning,puree,feeding,recipes,allergen,infant,toddler,nutrition,meal plan,6 month`
- **es-ES/MX** · name `Alimentación Complementaria` · subtitle `BLW, Comida Bebé y Papillas` · kw `blw,starting solids,solid starts,baby led weaning,destete,recetas,sólidos,alérgenos,lactancia`

Nota de indexação cruzada: a store **br** indexa pt-BR + en-US; a **us** indexa en-US (+es-MX); a **es** indexa es-ES + en-US. Várias composições br/es dependem de tokens do set **en-US** — mexer no en-US afeta as 3 stores.

## BR (store br)

| Composição | Rank | Tokens protetores → campo |
|---|---|---|
| blw baby | #1 | blw, baby → name pt-BR |
| blw tracker baby led | #1 | blw, baby → name pt-BR; led, tracker → name en-US |
| papinha caseira | #1 | papinha → subtitle pt; caseira → kw pt |
| receitas de papinha caseira | #1 | receitas, papinha → subtitle pt; caseira → kw pt |
| desengasgo | #1 | desengasgo → kw pt |
| papinha | #2 | papinha → subtitle pt |
| cortes seguros | #2 | cortes, seguros → kw pt |
| blw 6 meses | #3 | blw → name pt; 6, meses → kw pt ("papinha 6 meses") |
| blw baby introdução | #3 | name pt inteiro |
| blw cortes | #3 | blw → name pt; cortes → kw pt |
| introdução alimentar 6/7 meses | #3 | introdução, alimentar → name pt; 6 meses → kw pt |
| papinha 6 meses | #3 | kw pt exata + subtitle |
| receitas 6 meses | #3 | receitas → subtitle pt; 6 meses → kw pt |
| introdução alimentar blw | #4 | name pt inteiro |
| receitas papinha | #5 | kw pt exata + subtitle pt |
| led weaning | #6 | led, weaning → name en-US |
| introdução alimentar receitas | #6 | name pt + subtitle pt |
| baby introdução alimentar | #7 | name pt |
| blw tracker | #7 | blw → name pt; tracker → name en-US |
| baby introdução | #8 | name pt |
| blw receitas | #10 | name pt + subtitle pt |
| weaning tracker | #10 | weaning, tracker → name en-US |
| introdução | #12 | name pt |
| app introdução alimentar | #16 | name pt (token "app" vem do buscador, não compor) |
| introdução alimentar (HEAD) | #17 | name pt |
| baby led weaning | #17 | name en-US |
| starting solids | #18 | kw en-US "starting solids" |
| weaning | #18 | kw pt "baby weaning" + name/kw en-US |
| solid starts baby first foods | #20 | solid, starts → subtitle pt; first, foods → subtitle en-US |
| weaning recipes | #20 | weaning, recipes → kw en-US |
| blw meals | #23 | blw → name pt; meal → kw en-US "meal plan" |
| baby weaning | #24 | kw pt frase exata + name en-US |
| start solid food | #28 | subtitle pt (starts→start) + kw en-US |

## US (store us)

| Composição | Rank | Tokens protetores → campo |
|---|---|---|
| weaning | **#3-4** | weaning → name en-US (crown jewel — defender acima de tudo) |
| blw for beginners | #15 | blw → name en-US |
| baby led weaning | #16 | name en-US exato |
| baby led weaning food list | #19 | name en-US + foods → subtitle en-US |
| starting solids | #22 | kw en-US "starting solids" |
| baby weaning | #22 | baby, weaning → name en-US |
| baby led weaning family meals | #23 | name en-US + meal → kw "meal plan" |
| blw | #30 | blw → name en-US |

## ES (store es)

| Composição | Rank | Tokens protetores → campo |
|---|---|---|
| alimentación complementaria bebé | #2 | alimentación, complementaria → name es; bebé → subtitle es |
| alimentación complementaria recetas | #2 | name es + recetas → kw es |
| app alimentación complementaria | #3 | name es (não compor "app") |
| alimentación complementaria (HEAD) | #4 | name es exato |
| mi alimentación complementaria | #4 | name es |
| recetas blw bebé | #8 | recetas → kw es; blw, bebé → subtitle es |
| recetas papillas bebé | #8 | recetas → kw es; papillas, bebé → subtitle es |
| recetas de papillas | #9 | kw es + subtitle es |
| baby led weaning español | #10 | kw es "baby led weaning" |
| blw recetas | #11 | blw → subtitle es; recetas → kw es |
| destete bebé | #11 | destete → kw es; bebé → subtitle es |
| blw bebé | #12 | subtitle es |
| weaning | #14 | kw es "baby led weaning" + name en-US |
| starting solids | #15-16 | kw es "starting solids" + kw en-US |
| baby weaning | #18 | kw es "baby led weaning" + name en-US |
| baby led weaning | #22 | kw es exata |
| blw meals | #26 | blw → subtitle es; meal → kw en-US |

## Tokens intocáveis (resumo por campo)

- **name pt-BR**: introdução, alimentar, blw, baby — todos protegem #1-17.
- **subtitle pt-BR**: papinha, receitas (protegem #1-10). "Solid Starts" protege só #20 (br) e está LOTTERY/UNWINNABLE como alvo — é o único par do subtitle pt com folga pra troca, ao custo do #20.
- **kw pt-BR**: papinha caseira, papinha 6 meses, receitas papinha, baby weaning, desengasgo, cortes seguros — todos protegem #1-24. `baby feeding` é o único token pt sem composição rankeada (feeding = mamadas na SERP) → **único slot livre de verdade**.
- **name en-US**: todos os 5 tokens protegem #3-30 nas TRÊS stores. Não tocar.
- **subtitle en-US**: first, foods, solid, starts, log — protegem #19-53 + composições br. `log` só protege solids log #53 (folga relativa).
- **kw en-US**: starting solids, weaning, recipes, meal plan, puree, allergen, 6 month protegem composições; `feeding`, `infant`, `toddler`, `nutrition` não protegem nada rankeado ≤30 → **slots livres**.
- **name es**: os 2 tokens protegem #2-8. Não tocar.
- **subtitle es**: blw, bebé, papillas protegem #8-26; `comida` não protege nada ≤30 (comida* está OUT) → folga.
- **kw es**: recetas, destete, baby led weaning, starting solids protegem; `solid starts`, `sólidos`, `alérgenos`, `lactancia` não protegem nada rankeado → **slots livres** (lactancia é inclusive off-scope).
