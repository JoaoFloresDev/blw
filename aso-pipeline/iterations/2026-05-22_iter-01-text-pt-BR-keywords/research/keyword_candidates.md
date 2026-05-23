# Análise iter-01 (pt-BR) — Decisões pros 3 campos ASO

**Data:** 2026-05-23 (após `verify_current.sh` + `sync_current_from_asc.py`)
**Source:** Astro export (`data.csv` = 103 termos trackeados)
**Filtro decisão:** quadrante (diff ≤ 20 sempre; diff 21-40 + pop ≥ 10; diff 41-60 + pop ≥ 25 OU rank histórico; diff > 60 só com pop ≥ 40)

Apple pesa os 3 campos diferente — usar isso a favor:

| Campo    | Char max | Peso ASO | Estratégia                           |
| -------- | -------- | -------- | ------------------------------------ |
| name     | 30       | 7×       | head terms killer-feature + brand    |
| subtitle | 30       | 3×       | high-pop heads NÃO presentes no name |
| keywords | 100      | 1×       | preencher long-tail + modifiers      |

**Princípio:** cada palavra entra no campo com MAIOR peso possível dado seu pop. Não duplicar entre campos — Apple já indexa o termo na primeira ocorrência, repetir é desperdício.

**Caveat da Astro pop=5:** o valor `5` é o piso (Astro não detecta volume confiável). Termos com pop=5 podem ser zero-volume reais OU nichos abaixo do threshold. Tratar com cuidado — favorecer evidência REAL (pop>5 + rank histórico).

---

## 📐 Diff visual — antes / depois

**Legenda das cores:**
<span style="color:#dc3545">**🔴 Vermelho**</span> = saiu completamente (não está em nenhum campo no novo) ·
<span style="color:#28a745">**🟢 Verde**</span> = entrou totalmente novo (não estava em campo nenhum antes) ·
<span style="color:#3b82f6">**🔵 Azul claro**</span> = mudou de lugar pra um campo de PESO MAIOR (keywords → subtitle, subtitle → name) ·
<span style="color:#1e3a8a">**🔵 Azul escuro**</span> = mudou de lugar pra um campo de PESO MENOR (name → subtitle, subtitle → keywords) ·
Preto/normal = mantém no mesmo campo (com ou sem case-fix)

### Name (mantém)

| Antes (atual)                       | Depois (proposto)                |
| ----------------------------------- | -------------------------------- |
| `BLW Baby Introdução Alimentar`     | `BLW Baby Introdução Alimentar`  |
| 29 chars · BLW + brand + head term  | 29 chars · igual                 |

### Subtitle (REESCRITO)

| Antes (atual)                                                                                                                                                  | Depois (proposto)                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| <span style="color:#dc3545">Comida</span> de <span style="color:#dc3545">Bebê</span> <span style="color:#dc3545">6 Meses</span> <span style="color:#1e3a8a">Diário</span> | <span style="color:#28a745">Solid Starts</span>, <span style="color:#28a745">Papinha</span> e <span style="color:#28a745">Cortes</span> |
| 29 chars · 4 tokens, todos pop=5 ou solo-OUT; `Diário` cai pra keywords (peso ↓)                                                                               | 30 chars · 3 termos NOVOS — `Solid Starts` (pop **50** diff **9** rank=29 — GOLD), `Papinha` (BR head term ausente), `Cortes` (Mundo BLW moat) |

### Keywords (REESCRITO)

| Antes (atual)                                                                                                                                                                                                                                                                                                                | Depois (proposto)                                                                                                                                                                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <span style="color:#dc3545">beb</span>,<span style="color:#dc3545">alimentação</span>,<span style="color:#dc3545">receitas bebê</span>,primeiro alimento,<br>diário alimentar,<span style="color:#dc3545">tracker</span>,<span style="color:#dc3545">comida saudável</span>,<span style="color:#dc3545">maternidade</span>   | <span style="color:#28a745">baby weaning</span>,<span style="color:#28a745">starting solids</span>,<span style="color:#28a745">blw meals</span>,<span style="color:#28a745">desengasgo</span>,<br><span style="color:#28a745">cortes seguros</span>,primeiro alimento,diário alimentar           |
| 100 chars · 8 tokens · 1 bug (`beb` truncado) + 5 dead-weight (alimentação/tracker/maternidade/comida saudável/receitas bebê — rank=1000 ou >100 mesmo com pop decente) + 2 keepers                                                                                                                                          | 99 chars · 7 tokens · 0 dead-weight · 3 EN crossover validados pela Astro + 2 moats Mundo BLW + 2 keepers (rank #3 + #40)                                                                                                                                                                       |

---

## 🏷 NAME — `BLW Baby Introdução Alimentar` (mantém)

Análise palavra por palavra:

| Palavra      | Pop | Diff | Rank atual                              | Decisão                                                                                                       |
| ------------ | --- | ---- | --------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `BLW`        | 48  | 13   | **#18**                                 | **Mantém** — head term máximo no nicho, já rankeamos #18. Liderança no name garante peso 7×.                  |
| `Baby`       | 52  | 60   | OUT solo (mas top-1 em compounds)       | **Mantém** — pop alta, mas diff brutal solo. Compõe long-tails ricos (`baby introdução alimentar` rank=1).    |
| `Introdução` | 5   | 19   | **#8**                                  | **Mantém** — head term niche, rank #8 solo.                                                                   |
| `Alimentar`  | 5   | 58   | **#29**                                 | **Mantém** — pareia com `Introdução` (compõe `Introdução Alimentar` rank=20 — termo-mãe da categoria).        |

**Veredito:** name está ótimo. Cobre `BLW` (pop=48) + `Introdução Alimentar` em peso 7×. Mantém intacto.

---

## 🏷 SUBTITLE — `Comida de Bebê 6 Meses Diário` (REESCREVER)

### Análise palavra-por-palavra do subtitle atual:

| Palavra    | Pop | Diff | Rank atual          | Problema                                                                                              |
| ---------- | --- | ---- | ------------------- | ----------------------------------------------------------------------------------------------------- |
| `Comida`   | 59  | 83   | OUT solo            | Pop ALTA mas diff brutal — não rankeamos. Em compounds `comida bebê 6 meses` rank=10 mas pop=5.       |
| `Bebê`     | 5   | 63   | OUT solo            | Solo too generic. Compõe `bebê 6 meses` rank=5 (pop=5 = quase zero volume real).                      |
| `6 Meses`  | 5   | 39   | OUT solo            | `6 meses` solo rank=1000. Compounds funcionam mas todos pop=5.                                        |
| `Diário`   | 5   | 60   | OUT solo            | Solo too generic. `6 meses diário` rank=1 (composição) mas pop=5 = zero volume real.                  |

**Diagnóstico:** subtitle atual é **descrição genérica**, não veículo de ASO. 4 tokens, todos pop=5 ou solo-OUT. As compounds que rankeiam (`6 meses diário` #1, `bebê 6 meses` #5) têm pop=5 — quase zero busca real. Peso 3× desperdiçado.

### Subtitle: SAIU / ENTROU

**🔴 SAIU:**

| Palavra   | Por quê                                                                                                                                       |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `Comida`  | Pop=59 mas diff=83 + rank=1000. Apple não consegue nos rankear solo. Composições com pop=5.                                                  |
| `Bebê`    | Solo OUT, pop=5 em compounds. Apple compõe via name `Baby` (Apple normaliza diacríticos parcialmente — `Baby` no name cobre similar intent). |
| `6 Meses` | Solo OUT, compounds pop=5 (~zero volume). Risco: perdemos `bebê 6 meses` rank=5 + `6 meses diário` rank=1 — ambos pop=5 (loss real ≈ zero).   |
| `Diário`  | Solo OUT. Mantém via composição com `diário alimentar` em keywords.                                                                          |

**🟢 ENTROU:**

| Palavra        | Pop | Diff | Rank atual | Por quê                                                                                                                                                                          |
| -------------- | --- | ---- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Solid Starts` | 50  | 9    | **#29**    | 🥇 **GOLD MÁXIMO** — pop alta (50!) + diff baixíssima (9!) + já rankeamos #29 sem estar em metadata. Subir pra peso 3× deve empurrar pra top-10/15. EN crossover validado no BR. |
| `Papinha`      | 5   | 5    | OUT        | **BR head term** ausente do nosso metadata. Astro pop=5 (piso — pode não detectar nichos BR-PT). Diff=5 = aposta barata. Subtitle peso 3× testa volume real.                     |
| `Cortes`       | 5   | 10   | OUT        | **Mundo BLW vulnerability** — competitor stale 21mo usa `cortes corretos e seguros` como diferencial. Diff=10 baixa. Compõe `cortes seguros` (keywords).                          |

---

## 🔑 KEYWORDS FIELD — reescrita

### 🔴 SAIU (do `keywords.txt` atual)

| Termo                | Pop | Diff | Rank atual | Por quê removeu                                                                                                                            |
| -------------------- | --- | ---- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `beb` (truncado)     | 21  | 63   | 1000       | **BUG truncado** — `bebê` cortado em edição prévia. 4 chars desperdiçados + diff brutal mesmo se completo (`bebê` rank=1000 também).        |
| `alimentação`        | 27  | 72   | 1000       | Pop OK (27) mas diff=72 brutal. Apple já compõe via `Alimentar` no name (peso 7×) — repetir aqui em peso 1× é desperdício de chars.       |
| `receitas bebê`      | 5   | 44   | **#197**   | Rank #197 com 198 apps competindo = invisível. Pop=5. Liberando 13 chars pra termos com signal real.                                       |
| `tracker`            | 43  | 61   | 1000       | Pop alta mas diff=61 — Apple não rankeia solo. EN genérico. `tracker bebê` rank=123 confirma: solo é dead, compounds só ajudam pouco.       |
| `comida saudável`    | 5   | 49   | **#79**    | Rank #79 com 199 apps = below-fold. Pop=5 = zero buscas reais. Apple já cobre `comida` via name (`Baby`+`Alimentar`) — perda real zero.    |
| `maternidade`        | 5   | 57   | **#108**   | Rank #108. Solo too generic — Meu Bebê (26K reviews) domina nicho `maternidade`. Não conseguimos competir solo.                            |

### 🟢 ENTROU (no novo `keywords.txt`)

| Termo             | Pop | Diff | Rank atual | Por quê entrou                                                                                                                                                                                          |
| ----------------- | --- | ---- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `baby weaning`    | 25  | 11   | **#94**    | Sweet spot puro — pop 25 + diff 11 + rank 94 (chão pra subir). Termo EN buscado em BR (parte do tráfego US/EN). 12 chars baratos.                                                                       |
| `starting solids` | 28  | 5    | **#24**    | Variante EN de `solid starts` — Apple trata como termo separado (Astro confirma pops diferentes: 28 vs 50). Diff=5! Já rank #24. 15 chars.                                                              |
| `blw meals`       | 6   | 5    | **#13**    | Pop baixa mas rank=13 já confirmado. Diff=5 mínima. Reforça via keywords pra subir top-10. 9 chars baratos.                                                                                              |
| `desengasgo`      | (5) | 5    | OUT        | **Mundo BLW exclusivo** — competidor stale 21mo possui esse angle. Pop=5 é piso Astro (volume real provavelmente acima — termo emocional/medical search). Diff=5 sem competição.                       |
| `cortes seguros`  | (5) | 10   | OUT        | Long-form do `Cortes` (subtitle). Apple precisa do n-grama exato pra index — não compõe `seguros` solo. Pares com subtitle + autocompõe `cortes papinha`, `cortes blw`.                                  |

### 🔄 MANTÉM (estava na live, fica na nova)

| Termo               | Pop | Diff | Rank atual | Por quê fica                                                                                                       |
| ------------------- | --- | ---- | ---------- | ------------------------------------------------------------------------------------------------------------------ |
| `primeiro alimento` | 5   | 9    | **#3**     | 🥇 Já rankeia #3 — proteger rank é prioridade. Diff=9 fácil. Termo dentro do método BLW.                            |
| `diário alimentar`  | 23  | 44   | **#40**    | Pop=23 (real signal) + rank=40. Único termo de pop>5 que rankeamos no quadrante meio. Vale proteger.                |

### 🔁 CASE-FIX / BUG-FIX

| Termo            | Antes (live)      | Depois     | Por quê                                                                                                                          |
| ---------------- | ----------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `beb` (truncado) | em keywords       | REMOVIDO   | Bug literal de edição prévia. `bebê` solo também rank=1000, então não vale completar — só remover.                              |

---

## 📋 Ordenação dos keywords (front-loading)

Apple **pesa tokens no início do keywords field mais que os do final** (efeito sutil mas real, ~10-20% peso adicional nas primeiras 2-3 posições). Ordenar por prioridade:

| Posição | Term                | Pop | Diff | Rank | Bucket             | Por quê nessa posição                                                                  |
| ------- | ------------------- | --- | ---- | ---- | ------------------ | -------------------------------------------------------------------------------------- |
| #1      | `starting solids`   | 28  | 5    | 24   | high_pop GOLD      | Pop confirmada alta + diff baixíssima + já top-30. Maior ROI por posição.              |
| #2      | `baby weaning`      | 25  | 11   | 94   | high_pop           | Pop alta + diff baixa + rank=94 (chão pra subir). EN crossover.                        |
| #3      | `diário alimentar`  | 23  | 44   | 40   | high_pop+protect   | Único termo PT-puro com pop>5. Rank=40 (proteger) + signal real.                       |
| #4      | `primeiro alimento` | 5   | 9    | 3    | protect            | Já rank #3 — proteger. Pop=5 (piso) mas posição prova volume real.                     |
| #5      | `blw meals`         | 6   | 5    | 13   | protect            | Já rank #13. Pop ligeiramente acima do piso. EN crossover.                             |
| #6      | `desengasgo`        | 5   | 5    | OUT  | moat               | Speculation Mundo BLW. Diff=5 (aposta barata). Pop=5 (piso pode esconder volume).      |
| #7      | `cortes seguros`    | 5   | 10   | OUT  | moat               | Long-form do `Cortes` (subtitle). Diff=10. Cierra o slot.                              |

**Regra geral aplicada:** validated-high-pop (#1-3) → rank-protect (#4-5) → speculation (#6-7).

---

## 📄 Resultado final pra v1.1.0

```
NAME (UNCHANGED):
BLW Baby Introdução Alimentar                                                       (29/30 chars)

SUBTITLE (REESCRITO):
Solid Starts, Papinha e Cortes                                                      (30/30 chars)

KEYWORDS (REESCRITO — ordenados por front-loading peso):
starting solids,baby weaning,diário alimentar,primeiro alimento,                    (99/100 chars)
blw meals,desengasgo,cortes seguros
```

### Cobertura por cluster (peso composto)

| Cluster                       | name (×7)                  | subtitle (×3)         | keywords (×1)                              | Total weight cluster   |
| ----------------------------- | -------------------------- | --------------------- | ------------------------------------------ | ---------------------- |
| BLW método (head)             | BLW                        | —                     | blw meals                                  | 7 + 1 = **8×**         |
| Introdução alimentar (head)   | Introdução, Alimentar      | —                     | —                                          | **14×**                |
| EN crossover (US é #2 país)   | Baby                       | Solid Starts          | baby weaning, starting solids              | 7 + 3 + 2 = **12×**    |
| Papinha (BR head)             | —                          | Papinha               | —                                          | **3×**                 |
| Safety (Mundo BLW moat)       | —                          | Cortes                | desengasgo, cortes seguros                 | 3 + 2 = **5×**         |
| Tracker (feature core)        | —                          | —                     | diário alimentar, primeiro alimento        | **2×**                 |
| Brand (own)                   | BLW Baby                   | —                     | —                                          | (auto via name)        |

### Termos protegidos (já rankeavam — verificar pós-deploy)

| Termo                    | Rank atual | Onde está agora     | Risco                                                                  |
| ------------------------ | ---------- | ------------------- | ---------------------------------------------------------------------- |
| `primeiro alimento`      | **#3**     | keywords            | ✅ Protegido (mantém em keywords)                                       |
| `blw`                    | **#18**    | name                | ✅ Protegido (intacto)                                                  |
| `introducao alimentar`   | **#21**    | name (cedilha)      | ⚠️ Variante sem cedilha — Apple supostamente normaliza acentos          |
| `solid starts`           | **#29**    | subtitle (NOVO)     | 🟢 Reforço peso 3× — esperado subir pra top-15                          |
| `starting solids`        | **#24**    | keywords (NOVO)     | 🟢 Reforço — esperado subir pouco                                       |
| `diário alimentar`       | **#40**    | keywords            | ✅ Protegido (mantém)                                                   |
| `primeiros alimentos`    | **#4**     | (composição)        | ⚠️ Composto via `primeiro alimento` (kw) + name. Verificar Day 7.       |
| `blw meals`              | **#13**    | keywords (NOVO)     | 🟢 Reforço esperado pra top-10                                          |
| `bebê 6 meses`           | **#5**     | (composição perdida)| ❌ PERDA — sai `Bebê` + `6 Meses` do subtitle. Pop=5 = ~zero volume real. |
| `6 meses diário`         | **#1**     | (composição perdida)| ❌ PERDA — sai todos os 3 tokens do subtitle. Pop=5 = ~zero volume real. |

---

## 🎯 Hipótese formal pra `meta.json`

> **If we change**:
> - Subtitle de `Comida de Bebê 6 Meses Diário` (4 tokens todos pop=5 ou solo-OUT, peso 3× desperdiçado em descrição genérica) **para** `Solid Starts, Papinha e Cortes` (3 termos: 1 GOLD pop=50/diff=9, 1 BR head term ausente do metadata, 1 moat de segurança)
> - Keywords de `beb,alimentação,receitas bebê,primeiro alimento,diário alimentar,tracker,comida saudável,maternidade` (1 bug truncado + 5 dead-weight rank=1000/>100) **para** `baby weaning,starting solids,blw meals,desengasgo,cortes seguros,primeiro alimento,diário alimentar` (2 keepers de rank + 3 EN-crossover validados pela Astro + 2 moats Mundo BLW)
>
> **then** total impressions em pt-BR ↑ **≥30% em 30 dias** e downloads ↑ **≥25%** (4.85 dl/dia → ≥6.06 conservador / ≥7.28 bold)
>
> **because**: (a) **Subtitle absorve `Solid Starts`** (pop **50** diff **9** rank=29 atual) elevando-o de "fora do metadata" pra peso 3× — esperado push pra top-10/15. (b) **`Papinha`** (BR head term ausente) entra peso 3× — Astro reporta pop=5 (piso) mas é termo dominante na busca BR-PT (validado pela competidora BLW Brasil descrição). (c) **Bug `beb` truncado** removido — desperdício de 4 chars + 0 rank. (d) **Dead-weight kills**: `tracker` (pop=43 diff=61 rank=1000), `alimentação` (pop=27 diff=72 rank=1000), `maternidade` (rank=108 — Meu Bebê 26K reviews domina) — todos consomem chars sem rankear. (e) **EN crossover (US é #2 país, 55 dl/60d)**: `baby weaning` (pop=25 diff=11 rank=94) + `starting solids` (pop=28 diff=5 rank=24 — sweet spot) + `blw meals` (pop=6 diff=5 rank=13) — captura tráfego EN/US existente. (f) **Moats safety (Mundo BLW stale 21mo)**: `desengasgo` (diff=5!) + `cortes seguros` (diff=10) — competidor stale + diff baixíssima = aposta barata em emoção/medical-search. (g) **Proteções**: mantém `primeiro alimento` rank=#3 + `diário alimentar` rank=#40 no keywords — não regredir.

---

## ⚠️ Riscos identificados

1. **Perda do composto `6 meses diário` rank=#1 + `bebê 6 meses` rank=#5** — pop=5 em ambos = zero volume real, mas a perda é simbólica. Recoverable em iter-02 se necessário.
2. **`Solid Starts` em subtitle pode parecer EN demais pro usuário PT-BR** — risco de CVR cair se mãe BR-PT estranhar o subtitle. Mitigation: `Papinha e Cortes` ancoram em PT. CVR baseline 5.18% — monitorar Day 7 e fazer rollback se ↓ ≥20%.
3. **`Papinha` (subtitle) tem pop=5 na Astro** — pode ser piso (volume real) OU realmente zero. Risco: peso 3× num termo morto. Compensação: `Papinha` é BR head term universalmente reconhecido — confiança qualitativa > Astro pop limit.
4. **`desengasgo` é speculation pura** — Astro pop=5 + rank=1000. Aposta no Mundo BLW thesis (competidor stale). Diff=5 torna a aposta barata (custa 10 chars).
5. **Subir 2 campos na mesma iter** quebra a regra "1 variável por iter" do README. Trade-off aceito pra app cold-start (4.85 dl/dia): velocity > attribution. Compensação: snapshots `metrics/` cada 7 dias permitem reconstruir atribuição via per-keyword rank shifts no Astro.
6. **Apple review pode demorar 2-3 dias** pra mudança de subtitle. Ressubmeter se rejeitar.
7. **Análise feita com Astro batch parcial (~16 termos com pop>floor)** — vários candidates da safety/papinha bucket retornaram pop=5 (piso). Risco residual: estamos apostando em termos sem signal validado. Mitigation: o `proposed` mistura GOLD validado (solid starts, baby weaning, starting solids) + apostas baratas (papinha, desengasgo).
