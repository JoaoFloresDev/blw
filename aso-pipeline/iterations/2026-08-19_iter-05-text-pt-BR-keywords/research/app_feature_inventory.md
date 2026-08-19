# BLW Baby — App Feature Inventory (iter-05, source-verified 2026-08-19)

Fonte primária: `Apps/recovery/flutter/blw/blw/lib/` (1.5.x source) + listing live (`aso-pipeline/current/metadata/`).

## Estrutura real (3 tabs)
1. **Diário** (`food_log_screen`) — registro de refeições
2. **Alimentos** (`foods_screen`) — guia de alimentos
3. **Galeria** (`gallery_screen`) — fotos das refeições

Acessados de dentro: Receitas (`recipes_screen`), Dicas (`tips_screen`), Alergênicos (`allergens_screen`), Detalhe do alimento, Export PDF, Paywall.

## O que o app ENTREGA

### Grátis
- **Diário alimentar completo** (GRÁTIS desde 1.5.1): registrar alimento/refeição com reação (nenhuma/leve/moderada/severa), aceitação (amou→recusou), notas, 1 foto por registro; celebração de marcos (primeiro alimento etc.); método-agnóstico (BLW, papinha ou misto — o registro não impõe método).
- **Guia de alimentos: 120 alimentos** em 5 categorias (frutas, legumes, proteínas, grãos, laticínios), cada um com idade mínima (6m → 1 ano+) e `preparationTip` = **corte seguro/preparo por alimento** (palito, bastão, cozinhar, amassar). Vários tips incluem "amasse" (serve papinha/amassados parcialmente).
- **Tela de alergênicos** dedicada: lista os alimentos alergênicos com `allergenInfo`, cruzada com o diário (o que já foi oferecido/reagiu).
- **Guia/dicas** (tips_screen): quando começar, o que é BLW, como cortar, **engasgo vs gag reflex** (reconhecer, NÃO ensina manobra — manda fazer curso de primeiros socorros), alimentos proibidos, segurança à mesa, refeições em família, hidratação, dieta balanceada, ferro, variedade.
- **Galeria de fotos** das refeições + viewer.
- Offline, sem login, localizado **pt-BR / en-US / es-ES**.

### Premium (assinatura semanal/anual, paywall no onboarding e nos gates)
- **Receitas: 112** em 4 categorias (café, almoço, jantar, lanche) — **só 2 grátis por categoria** (`freeRecipesPerCategory = 2`); pacote local ainda não released.
- **Export PDF** do diário (relatório).
- **Fotos extras** por registro (>1 por log).

## NOT-list (o app NÃO entrega)
- **NÃO tem cardápio semanal / meal planner / menu / agenda de refeições** (nenhum planner no source; "weekly" só aparece em pricing). A description pt-BR live ainda promete "CARDÁPIO SEMANAL" — mismatch conhecido, correção staged na 1.5.2.
- **NÃO ensina manobra de desengasgo / primeiros socorros** — o tip engasgo-vs-gag só ensina a reconhecer e manda fazer curso.
- **NÃO é receituário de papinha/purê** — recipes são BLW-first (~2 menções a purê/papinha em 112 receitas); cobertura papinha = tips "amasse" no guia + registro no diário.
- **NÃO é baby tracker geral** — sem sono, fraldas, mamadas/amamentação, crescimento/percentis, marcos de desenvolvimento.
- **NÃO tem conteúdo de lactância/amamentação/gravidez.**
- **NÃO tem IA**, importação/salvamento de receitas da web, lista de mercado, contador de calorias/macros, consulta com nutricionista, chancela "feito por nutricionistas".
- **NÃO é marca de terceiros**: Solid Starts, Mundo BLW, BLW Brasil, Little Foodie, Babyplate, Nara Baby, TudoGostoso, DearBaby, HeySolids, Dalo Solids, BabyEats, BabyKoala, Katie Ferraro, Peque Ideas, Bebê de Nutri.

## SERP overrides usados (serp_raw_2026-08-19.json)
- **"papinha" (BR)**: top 8 = 100% apps de introdução alimentar (Pippin, nós #2, Papinhas, YumYum, Little Foodie…) → "papinha" no App Store é lido como "comida de bebê/introdução alimentar", não livro de purês → família papinha-genérica sobe pra FIT.
- **"baby food" (US)**: top 8 = nossa categoria (Solid Starts, BLW apps, trackers) → FIT.
- **"receitas para bebê" (BR)**: SERP mista (BLW Brasil, Garfinho, TudoGostoso, crochê!) → PARTIAL confirmado.
- **"recetas bebé" (ES)**: SERP = apps de receitas BLW → categoria nossa, mas nossas receitas são premium-gated → PARTIAL honesto.
