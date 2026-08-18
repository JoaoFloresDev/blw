# BLW Baby — App Feature Inventory (2026-08-18)

Fonte: `blw/lib` (source Flutter, verificado arquivo a arquivo) + `current/metadata/*` (listing live) + asc_state.json.
App: Introdução Alimentar BLW Baby (6758321287, com.bemestar.POC). Locales do app: pt / en / es.

## Core jobs (o que o app FAZ — confirmado no source)

1. **Diário de introdução alimentar** (`food_log_screen`, `add_food_log_screen`, `food_log_detail_screen`)
   - Registrar cada alimento experimentado, com data, notas e fotos por registro.
   - **Reação por nível**: none / mild / moderate / severe (`models/food_log.dart` enum Reaction) — serve pra monitorar alergia/intolerância.
   - **Meta "primeiros 100 alimentos"**: progresso `triedFoods/100`; passou de 100, meta vira o catálogo inteiro (linha 382-383 do food_log_screen).
2. **Catálogo de 120 alimentos** (`foods_data.dart`: 120 entradas `Food(`)
   - Por categoria: frutas, legumes/verduras, proteínas, cereais/grãos, laticínios.
   - Por idade mínima: 6m, 7m, 8m, 9m, 10-12m, 1 ano+ (`AgeGroup`).
   - **`preparationTip` por alimento = guia de corte seguro/preparo por fase** (bastão, palito, amassado...).
   - Flag `isAllergen` + `allergenInfo` por alimento.
3. **Tela de alergênicos** (`allergens_screen`): lista dos alimentos alergênicos + explicação do que são alérgenos.
4. **Receitas** (`recipes_data.dart`: 112 `Recipe(`; `recipes_screen`)
   - Categorias: breakfast / lunch / dinner / snack. Freemium: `freeIds` (2 grátis por categoria), resto atrás do paywall.
5. **Galeria de fotos** (`gallery_screen`, `photo_viewer_screen`): fotos dos registros, viewer.
6. **Dicas/guia BLW** (`tips_screen`): quando começar, o que é BLW, **como cortar**, **engasgo vs gag (educativo)**, alimentos proibidos, segurança, hidratação, ferro, refeições em família, paciência, variedade.
7. **Export PDF do diário** (`pdf_service`, premium).
8. **Premium** (`purchase_service`, `paywall_view`): sub semanal/anual, trial 3d. Free = diário + catálogo + 2 receitas/categoria + fotos limitadas.
9. Offline, sem login (storage local). Onboarding simples.

## Tabs: Diário / Alimentos / Galeria (3 tabs, `main.dart`).

## NOT-list (o que o app NÃO faz — tão importante quanto a lista)

- **NÃO é baby tracker genérico**: zero sono, fraldas, mamadas/amamentação, crescimento, marcos. SERP de "baby feeding tracker" US = Huckleberry/Baby Tracker (mamada+sono+fralda) → categoria diferente.
- **NÃO tem amamentação/lactancia/destete de peito**: "weaning" coberto só no sentido ALIMENTAR (introdução de sólidos).
- **NÃO tem cardápio semanal / meal planner / gerador de menu**: nenhuma tela de planejamento existe no source. ⚠️ A description live pt-BR PROMETE "CARDÁPIO SEMANAL pra organizar a rotina" — promessa FALSA (o único "Semanal" no app é `planWeekly` = plano de ASSINATURA no paywall). Corrigir a description; não usar keywords de cardápio/planner.
- **NÃO tem guia de emergência/primeiros socorros de engasgo**: só prevenção (cortes seguros, alimentos proibidos, tip educativo engasgo×gag). Nada de manobra de desengasgo.
- **NÃO tem compras/delivery/scanner de alimentos.**
- **NÃO tem conteúdo pra seletividade alimentar de criança maior** (foco 6m–2a).
- **NÃO tem consulta/serviço de nutricionista ou pediatra.**
- **NÃO tem agenda/schedule** (horários de refeição, cronograma) — a progressão por idade do catálogo é o mais perto que chega.

## Listing live (o que PROMETEMOS)
- pt-BR name: "Introdução Alimentar BLW Baby" · subtitle: "Papinha, Receitas Solid Starts"
- en-US name: "BLW Baby Led Weaning Tracker" · subtitle: "First Foods & Solid Starts Log"
- es-ES name: "Alimentación Complementaria" · subtitle: "BLW, Comida Bebé y Papillas"
- Description pt-BR promete: diário, cardápio semanal (⚠️ falso), receitas por fase, guia de cortes, biblioteca 100+ alimentos c/ alérgenos, galeria, histórico, offline, sem login.
