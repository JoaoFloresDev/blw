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

    // MARK: - Treatment A — Direct / Action (verb + benefit, keyword-led)

    static let treatmentA = TreatmentCopy(
        id: "A",
        label: "Direct / Action",
        home: loc(
            en: ("Start solids with confidence", "solids"),
            pt: ("Comece a introdução alimentar", "introdução"),
            es: ("Empieza la alimentación complementaria", "alimentación")
        ),
        feature1: loc(
            en: ("Cut every food safely", "safely"),
            pt: ("Corte cada alimento com segurança", "segurança"),
            es: ("Corta cada alimento con seguridad", "seguridad")
        ),
        feature2: loc(
            en: ("Recipes for every stage", "Recipes"),
            pt: ("Receitas para cada fase", "Receitas"),
            es: ("Recetas para cada etapa", "Recetas")
        ),
        settings: loc(
            en: ("Track every new food", nil),
            pt: ("Registre cada novo alimento", nil),
            es: ("Registra cada nuevo alimento", nil)
        ),
        onboarding: loc(
            en: ("Introduce allergens safely", "allergens"),
            pt: ("Introduza alérgenos com segurança", "alérgenos"),
            es: ("Introduce alérgenos con seguridad", "alérgenos")
        )
    )

    // MARK: - Treatment B — Emotional / Aspirational (parent peace of mind)

    static let treatmentB = TreatmentCopy(
        id: "B",
        label: "Emotional / Aspirational",
        home: loc(
            en: ("Every first food, one happy place", nil),
            pt: ("Cada primeira papinha num só lugar", nil),
            es: ("Cada primer alimento en un solo lugar", nil)
        ),
        feature1: loc(
            en: ("No more choking worries", "choking"),
            pt: ("Sem medo de engasgo", "engasgo"),
            es: ("Sin miedo al atragantamiento", "atragantamiento")
        ),
        feature2: loc(
            en: ("Always know what to cook", nil),
            pt: ("Sempre saiba o que cozinhar", nil),
            es: ("Siempre sabrás qué cocinar", nil)
        ),
        settings: loc(
            en: ("Spot reactions early", nil),
            pt: ("Perceba reações antes", nil),
            es: ("Detecta reacciones a tiempo", nil)
        ),
        onboarding: loc(
            en: ("Confident with the big 9", nil),
            pt: ("Segurança com os 9 principais", nil),
            es: ("Tranquilidad con los 9 principales", nil)
        )
    )

    // MARK: - Treatment C — Feature / Tech (specific differentiator)

    static let treatmentC = TreatmentCopy(
        id: "C",
        label: "Feature / Technical",
        home: loc(
            en: ("Your complete BLW hub", "BLW"),
            pt: ("Tudo do BLW num só app", "BLW"),
            es: ("Todo el BLW en una sola app", "BLW")
        ),
        feature1: loc(
            en: ("Safe cuts for 200+ foods", "Safe cuts"),
            pt: ("Cortes seguros para 200+ alimentos", "Cortes seguros"),
            es: ("Cortes seguros para 200+ alimentos", "Cortes seguros")
        ),
        feature2: loc(
            en: ("Age-based weaning recipes", "weaning recipes"),
            pt: ("Receitas de papinha por idade", "Receitas de papinha"),
            es: ("Recetas de papillas por edad", "Recetas de papillas")
        ),
        settings: loc(
            en: ("Food diary + reaction log", "diary"),
            pt: ("Diário + registro de reações", "Diário"),
            es: ("Diario + registro de reacciones", "Diario")
        ),
        onboarding: loc(
            en: ("Track all 9 top allergens", "allergens"),
            pt: ("Acompanhe os 9 alérgenos", "alérgenos"),
            es: ("Controla los 9 alérgenos", "alérgenos")
        )
    )

    static let all: [TreatmentCopy] = [treatmentA, treatmentB, treatmentC]
}
