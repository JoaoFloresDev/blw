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

    // Round 2 (2026-08) — canonical verb-split LOOK. The FIRST word renders
    // huge alone on line 1 (kit `splitFirstWord`); the rest goes on line 2.
    // Budgets measured with AppKit at 6.5" (col 1082pt): line 1 ≤ 161pt·len,
    // line 2 ≤ 24 chars. All entries below verified OK. Highlight is unused
    // in verb-split mode (nil).

    // MARK: - Treatment A — Direct benefit (verb + outcome, keyword-led)

    static let treatmentA = TreatmentCopy(
        id: "A",
        label: "Direct benefit",
        home: loc(
            en: ("Start solids the easy way", nil),
            pt: ("Comece a introdução alimentar", nil),
            es: ("Empieza la alimentación", nil)
        ),
        feature1: loc(
            en: ("Cut every food safely", nil),
            pt: ("Corte cada alimento seguro", nil),
            es: ("Corta cada alimento seguro", nil)
        ),
        feature2: loc(
            en: ("Cook recipes by age", nil),
            pt: ("Cozinhe receitas por fase", nil),
            es: ("Cocina recetas por etapa", nil)
        ),
        settings: loc(
            en: ("Log meals in seconds", nil),
            pt: ("Registre refeições em segundos", nil),
            es: ("Registra comidas en segundos", nil)
        ),
        onboarding: loc(
            en: ("Track the 9 allergens", nil),
            pt: ("Controle os 9 alérgenos", nil),
            es: ("Controla los 9 alérgenos", nil)
        )
    )

    // MARK: - Treatment B — Fear-relief (safety as the whole narrative)

    static let treatmentB = TreatmentCopy(
        id: "B",
        label: "Fear-relief / Safety",
        home: loc(
            en: ("Relax baby eats safely", nil),
            pt: ("Relaxe seu bebê come seguro", nil),
            es: ("Relájate tu bebé come seguro", nil)
        ),
        feature1: loc(
            en: ("Avoid choking risks", nil),
            pt: ("Evite riscos de engasgo", nil),
            es: ("Evita atragantamientos", nil)
        ),
        feature2: loc(
            en: ("Trust every recipe", nil),
            pt: ("Confie em cada receita", nil),
            es: ("Confía en cada receta", nil)
        ),
        settings: loc(
            en: ("Spot reactions early", nil),
            pt: ("Detecte reações cedo", nil),
            es: ("Detecta reacciones a tiempo", nil)
        ),
        onboarding: loc(
            en: ("Master the 9 allergens", nil),
            pt: ("Domine os 9 alérgenos", nil),
            es: ("Domina los 9 alérgenos", nil)
        )
    )

    // MARK: - Treatment C — Complete toolkit (honest numbers: 40 foods, 52 recipes)

    static let treatmentC = TreatmentCopy(
        id: "C",
        label: "Complete toolkit",
        home: loc(
            en: ("All of BLW in one app", nil),
            pt: ("Tudo do BLW num só app", nil),
            es: ("Todo el BLW en una app", nil)
        ),
        feature1: loc(
            en: ("Serve 40+ foods, cut right", nil),
            pt: ("Sirva 40+ alimentos certos", nil),
            es: ("Sirve 40+ alimentos bien", nil)
        ),
        feature2: loc(
            en: ("Unlock 50+ recipes by stage", nil),
            pt: ("Acesse 50+ receitas por fase", nil),
            es: ("Accede a 50+ recetas", nil)
        ),
        settings: loc(
            en: ("Export your diary as PDF", nil),
            pt: ("Exporte o diário em PDF", nil),
            es: ("Exporta el diario en PDF", nil)
        ),
        onboarding: loc(
            en: ("Check all 9 allergens", nil),
            pt: ("Marque os 9 alérgenos", nil),
            es: ("Marca los 9 alérgenos", nil)
        )
    )

    static let all: [TreatmentCopy] = [treatmentA, treatmentB, treatmentC]
}
