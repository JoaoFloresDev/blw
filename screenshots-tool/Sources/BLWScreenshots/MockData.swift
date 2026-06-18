import SwiftUI
import AppKit

// MARK: - Localized helper
//
// Tiny helper: pick a value for a locale, falling back to es-ES for es-MX
// and finally to en-US.

func L(_ map: [String: String], _ locale: String) -> String {
    map[locale] ?? map["es-ES"] ?? map["en-US"] ?? ""
}

// MARK: - Hero Image Loader (bundled real app illustrations)

struct HeroImage: View {
    let assetName: String
    let size: CGFloat

    var body: some View {
        if let url = Bundle.module.url(forResource: assetName, withExtension: "png"),
           let nsImage = NSImage(contentsOf: url) {
            Image(nsImage: nsImage)
                .resizable()
                .interpolation(.high)
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            RoundedRectangle(cornerRadius: size * 0.2)
                .fill(MockTheme.primary.opacity(0.2))
                .frame(width: size, height: size)
        }
    }
}

// MARK: - Curated content models

struct DiaryEntry: Identifiable {
    let id = UUID()
    let emoji: String
    let name: [String: String]
    let reaction: String      // acceptance emoji
    let when: [String: String]
}

struct RecipeItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: [String: String]
    let age: [String: String]
}

struct AllergenItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: [String: String]
    let introduced: Bool
}

// MARK: - Section / common labels per screen

enum BLWStrings {
    // Home banner
    static let appTitle: [String: String] = [
        "en-US": "Baby Led Weaning",
        "pt-BR": "Introdução Alimentar",
        "es-ES": "Alimentación Complementaria"
    ]
    static let appSubtitle: [String: String] = [
        "en-US": "Track your baby's first foods",
        "pt-BR": "Acompanhe os primeiros alimentos",
        "es-ES": "Sigue los primeros alimentos del bebé"
    ]

    // Home — quick actions
    static let quickActions: [String: String] = [
        "en-US": "Quick actions", "pt-BR": "Ações rápidas", "es-ES": "Acciones rápidas"
    ]
    static let addRecord: [String: String] = [
        "en-US": "Add record", "pt-BR": "Registrar alimento", "es-ES": "Registrar alimento"
    ]
    static let addRecordSub: [String: String] = [
        "en-US": "Log a new food today", "pt-BR": "Registre um novo alimento", "es-ES": "Registra un nuevo alimento"
    ]
    static let allergens: [String: String] = [
        "en-US": "Allergens", "pt-BR": "Alérgenos", "es-ES": "Alérgenos"
    ]
    static let allergensSub: [String: String] = [
        "en-US": "Introduce them safely", "pt-BR": "Introduza com segurança", "es-ES": "Introdúcelos con seguridad"
    ]
    static let recipes: [String: String] = [
        "en-US": "Recipes", "pt-BR": "Receitas", "es-ES": "Recetas"
    ]
    static let recipesSub: [String: String] = [
        "en-US": "Ideas for every stage", "pt-BR": "Ideias para cada fase", "es-ES": "Ideas para cada etapa"
    ]

    // Home — stats
    static let progress: [String: String] = [
        "en-US": "Progress", "pt-BR": "Progresso", "es-ES": "Progreso"
    ]
    static let foodsTried: [String: String] = [
        "en-US": "Foods tried", "pt-BR": "Alimentos provados", "es-ES": "Alimentos probados"
    ]
    static let records: [String: String] = [
        "en-US": "Records", "pt-BR": "Registros", "es-ES": "Registros"
    ]
    static let photos: [String: String] = [
        "en-US": "Photos", "pt-BR": "Fotos", "es-ES": "Fotos"
    ]
    static let recentActivity: [String: String] = [
        "en-US": "Recent activity", "pt-BR": "Atividade recente", "es-ES": "Actividad reciente"
    ]
    static let today: [String: String] = [
        "en-US": "Today", "pt-BR": "Hoje", "es-ES": "Hoy"
    ]
    static let yesterday: [String: String] = [
        "en-US": "Yesterday", "pt-BR": "Ontem", "es-ES": "Ayer"
    ]

    // Food detail (safe cuts)
    static let fromAge: [String: String] = [
        "en-US": "From 6 months", "pt-BR": "A partir de 6 meses", "es-ES": "Desde los 6 meses"
    ]
    static let fruit: [String: String] = [
        "en-US": "Fruit", "pt-BR": "Fruta", "es-ES": "Fruta"
    ]
    static let howToCut: [String: String] = [
        "en-US": "How to cut safely", "pt-BR": "Como cortar com segurança", "es-ES": "Cómo cortar con seguridad"
    ]
    static let allergenWarning: [String: String] = [
        "en-US": "Low choking risk when prepared this way",
        "pt-BR": "Baixo risco de engasgo se preparado assim",
        "es-ES": "Bajo riesgo de atragantamiento así preparado"
    ]
    static let bananaName: [String: String] = [
        "en-US": "Banana", "pt-BR": "Banana", "es-ES": "Plátano"
    ]
    static let cutStep1: [String: String] = [
        "en-US": "Leave half the peel on as a natural grip",
        "pt-BR": "Deixe metade da casca como pega natural",
        "es-ES": "Deja media cáscara como agarre natural"
    ]
    static let cutStep2: [String: String] = [
        "en-US": "Cut lengthwise into finger-sized sticks",
        "pt-BR": "Corte no comprimento em tiras do tamanho do dedo",
        "es-ES": "Corta a lo largo en tiras del tamaño de un dedo"
    ]
    static let cutStep3: [String: String] = [
        "en-US": "Roll in oat flour so it's easy to grasp",
        "pt-BR": "Passe na farinha de aveia para firmar a pega",
        "es-ES": "Pásalo por harina de avena para mejor agarre"
    ]

    // Recipes screen
    static let recipesTitle: [String: String] = [
        "en-US": "Recipes", "pt-BR": "Receitas", "es-ES": "Recetas"
    ]
    static let recipesSubtitle: [String: String] = [
        "en-US": "Age-appropriate, baby-led ideas",
        "pt-BR": "Ideias por idade, no estilo BLW",
        "es-ES": "Ideas por edad, estilo BLW"
    ]

    // Diary screen
    static let diaryTitle: [String: String] = [
        "en-US": "Food diary", "pt-BR": "Diário alimentar", "es-ES": "Diario alimentario"
    ]
    static let diarySubtitle: [String: String] = [
        "en-US": "Every food and reaction, logged",
        "pt-BR": "Cada alimento e reação, registrados",
        "es-ES": "Cada alimento y reacción, registrados"
    ]

    // Allergens screen
    static let allergensTitle: [String: String] = [
        "en-US": "Top 9 allergens", "pt-BR": "9 principais alérgenos", "es-ES": "9 alérgenos principales"
    ]
    static let allergensSubtitle: [String: String] = [
        "en-US": "Track each one as you introduce it",
        "pt-BR": "Acompanhe cada um na introdução",
        "es-ES": "Sigue cada uno en la introducción"
    ]
    static let introduced: [String: String] = [
        "en-US": "Introduced", "pt-BR": "Introduzido", "es-ES": "Introducido"
    ]
    static let pending: [String: String] = [
        "en-US": "To try", "pt-BR": "A introduzir", "es-ES": "Por probar"
    ]
}

// MARK: - Curated data sets

enum BLWData {
    static let recentDiary: [DiaryEntry] = [
        DiaryEntry(emoji: "🥑", name: ["en-US": "Avocado", "pt-BR": "Abacate", "es-ES": "Aguacate"],
                   reaction: "😋", when: BLWStrings.today),
        DiaryEntry(emoji: "🥦", name: ["en-US": "Broccoli", "pt-BR": "Brócolis", "es-ES": "Brócoli"],
                   reaction: "🙂", when: BLWStrings.today),
        DiaryEntry(emoji: "🍓", name: ["en-US": "Strawberry", "pt-BR": "Morango", "es-ES": "Fresa"],
                   reaction: "😋", when: BLWStrings.yesterday)
    ]

    static let recipes: [RecipeItem] = [
        RecipeItem(emoji: "🥞", name: ["en-US": "Banana pancakes", "pt-BR": "Panqueca de banana", "es-ES": "Tortitas de plátano"],
                   age: ["en-US": "6+ months", "pt-BR": "6+ meses", "es-ES": "6+ meses"]),
        RecipeItem(emoji: "🥣", name: ["en-US": "Oat & fruit porridge", "pt-BR": "Mingau de aveia com frutas", "es-ES": "Avena con frutas"],
                   age: ["en-US": "6+ months", "pt-BR": "6+ meses", "es-ES": "6+ meses"]),
        RecipeItem(emoji: "🍳", name: ["en-US": "Creamy scrambled egg", "pt-BR": "Ovo mexido cremoso", "es-ES": "Huevo revuelto cremoso"],
                   age: ["en-US": "7+ months", "pt-BR": "7+ meses", "es-ES": "7+ meses"]),
        RecipeItem(emoji: "🥔", name: ["en-US": "Potato & carrot mash", "pt-BR": "Purê de batata e cenoura", "es-ES": "Puré de patata y zanahoria"],
                   age: ["en-US": "6+ months", "pt-BR": "6+ meses", "es-ES": "6+ meses"]),
        RecipeItem(emoji: "🍗", name: ["en-US": "Shredded chicken & veg", "pt-BR": "Frango desfiado com legumes", "es-ES": "Pollo desmenuzado con verduras"],
                   age: ["en-US": "8+ months", "pt-BR": "8+ meses", "es-ES": "8+ meses"]),
        RecipeItem(emoji: "🐟", name: ["en-US": "Fish with vegetables", "pt-BR": "Peixe com legumes", "es-ES": "Pescado con verduras"],
                   age: ["en-US": "9+ months", "pt-BR": "9+ meses", "es-ES": "9+ meses"])
    ]

    static let allergens: [AllergenItem] = [
        AllergenItem(emoji: "🥚", name: ["en-US": "Egg", "pt-BR": "Ovo", "es-ES": "Huevo"], introduced: true),
        AllergenItem(emoji: "🥜", name: ["en-US": "Peanut", "pt-BR": "Amendoim", "es-ES": "Cacahuete"], introduced: true),
        AllergenItem(emoji: "🥛", name: ["en-US": "Dairy", "pt-BR": "Leite", "es-ES": "Lácteos"], introduced: true),
        AllergenItem(emoji: "🌾", name: ["en-US": "Wheat", "pt-BR": "Trigo", "es-ES": "Trigo"], introduced: false),
        AllergenItem(emoji: "🐟", name: ["en-US": "Fish", "pt-BR": "Peixe", "es-ES": "Pescado"], introduced: false),
        AllergenItem(emoji: "🦐", name: ["en-US": "Shellfish", "pt-BR": "Frutos do mar", "es-ES": "Marisco"], introduced: false),
        AllergenItem(emoji: "🌰", name: ["en-US": "Tree nuts", "pt-BR": "Castanhas", "es-ES": "Frutos secos"], introduced: false),
        AllergenItem(emoji: "🫘", name: ["en-US": "Soy", "pt-BR": "Soja", "es-ES": "Soja"], introduced: false)
    ]
}

// MARK: - Localized App Listing Strings (used by App Store mockup)

enum LocalizedListing {
    static let appName: [String: String] = [
        "en-US": "BLW Baby Led Weaning",
        "pt-BR": "Introdução Alimentar BLW",
        "es-ES": "Alimentación Complementaria",
        "es-MX": "Alimentación Complementaria"
    ]
    static let subtitle: [String: String] = [
        "en-US": "First Foods & Solid Starts Log",
        "pt-BR": "Papinha, Receitas Solid Starts",
        "es-ES": "BLW, Comida Bebé y Papillas",
        "es-MX": "BLW, Comida Bebé y Papillas"
    ]
}
