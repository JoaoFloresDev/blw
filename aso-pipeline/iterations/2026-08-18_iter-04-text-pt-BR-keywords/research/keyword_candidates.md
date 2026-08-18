# BLW Baby Led Weaning Tracker — iter-04 (2026-08-18) · pt-BR + en-US + es-ES/es-MX

Base: LIVE 1.5.1. Supersede a iter-03 (composta hoje cedo na 1.5.2 editável, nunca foi ao ar). Muda: subtitle+keywords (pt-BR), keywords (en-US, es-ES, es-MX). Names e subtitles en/es intocados por rank-protect.

## 📐 Diff antes/depois por locale

**pt-BR**

| Campo | Antes | Depois |
|---|---|---|
| subtitle | Papinha, Receitas <span style="color:#d64541">Solid Starts</span> | Papinha, Receitas e <span style="color:#2d6cdf">Weaning</span> |
| keywords | papinha caseira, papinha 6 meses, receitas papinha, <span style="color:#2d6cdf">baby weaning</span>, <span style="color:#d64541">baby feeding</span>, desengasgo, cortes seguros | <span style="color:#1e9e5a">starting solids</span>, <span style="color:#1e9e5a">bebe</span>, <span style="color:#1e9e5a">guia</span>, papinha caseira, papinha 6 meses, receitas papinha, desengasgo, cortes seguros |

<span style="color:#2d6cdf">baby weaning</span> não foi cortado — foi **promovido de peso**: `baby` já está no name pt, `weaning` sobe pro subtitle (name/subtitle ≫ kw). <span style="color:#d64541">solid starts</span> sai do subtitle pt mas `solid`+`starts` seguem indexados pelo subtitle en-US (a store br indexa os dois locales).

**en-US**

| Campo | Antes | Depois |
|---|---|---|
| keywords | starting solids, <span style="color:#2d6cdf">weaning</span>, puree, <span style="color:#d64541">feeding</span>, recipes, allergen, <span style="color:#d64541">infant</span>, <span style="color:#d64541">toddler</span>, <span style="color:#d64541">nutrition</span>, meal plan, 6 month | starting solids, <span style="color:#1e9e5a">introduction</span>, <span style="color:#1e9e5a">finger food</span>, <span style="color:#1e9e5a">guide</span>, <span style="color:#1e9e5a">100</span>, puree, recipes, allergen, meal plan, 6 month |

<span style="color:#2d6cdf">weaning</span> era dup exato do name en-US ("…Led Weaning Tracker") — cobertura 100% pelo name (7×), 8 chars reinvestidos.

**es-ES / es-MX (cópia)**

| Campo | Antes | Depois |
|---|---|---|
| keywords | <span style="color:#2d6cdf">blw</span>, starting solids, <span style="color:#d64541">solid starts</span>, baby led weaning, destete, recetas, <span style="color:#2d6cdf">sólidos</span>, <span style="color:#2d6cdf">alérgenos</span>, <span style="color:#d64541">lactancia</span> | <span style="color:#1e9e5a">introduccion</span>, <span style="color:#1e9e5a">guia</span>, <span style="color:#1e9e5a">atragantamiento</span>, starting solids, baby led weaning, recetas, destete, <span style="color:#2d6cdf">solidos</span>, <span style="color:#2d6cdf">alergenos</span> |

<span style="color:#2d6cdf">blw</span> era dup exato do subtitle es — as composições "blw *" seguem pelo subtitle. <span style="color:#2d6cdf">sólidos/alérgenos</span> renormalizados sem acento.

## pt-BR — decisões

| Ação | Termo | Pop | Diff | Rank | Por quê |
|---|---|---|---|---|---|
| SAIU | `solid starts` (par do subtitle) | 50 | 5 | #68 solo / #20 comp. | LOTTERY — brand do líder; único par do subtitle pt com folga (só protegia br #20/#28) e a cobertura FICA via subtitle en-US. Custo aceito pelo coordenador |
| SAIU | `baby feeding` | 5 | — | OUT | Slot livre confirmado — zero composição rankeada (feeding = mamadas na SERP). OUT sem retorno |
| ENTROU (subtitle) | `weaning` | 16-25 | 5 | #18/#24 | Promoção de peso: `baby weaning` CLIMB #1 do br (pop 25, diff 5, incumbentes 0-57 ratings) → #24 vira alvo top 10 com baby(name)+weaning(subtitle); weaning solo #18 sobe junto |
| ENTROU (kw, aposta 1) | `starting solids` | 28 | 5 | #18 | CLIMB → top 8-10; SERP fraquíssima no br (Solid Starts com 57 ratings). Hoje só indexa via kw en-US; frase exata pt adiciona peso de locale |
| ENTROU (kw, aposta 2) | `bebe` | — | ≤17 | OUT | Feeder: destrava introdução alimentar bebê (13), papinha bebê (5), alergia alimentar bebê (11), receitas bebê 6 meses (5), comida caseira bebê (9) — todas "top 10 se token entrar". Sem acento (iOS normaliza) |
| ENTROU (kw, aposta 3) | `guia` | — | 5-12 | OUT | Feeder 4-chars: guia blw (9), guia introdução alimentar (12), guia baby led weaning (5) — 3 CLIMB "top 10 se token entrar" |
| MANTÉM | `papinha caseira` | 5 | 5 | **#1** | Mapa de proteção — frase exata fica |
| MANTÉM | `papinha 6 meses` | 5 | 5 | **#3** | Mapa de proteção |
| MANTÉM | `receitas papinha` | 5 | 5 | **#5** | Mapa de proteção |
| MANTÉM | `desengasgo` | 5 | 5 | **#1** | Zero competição |
| MANTÉM | `cortes seguros` | 5 | 8 | **#2** | SERP com 6 resultados |

Front-loading: starting solids (CLIMB pop 28) → bebe, guia (feeders) → frases protegidas. Subtitle 27/30: os 3 chars sobrando não cabem token honesto (blw/baby dupariam o name pt).

## en-US — decisões

| Ação | Termo | Pop | Diff | Rank | Por quê |
|---|---|---|---|---|---|
| SAIU | `feeding` `infant` `toddler` `nutrition` | — | — | OUT | Slots livres confirmados — nenhuma composição rankeada ≤30. 33 chars liberados |
| SAIU | `weaning` (kw) | 14 | 13 | **#3-4** via name | Dup exato do name en-US — blocker; TODA composição com weaning cita o name como protetor (us #3-4, br #18/#24). Cobertura integral, zero perda, 8 chars reinvestidos |
| ENTROU (aposta 1) | `introduction` | — | 5-15 | OUT | Feeder ≥3 CLIMB: food introduction tracker (5), solid food introduction (9), allergen introduction tracker (15), introduction to solids (9) — "top 10 se token entrar" |
| ENTROU (aposta 2) | `finger food` | — | 7-11 | OUT | finger food recipes (11, recipes já no kw); `food` amplifica a aposta 1 e compõe food allergen log (5) de graça |
| ENTROU (aposta 3) | `guide` | — | 7-11 | #37 | weaning guide JÁ #37 diff 7 → top 18 (weaning no name) + starting solids guide (11) top 10 se entrar. 2 CLIMB por 5 chars |
| ENTROU (aposta 4) | `100` | — | 7 | #175 | 100 foods baby diff 7 — todos os tokens em campo (name baby + subtitle foods); feature central do diário. 3 chars, pagos pela saída do dup weaning |
| MANTÉM | `starting solids` | 29 | 19 | #22 us / #18 br | CLIMB → top 12-15; promover peso, front-loaded |
| MANTÉM | `puree` `recipes` `allergen` `meal plan` `6 month` | — | — | #20-53 | Mapa de proteção: puree tracker #51, weaning recipes #20 br, blw meals #23 br/#26 es, papinha 6 meses cross |

Aposta descartada: `choking` — baby choking é PARTIAL solo com feed único LOTTERY, falha a barra de ≥2 composições. 91/100 justificado: os 9 chars restantes só teriam dup ou token morto — 91 honestos > 100 com filler.

## es-ES / es-MX — decisões

| Ação | Termo | Pop | Diff | Rank | Por quê |
|---|---|---|---|---|---|
| SAIU | `blw` (kw) | 47 | 9 | #46 via subtitle | Dup exato do subtitle es — iOS não indexa 2×; composições "blw *" (#8-26) protegidas pelo subtitle. 4 chars sem perda |
| SAIU | `solid starts` | — | — | OUT | Slot livre — nenhuma composição rankeada; starting+solids segue no kw e solid+starts no subtitle en-US (store es indexa en-US) |
| SAIU | `lactancia` | — | 44 | OUT | Off-scope (intenção amamentação, não introdução alimentar) |
| ENTROU (aposta 1) | `introduccion` | — | 5 | OUT | Direção do serp-analyst: introducción alergenos (5), introducción de sólidos (5), introducción alimentos bebé (5) — CLIMB "top 10 se token entrar" |
| ENTROU (aposta 2) | `atragantamiento` | — | 5 | OUT | atragantamiento bebé (bebé no subtitle) LOTTERY top 20 se entrar; prevención atragantamiento (diff 5) fica semi-coberta (prevencion não coube) |
| ENTROU (aposta 3) | `guia` | — | 5 | OUT | guía blw (5, blw no subtitle) + guía alimentación complementaria (5, name) — 2 CLIMB por 4 chars |
| MANTÉM | `starting solids` | — | — | #15-16 | Mapa de proteção |
| MANTÉM | `baby led weaning` | 7 | 9 | #22 / español **#10** | Mapa de proteção |
| MANTÉM | `recetas` | — | 7-9 | **#2**-#11 | Protege 5 composições recetas* |
| MANTÉM | `destete` | — | 9 | #11 | destete bebé |
| MANTÉM | `solidos` `alergenos` | — | 5 | OUT | Renormalizados sem acento; ganham propósito com a aposta 1 (introducción de sólidos / alergenos, diff 5) |

Front-loading: introduccion, guia, atragantamiento (bets) → starting solids/baby led weaning (CLIMB rankeados) → recetas/destete/solidos/alergenos.

## 🗺️ Mapa de proteção — composição → rank → token protetor (pós-composição)

**BR** (store br indexa pt-BR + en-US)

| Composição | Rank | Protegida por |
|---|---|---|
| blw baby · blw tracker baby led | **#1** | name pt (blw, baby) + name en-US (led, tracker) |
| papinha caseira · receitas de papinha caseira | **#1** | subtitle pt (papinha, receitas) + kw pt (caseira) |
| desengasgo | **#1** | kw pt |
| papinha · cortes seguros | **#2** | subtitle pt / kw pt |
| blw 6 meses · blw baby introdução · blw cortes · introdução alimentar 6/7 meses · papinha 6 meses · receitas 6 meses | **#3** | name pt + kw pt (6 meses, cortes) |
| introdução alimentar blw | **#4** | name pt |
| receitas papinha | **#5** | kw pt exata + subtitle pt |
| led weaning · introdução alimentar receitas | **#6** | name en-US / name+subtitle pt |
| baby introdução alimentar · blw tracker | **#7** | name pt + name en-US |
| baby introdução | **#8** | name pt |
| blw receitas · weaning tracker | **#10** | name+subtitle pt / name en-US |
| introdução | #12 | name pt |
| introdução alimentar (HEAD) · baby led weaning | #17 | name pt / name en-US |
| starting solids | #18 | kw en-US + **AGORA kw pt** |
| weaning | #18 | **subtitle pt (novo)** + name/kw en-US |
| solid starts baby first foods | #20 | **subtitle en-US** (solid, starts, first, foods) — perdeu o par do subtitle pt |
| weaning recipes | #20 | kw en-US recipes + name en-US |
| blw meals | #23 | name pt + kw en-US "meal plan" |
| baby weaning | #24 | **name pt (baby) + subtitle pt (weaning)** + name en-US — upgrade de campo |
| start solid food | #28 | subtitle en-US + kw en-US |

**US**

| Composição | Rank | Protegida por |
|---|---|---|
| weaning | **#3-4** | name en-US — crown jewel (Solid Starts 43k relegado a #9) |
| blw for beginners | #15 | name en-US |
| baby led weaning | #16 | name en-US exato |
| baby led weaning food list | #19 | name + subtitle en-US |
| starting solids | #22 | kw en-US (mantido, front-loaded) |
| baby weaning | #22 | name en-US |
| baby led weaning family meals | #23 | name en-US + kw "meal plan" |
| blw | #30 | name en-US |

**ES** (store es indexa es-ES + en-US)

| Composição | Rank | Protegida por |
|---|---|---|
| alimentación complementaria bebé · recetas | **#2** | name es + subtitle es (bebé) / kw es (recetas) |
| alimentación complementaria (HEAD) · mi ~ | **#4** | name es |
| recetas blw bebé · recetas papillas bebé | **#8** | kw es (recetas) + subtitle es (blw, papillas, bebé) |
| recetas de papillas | **#9** | kw es + subtitle es |
| baby led weaning español | **#10** | kw es "baby led weaning" |
| blw recetas · destete bebé | #11 | subtitle es + kw es (recetas, destete) |
| blw bebé | #12 | subtitle es |
| weaning | #14 | kw es "baby led weaning" + name en-US |
| starting solids | #15-16 | kw es + kw en-US |
| baby weaning | #18 | kw es + name en-US |
| baby led weaning | #22 | kw es exata |
| blw meals | #26 | subtitle es (blw) + kw en-US (meal plan) |

Toda composição rankeada ≤30 mantém todos os tokens em campo. Única troca de protetor: br #20 (subtitle pt → subtitle en-US).

## 📄 Resultado final

```
pt-BR
  name      Introdução Alimentar BLW Baby                            (29/30, sem mudança)
  subtitle  Papinha, Receitas e Weaning                              (27/30)
  keywords  starting solids,bebe,guia,papinha caseira,papinha 6 meses,receitas papinha,desengasgo,cortes seguros   (100/100)

en-US
  name      BLW Baby Led Weaning Tracker                             (28/30, sem mudança)
  subtitle  First Foods & Solid Starts Log                           (30/30, sem mudança)
  keywords  starting solids,introduction,finger food,guide,100,puree,recipes,allergen,meal plan,6 month   (91/100)

es-ES / es-MX (cópia)
  name      Alimentación Complementaria                              (27/30, sem mudança)
  subtitle  BLW, Comida Bebé y Papillas                              (27/30, sem mudança)
  keywords  introduccion,guia,atragantamiento,starting solids,baby led weaning,recetas,destete,solidos,alergenos   (100/100)
```

**Ação anexa (fora do escopo ASO desta iter):** a description pt-BR promete "cardápio semanal" que NÃO existe no app (MISMATCH do fit-checker) — o coordenador corrige a description no deploy junto com estes campos.

## 🎯 Hipótese formal

> **SE** promovermos `baby weaning` de kw pra name+subtitle (pt-BR), trocarmos os tokens mortos dos 4 locales (baby feeding; feeding/infant/toddler/nutrition + dup weaning; blw dup/solid starts/lactancia) por 10 apostas CLIMB de diff ≤15 com SERP fraca (starting solids/bebe/guia · introduction/finger food/guide/100 · introduccion/guia/atragantamiento),
> **ENTÃO** impressões diárias sobem ≥15% e downloads vão de 18,7 → ≥20/dia (conservador) rumo a 23 (bold) em 30 dias do release da 1.5.2,
> **PORQUE** (a) nenhum token removido protegia composição rankeada — só dups e slots mortos, 45+ chars reinvestidos; (b) as SERPs-alvo são pulverizadas (incumbentes 0-350 ratings fora o brand Solid Starts) e já rankeamos #14-24 nos CLIMBs principais — peso de campo é a alavanca que falta; (c) ≥15 composições "top 10 se token entrar" ganham o token que faltava.

## ⚠️ Riscos

1. **Flutuação do cluster papinha ao trocar o subtitle pt** — Apple reindexa o campo inteiro. Mitigação: papinha/receitas ficam no subtitle; rollback trigger se 3+ ranks #1-5 caírem sem ganho nos CLIMBs.
2. **br #20 (solid starts baby first foods) pode cair** ao migrar a proteção pro subtitle en-US. Mitigação: perda máxima = 1 composição #20 LOTTERY; monitorar no D7, reverter subtitle se o cluster solid starts br desabar.
3. **Relógio do experimento depende da aprovação da 1.5.2** (PREPARE_FOR_SUBMISSION) — os campos só entram no ar no release. Mitigação: checkpoints contam do release, não de 18/08; datas abaixo assumem aprovação em ~7 dias e deslocam junto.
4. **MISMATCH da description** ("cardápio semanal" inexistente) — risco de review negativa se ficar. Mitigação: correção anexada ao deploy (ação do coordenador, registrada acima).
5. **Heads blw com teto** — br/us/es #30-46 apesar de blw no name/subtitle: fleet BLW SOCIAL (1.885 + 874 ratings) + nós com 1 rating br. Não esperar movimento nos heads; o volume desta iter vem das long-tails. Mais rating = próxima alavanca.
6. **`bebe`/feeders solo são UNWINNABLE** (bebê solo diff 63) — a aposta é composição, não rank solo. Não julgar o token pelo rank isolado no D7.

## 📈 Projeção

| Cenário | Impressões (Δ vs baseline) | Downloads/dia | Leitura |
|---|---|---|---|
| Pessimista | +0-8% | 18-19 | Apostas não compõem; só reindexação neutra. Mantém 18,7 — sem dano (tokens protegidos ficaram) |
| Realista | +15-25% | 20-22 | 6-8 das 15 composições CLIMB entram top 10-20; baby weaning br #24→#10-14 |
| Otimista | +30-45% | 23-26 | Promoção de peso morde nos 3 CLIMBs principais (baby weaning, starting solids br+es, weaning es #14→top 8) + feeders compõem em bloco |

Probabilidades: **conservador (20/dia) ~60%** · **bold (23/dia) ~30%** · dano líquido (<17/dia sustentado) ~10%.

D0-D28 (realista, dl/dia): `18,7 ▃▃▃▄▄▅▅▅ ~21` — degrau esperado entre D7-D14 (reindexação leva ~7 dias; seven-day cliff do playbook).

| Checkpoint | Sinal de sucesso | Sinal de falha |
|---|---|---|
| D7 · 2026-08-25* | starting solids br ≤12; weaning us segura #3-4; ≥3 composições novas (bebe/guia/introduccion) aparecem no índice em qualquer rank | downloads -30%; weaning us cai >5 posições; cluster papinha sai do top 5 |
| D14 · 2026-09-01 | baby weaning br ≤15; impressões +15%; introducción es composições ≤20 | nenhuma composição nova indexada = apostas mortas, preparar swap |
| D21 · 2026-09-08 | média 7d ≥19; rascunhar iter-05 (rating push ou promotional_text) | tendência flat com impressões altas = problema de conversão → PPO, não texto |
| D28 · 2026-09-15 | média 14d ≥20 = promote; ≥23 = bold batido | média 14d <20 = hipótese fraca; próxima alavanca é conversão/ratings |

\* datas assumem release da 1.5.2 até ~18-20/08; deslocar D7-D28 pela data real do release.

## 🎲 Confidence breakdown

| Assunção crítica | Confiança | Impacto se falhar |
|---|---|---|
| ≥ metade das composições "top 10 se token entrar" materializa em 14 dias | 60% | Alto — é o grosso do upside das 10 apostas |
| Promoção baby weaning kw→name/subtitle move br #24 → top 10 | 55% | Alto — CLIMB #1 do br (pop 25) |
| Subtitle en-US segura br #20 e o cluster solid starts após a saída do par pt | 75% | Baixo — perda máxima de 1 composição #20 |
| Reindexação do subtitle pt não abala o cluster papinha #1-5 | 85% | Alto se falhar (rollback), mas tokens ficaram — probabilidade baixa |
| 1.5.2 aprovada em ≤7 dias (relógio do experimento) | 80% | Nulo no resultado, desloca as datas |
| Índice es reconhece introduccion/solidos/alergenos sem acento como a forma acentuada | 80% | Médio — apostas es dependem da normalização (comportamento padrão do iOS) |
