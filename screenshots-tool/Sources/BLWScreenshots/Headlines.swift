import Foundation

// MARK: - Headline Copy (BLW Baby Led Weaning)
//
// 3 treatments × 5 slots × 4 locales (es-MX reuses es-ES copy).
// Slot mapping for this app:
//   home       → Home dashboard
//   feature1   → Food detail / safe cuts
//   feature2   → Recipes
//   settings   → Food diary + reactions
//   onboarding → Allergens tracker
//
// Highlight word = underlined ASO keyword in the rendered headline.

struct Headline {
    let text: String
    let highlight: String?
}

typealias LocalizedHeadlines = [String: Headline]

struct TreatmentCopy {
    let id: String
    let label: String
    let home: LocalizedHeadlines
    let feature1: LocalizedHeadlines
    let feature2: LocalizedHeadlines
    let settings: LocalizedHeadlines
    let onboarding: LocalizedHeadlines
}

// MARK: - Builder (auto-duplicates es-ES into es-MX)

private func loc(
    en: (String, String?),
    pt: (String, String?),
    es: (String, String?)
) -> LocalizedHeadlines {
    [
        "en-US": Headline(text: en.0, highlight: en.1),
        "pt-BR": Headline(text: pt.0, highlight: pt.1),
        "es-ES": Headline(text: es.0, highlight: es.1),
        "es-MX": Headline(text: es.0, highlight: es.1)
    ]
}

enum Headlines {

    // Round 2 (2026-08) — all copy distinct from the May "BLW Headlines" test.

    // MARK: - Treatment A — Guided / step-by-step (authority angle)

    static let treatmentA = TreatmentCopy(
        id: "A",
        label: "Guided / Step-by-step",
        home: loc(
            en: ("Your starting solids guide", "guide"),
            pt: ("Seu guia de introdução alimentar", "guia"),
            es: ("Tu guía de alimentación", "guía")
        ),
        feature1: loc(
            en: ("How to serve every food", "serve"),
            pt: ("Como servir cada alimento", "servir"),
            es: ("Cómo servir cada alimento", "servir")
        ),
        feature2: loc(
            en: ("Recipes for every month", "Recipes"),
            pt: ("Receitas para cada mês", "Receitas"),
            es: ("Recetas para cada mes", "Recetas")
        ),
        settings: loc(
            en: ("Log meals in seconds", "Log"),
            pt: ("Registre refeições em segundos", "Registre"),
            es: ("Registra comidas en segundos", "Registra")
        ),
        onboarding: loc(
            en: ("Allergens, step by step", "Allergens"),
            pt: ("Alérgenos passo a passo", "Alérgenos"),
            es: ("Alérgenos paso a paso", "Alérgenos")
        )
    )

    // MARK: - Treatment B — Safety-first (fear-relief as the whole narrative)

    static let treatmentB = TreatmentCopy(
        id: "B",
        label: "Safety-first",
        home: loc(
            en: ("Start solids without worry", "worry"),
            pt: ("Introdução alimentar sem medo", "medo"),
            es: ("Sólidos sin miedo", "miedo")
        ),
        feature1: loc(
            en: ("Choke-safe cuts by age", "Choke-safe"),
            pt: ("Cortes seguros por idade", "Cortes seguros"),
            es: ("Cortes seguros por edad", "Cortes seguros")
        ),
        feature2: loc(
            en: ("Recipes you can trust", "trust"),
            pt: ("Receitas seguras por fase", "seguras"),
            es: ("Recetas seguras por etapa", "seguras")
        ),
        settings: loc(
            en: ("Every meal, on record", "record"),
            pt: ("Cada refeição registrada", "registrada"),
            es: ("Cada comida registrada", "registrada")
        ),
        onboarding: loc(
            en: ("The big 9, without fear", "big 9"),
            pt: ("Os 9 alérgenos sem susto", "alérgenos"),
            es: ("Los 9 alérgenos sin susto", "alérgenos")
        )
    )

    // MARK: - Treatment C — Complete toolkit (real content density, honest numbers)

    static let treatmentC = TreatmentCopy(
        id: "C",
        label: "Complete toolkit",
        home: loc(
            en: ("The complete weaning app", "weaning"),
            pt: ("Introdução alimentar completa", "completa"),
            es: ("Alimentación complementaria completa", "completa")
        ),
        feature1: loc(
            en: ("Cut guides for 40+ foods", "Cut guides"),
            pt: ("Guia de corte por alimento", "corte"),
            es: ("Guía de corte por alimento", "corte")
        ),
        feature2: loc(
            en: ("50+ recipes by stage", "recipes"),
            pt: ("50+ receitas por fase", "receitas"),
            es: ("50+ recetas por etapa", "recetas")
        ),
        settings: loc(
            en: ("Diary + PDF export", "Diary"),
            pt: ("Diário + exportação em PDF", "Diário"),
            es: ("Diario + exportación en PDF", "Diario")
        ),
        onboarding: loc(
            en: ("Built-in allergen tracker", "allergen"),
            pt: ("Controle de alérgenos completo", "alérgenos"),
            es: ("Control de alérgenos completo", "alérgenos")
        )
    )

    static let all: [TreatmentCopy] = [treatmentA, treatmentB, treatmentC]
}
