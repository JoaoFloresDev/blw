# BLW Baby — iter-03 keyword candidates (pt-BR / loja BR)

**Data:** 2026-08-18 · **Source:** Astro MCP (105 termos trackeados, refresh 18/08) · **Baseline:** 12,8 dl/dia (ASC, capturado 06/08 na iter-02)
**Filtro decisão (quadrante):** diff ≤ 20 gold · diff 21-40 + pop ≥ 10 sweet · diff > 60 só com pop ≥ 40 no name

| Campo | Peso | Estratégia |
|---|---|---|
| Name | 7× | **NÃO mexer** (estável, rank-protect do cluster `introdução alimentar blw`) |
| Subtitle | 3× | **NÃO mexer** (papinha #2, receitas, solid starts — tudo rank-protect) |
| Keywords | 1× | **Reconstruir** — hoje é o campo mais desperdiçado do app |

**Princípio:** Apple indexa cada palavra 1× (primeira ocorrência) e compõe combinações entre campos. Compostos no keywords field = chars queimados.
**Caveat Astro:** pop=5 é PISO de medição, não volume real.

## 📊 Diagnóstico (o porquê desta iter)

O app domina o **long-tail de volume zero** e está fraco exatamente nos termos com volume REAL buscados na loja BR:

| Termo (BR) | Pop | Diff | Rank hoje | Situação |
|---|---|---|---|---|
| `solid starts` | **50** | 5 | 68 | volume real, diff mínimo, rank péssimo |
| `blw` | **48** | 19 | 37 | head do nicho, fora da 1ª página |
| `introducao alimentar` (s/ acento) | **40** | 19 | 34 | caiu de 19→34 na última medição |
| `starting solids` | **28** | 5 | 18 | rankeia SÓ por stemming (não temos os tokens) |
| `baby weaning` | **25** | 5 | 24 | idem, composto queima chars |
| `diário alimentar` | 23 | 21 | OUT | intenção polissêmica (diário de dieta adulto) — não perseguir |
| `weaning` | 16 | 5 | 18 | ganhável |
| Cluster #1-#3 atual (papinha caseira, desengasgo, cortes seguros…) | 5 (piso) | ≤13 | #1-#3 | protegido, quase sem volume |

Duas descobertas estruturais:

1. **O token `bebê` NÃO existe em nenhum campo pt-BR** (name usa "Baby"). Isso derruba TODA composição com bebê: `blw bebê` (diff 17) OUT, `papinha bebê` (diff 5) OUT, `alimentação bebê` OUT, `alergia alimentar bebê` (diff 11) OUT. Um token de 4 chars destrava dezenas de queries em português.
2. **O keywords field atual é 100% compostos** (`papinha caseira,papinha 6 meses,receitas papinha,baby weaning,baby feeding,…`) com `papinha` 3×, `receitas` e `papinha` duplicando o subtitle e `baby` duplicando o name. Metade do campo não indexa nada novo.

## 📐 Diff visual — antes/depois

Legenda: <span style="color:#dc3545">🔴 saiu</span> · <span style="color:#28a745">🟢 entrou novo</span> · preto = mantém

**NAME (sem mudança):** `Introdução Alimentar BLW Baby` (29/30)

**SUBTITLE (sem mudança):** `Papinha, Receitas Solid Starts` (30/30)

**KEYWORDS antes →** <span style="color:#dc3545">papinha</span> caseira,<span style="color:#dc3545">papinha</span> 6 meses,<span style="color:#dc3545">receitas papinha</span>,<span style="color:#dc3545">baby</span> weaning,<span style="color:#dc3545">baby feeding</span>,desengasgo,cortes seguros

**KEYWORDS depois →** <span style="color:#28a745">bebê</span>,weaning,<span style="color:#28a745">starting</span>,<span style="color:#28a745">solids</span>,caseira,6,meses,desengasgo,cortes,seguros,<span style="color:#28a745">alergia</span>,<span style="color:#28a745">cardápio</span>,<span style="color:#28a745">nutrição</span>,<span style="color:#28a745">mãe</span>

## 🔑 KEYWORDS FIELD — decisão por termo

### 🔴 SAIU
| Token | Por quê |
|---|---|
| `papinha` (3×) | Já está no SUBTITLE (peso 3×) — as 3 repetições não indexam nada |
| `receitas` | Já está no SUBTITLE |
| `baby` | Já está no NAME (peso 7×) |
| `feeding` | pop 5 piso, composições EN cobertas por weaning/solids; menor valor do campo |

### 🟢 ENTROU
| Token | Evidência | Por quê |
|---|---|---|
| `bebê` 🥇 | `blw bebê` diff 17 OUT · `papinha bebê` diff 5 OUT · `alergia alimentar bebê` diff 11 OUT | Token ausente que destrava o maior nº de composições PT |
| `starting` 🥇 | `starting solids` pop 28/diff 5, rank 18 só por stemming | Token exato deve empurrar pra top 5-10 |
| `solids` 🥇 | idem + reforça `solid starts` pop 50/diff 5 (rank 68) | Par com starting |
| `alergia` 🥈 | `alergia alimentar bebê` diff 11, busca de mãe em momento de medo | Composição com bebê+alimentar(name) |
| `cardápio` 🥈 | `cardápio infantil` diff 13 · `cardápio semanal bebê` diff 9 | Feature real do app (receitas/planejamento) |
| `nutrição` 🥈 | `nutrição infantil` diff 9 · `nutrição bebê` diff 39 | Composição barata |
| `mãe` 🔵 | `mãe primeira viagem` diff 5 | Audience feeder, 3 chars |

### ✅ MANTÉM (rank-protect)
| Token | Protege |
|---|---|
| `caseira` | `papinha caseira` **#1** (compõe com papinha do subtitle) |
| `6`, `meses` | `papinha 6 meses` #3 · `receitas 6 meses` #3 · `introdução alimentar 6 meses` #3 |
| `desengasgo` | **#1** (1 app no ranking — exclusivo nosso) |
| `cortes`, `seguros` | `cortes seguros` **#2** (wedge de segurança vs Mundo BLW) |
| `weaning` | `weaning` pop 16 rank 18 · `baby weaning` pop 25 rank 24 (baby vem do name) |

## 📋 Ordenação (front-loading)
`bebê` (destrava PT) → `weaning,starting,solids` (volume EN confirmado) → rank-protect (`caseira,6,meses,desengasgo,cortes,seguros`) → speculation (`alergia,cardápio,nutrição,mãe`).

## 📄 Resultado final
```
name (pt-BR):     Introdução Alimentar BLW Baby        (29/30 — inalterado)
subtitle (pt-BR): Papinha, Receitas Solid Starts        (30/30 — inalterado)
keywords (pt-BR): bebê,weaning,starting,solids,caseira,6,meses,desengasgo,cortes,seguros,alergia,cardápio,nutrição,mãe   (100/100)
```

## Cobertura por cluster (peso composto name×7 + sub×3 + kw×1)
| Cluster | Antes | Depois |
|---|---|---|
| introdução alimentar / blw | 7× (name) | 7× (igual) |
| papinha / receitas | 3× + kw dups inúteis | 3× (limpo, sem perda) |
| solid starts / starting solids / weaning (EN c/ volume) | 3× parcial + stemming | 3× + tokens exatos no kw |
| composições `bebê` (blw bebê, papinha bebê, alergia…) | **0** | 1× (novo) |
| segurança (desengasgo, cortes, engasgo) | 1× | 1× (igual) |

## Termos protegidos (verificar pós-deploy)
`papinha caseira` #1 · `desengasgo` #1 · `blw baby` #1 · `cortes seguros` #2 · `papinha` #2 · `papinha 6 meses` #3 · `receitas 6 meses` #3 · `introdução alimentar blw` #4 · `receitas papinha` #5 (este pode oscilar — papinha e receitas ficam ambos no subtitle, composição se mantém).

## 🎯 Hipótese formal
> **If we change** o keywords field pt-BR de compostos duplicados para 14 tokens únicos (adicionando bebê, starting, solids, alergia, cardápio, nutrição, mãe e removendo papinha×3/receitas/baby/feeding), **then** impressions diárias ↑ ≥25% e downloads diários ↑ ≥20% em 30 dias, **because** (a) `starting solids` (pop 28/diff 5) e `solid starts` (pop 50/diff 5) passam a ter tokens exatos em vez de stemming; (b) o token `bebê` destrava composições PT hoje OUT com diff ≤17; (c) nenhum rank atual depende de token removido (todos duplicavam name/subtitle).

## ⚠️ Riscos
1. `receitas papinha` #5 pode oscilar (perde o verbatim) — mitigação: ambos tokens seguem no subtitle; Apple compõe.
2. `baby feeding` (pop 5) some do verbatim — irrelevante (piso).
3. Queda geral de rankings em 18/08 (-1 a -15 em vários termos) sugere reshuffle do índice — medir D7 antes de concluir qualquer coisa.

## ⏱ Timeline + tempo do dev
| Fase | Quando | Dev |
|---|---|---|
| Deploy + baseline D0 | hoje | 10min (aprovar) |
| Apple processa metadata | D0-2 | 0 |
| Primeiro sinal confiável | D7 | 15min (checkpoint via aso-checkpoint) |
| Tendência | D14 | 30min |
| Decision day | D28 | 1h |

**Não analisar antes do D7** — é ruído.

## 📈 Projeção (D28)
Premissas: baseline 12,8 dl/dia · CR busca 3-5% · impressões/dia ≈ Σ pop×(101-rank)/100.

| Bucket | Termos | Rank D0 → esperado D28 |
|---|---|---|
| GOLD | starting solids 18→**5-10** · solid starts 68→**30-45** · weaning 18→**8-14** · baby weaning 24→**12-18** | +60-100 impressões/dia |
| Composições bebê (novas) | blw bebê OUT→**top 30** · papinha bebê OUT→**top 20** · alergia alimentar bebê OUT→**top 30** | +10-25 impressões/dia |
| Rank-protect | cluster #1-#5 mantém | 0 (defensivo) |
| Perdas esperadas | receitas papinha #5→#5-15 | −2 impressões/dia |

| Cenário | Δ impressões/dia | Downloads/dia |
|---|---|---|
| Pessimista | +10% | 13,5 |
| Realista | +25-35% | **15,5-17** |
| Otimista | +50% | 19+ |

Probabilidades: bater conservador (≥14 dl/dia) ~75% · bater bold (≥16) ~50% · rollback <10%.
Trajetória esperada (dl/dia): D0 12,8 `███░░░` → D7 13 → D14 14,5 → D21 15,5 → D28 16.

**Sinais por checkpoint:** D7 sucesso = starting solids ≤ 12, composições bebê aparecendo no índice; falha = downloads ↓≥30% (rollback). D14: solid starts ≤ 50 e impressões ↑. D28: dl/dia ≥ 14 = promote; < 14 = reformular.

## 🎲 Confidence
| Premissa | Conf. | Se errada |
|---|---|---|
| Token exato > stemming pra starting/solids | 80% | ganho vira ~0, sem perda |
| `bebê` destrava composições OUT | 85% | perde o maior upside |
| Rank-protect segura sem os verbatims | 75% | queda no cluster papinha (reversível) |
| Volume real de solid starts em BR é capturável | 60% | pop 50 pode ser inflado por brand-search do app Solid Starts |
**Agregada: ~70%** — risco baixo (campo 1×, reversível, zero mudança em name/subtitle).

---

### Nota estratégica (fora do escopo desta iter, MAIOR alavanca)
Pelo playbook, conversão é metade do ranking — e o **BLW Panorama PPO (3 treatments × 4 locales) está PRONTO aguardando teu Start manual na ASC** desde 07/08. Dar Start nele vale provavelmente mais que esta iteração de texto, e os dois se compõem. Segunda alavanca: o funil já provou que o paywall de onboarding converte 40% — mais tráfego (esta iter) × mais conversão (PPO) multiplicam.
