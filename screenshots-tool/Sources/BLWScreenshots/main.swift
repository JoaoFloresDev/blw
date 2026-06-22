import SwiftUI
import AppKit
import GambitScreenshotKit

// MARK: - Render Pipeline (TEMPLATE — customize for your app)
//
// Two modes:
//   • initial → 1 set per locale at iPhone 6.9" → fastlane sync_screenshots_initial
//   • abtest  → 3 treatments × N locales × 5 screens at the display type that
//               matches the app's existing default product page → upload_ppo.py
//
// CHANGE the `outputBase` path below to match your app's fastlane folder.
// CHANGE `device` for the abtest case to match your default product page's
// display type (query ASC if unsure — see the /generate-a-b-test skill).

enum RenderMode { case abtest, initial }

struct PipelineError: Error, CustomStringConvertible {
    let description: String
}

/// Fail fast if any headline still contains a TODO placeholder. Without this,
/// the renderer will happily emit screenshots with literal "TODO:" text on
/// them — and the agent might miss it on a quick visual scan. Treatments
/// not used by the active mode are not validated.
@MainActor
func validateNoTODOs(in treatments: [TreatmentCopy], locales: [String]) throws {
    var problems: [String] = []
    for t in treatments {
        let slots: [(String, LocalizedHeadlines)] = [
            ("home",       t.home),
            ("feature1",   t.feature1),
            ("feature2",   t.feature2),
            ("settings",   t.settings),
            ("onboarding", t.onboarding)
        ]
        for (slotName, slot) in slots {
            for locale in locales {
                let headline = slot[locale]?.text ?? ""
                if headline.isEmpty || headline.uppercased().contains("TODO:") {
                    problems.append("  treatment \(t.id) / \(slotName) / \(locale): \(headline.isEmpty ? "<empty>" : headline)")
                }
            }
        }
    }
    if !problems.isEmpty {
        throw PipelineError(description:
            "Headlines.swift still has \(problems.count) TODO/empty headline(s) for the active mode:\n" +
            problems.joined(separator: "\n") +
            "\nFill them in (with user-approved copy) before rendering."
        )
    }
}

@MainActor
func runFullRenderPipeline(mode: RenderMode) throws {
    // TODO: replace with your app's fastlane/screenshots path
    let outputBase = URL(fileURLWithPath: NSString(string: "../fastlane/screenshots").expandingTildeInPath)
    try FileManager.default.createDirectory(at: outputBase, withIntermediateDirectories: true)

    // For initial submissions Apple requires 6.9" (1320×2868). For PPO
    // experiments use whatever the app's existing default product page uses
    // (commonly 6.5" for older apps, 6.9" for newer).
    let device: DeviceKind = (mode == .initial) ? .iPhone6_9 : .iPhone6_5
    let canvas = device.canvasSize
    let locales = ["en-US", "pt-BR", "es-ES", "es-MX"]

    let contentLocaleMap: [String: String] = [
        "es-MX": "es-ES"  // re-use es-ES content for es-MX
    ]

    let treatments: [TreatmentCopy] = (mode == .initial) ? [Headlines.treatmentA] : Headlines.all

    // Forcing function: never render placeholder copy.
    try validateNoTODOs(in: treatments, locales: locales)

    var totalRendered = 0

    for treatment in treatments {
        let baseDir: URL = (mode == .initial)
            ? outputBase.appendingPathComponent("initial")
            : outputBase.appendingPathComponent("treatment_\(treatment.id)")

        for locale in locales {
            let uploadDir = baseDir.appendingPathComponent(locale)
            try FileManager.default.createDirectory(at: uploadDir, withIntermediateDirectories: true)

            let contentLocale = contentLocaleMap[locale] ?? locale

            switch mode {
            case .initial:
                try renderLocaleSet(treatment: treatment, locale: contentLocale, outputLocale: locale,
                                    device: device, canvas: canvas, outputDir: uploadDir, validationDir: nil)
                totalRendered += 5
                print("✅ initial / \(locale) — 5 PNGs done")

            case .abtest:
                let validationDir = baseDir.appendingPathComponent("_validation")
                try FileManager.default.createDirectory(at: validationDir, withIntermediateDirectories: true)
                try renderLocaleSet(treatment: treatment, locale: contentLocale, outputLocale: locale,
                                    device: device, canvas: canvas, outputDir: uploadDir, validationDir: validationDir)
                totalRendered += 6
                print("✅ treatment_\(treatment.id) / \(locale) — 5 upload + 1 validation done")
            }
        }
    }

    print("\n\(totalRendered) PNGs rendered at: \(outputBase.path)")
}

// MARK: - Per-Locale Rendering

@MainActor
func renderLocaleSet(
    treatment: TreatmentCopy,
    locale: String,
    outputLocale: String,
    device: DeviceKind,
    canvas: CGSize,
    outputDir: URL,
    validationDir: URL?
) throws {
    let totalSlots = 5

    // Slot 1: Main / Home
    let url1 = outputDir.appendingPathComponent("01_main_iphone.png")
    try render(view: marketing(device: device, slot: 0, totalSlots: totalSlots,
                                headline: treatment.home[locale]) { MainScreen(locale: locale) },
                canvas: canvas, scale: 1.0, to: url1)

    // Slot 2: Feature 1
    let url2 = outputDir.appendingPathComponent("02_feature1_iphone.png")
    try render(view: marketing(device: device, slot: 1, totalSlots: totalSlots,
                                headline: treatment.feature1[locale]) { Feature1Screen(locale: locale) },
                canvas: canvas, scale: 1.0, to: url2)

    // Slot 3: Feature 2
    let url3 = outputDir.appendingPathComponent("03_feature2_iphone.png")
    try render(view: marketing(device: device, slot: 2, totalSlots: totalSlots,
                                headline: treatment.feature2[locale]) { Feature2Screen(locale: locale) },
                canvas: canvas, scale: 1.0, to: url3)

    // Slot 4: Settings
    let url4 = outputDir.appendingPathComponent("04_settings_iphone.png")
    try render(view: marketing(device: device, slot: 3, totalSlots: totalSlots,
                                headline: treatment.settings[locale]) { SettingsScreen(locale: locale) },
                canvas: canvas, scale: 1.0, to: url4)

    // Slot 5: Onboarding
    let url5 = outputDir.appendingPathComponent("05_onboarding_iphone.png")
    try render(view: marketing(device: device, slot: 4, totalSlots: totalSlots,
                                headline: treatment.onboarding[locale]) { OnboardingScreen(locale: locale) },
                canvas: canvas, scale: 1.0, to: url5)

    // Slot 6: App Store listing mockup (validation only, abtest mode only)
    if let validationDir = validationDir {
        let urlMockup = validationDir.appendingPathComponent("06_appstore_listing_\(outputLocale).png")
        try render(
            view: AppStoreListingMockup(
                appName: LocalizedListing.appName[locale] ?? "TODO: App Name",
                subtitle: LocalizedListing.subtitle[locale] ?? "TODO: Subtitle",
                searchQuery: L(["en-US": "baby led weaning", "pt-BR": "introdução alimentar", "es-ES": "alimentación complementaria"], locale),
                screenshotURLs: [url1, url2, url3]
            ) {
                DefaultAppIcon(size: 110)
            },
            canvas: device.screenPointSize,
            scale: 3.0,
            to: urlMockup
        )
    }
}

// MARK: - Marketing Wrapper Helper

@MainActor
@ViewBuilder
func marketing<Content: View>(
    device: DeviceKind,
    slot: Int,
    totalSlots: Int,
    headline: Headline?,
    @ViewBuilder content: () -> Content
) -> some View {
    let h = headline ?? Headline(text: "", highlight: nil)
    MarketingScreen(
        device: device,
        headline: h.text,
        highlightWord: h.highlight,
        slotIndex: slot,
        totalSlots: totalSlots,
        theme: blwTheme,
        content: content
    )
}

// MARK: - BLW brand marketing theme (warm light green, niche = health/baby)

let blwTheme = MarketingTheme(
    baseColor: Color(red: 0.95, green: 0.99, blue: 0.96),
    blobBright: Color(red: 0.83, green: 0.96, blue: 0.86),
    blobMid:    Color(red: 0.88, green: 0.97, blue: 0.90),
    blobDeep:   Color(red: 0.78, green: 0.93, blue: 0.82),
    rayLeft:    Color.white.opacity(0.45),
    rayRight:   Color(red: 0.88, green: 0.97, blue: 0.90).opacity(0.55),
    highlightGlow: Color.clear,
    headlineTop: Color(red: 0.09, green: 0.22, blue: 0.13),
    headlineBottom: Color(red: 0.09, green: 0.22, blue: 0.13),
    headlineDepthShadow: Color.clear,
    blobBlendMode: .multiply,
    vignetteColor: Color(red: 0.55, green: 0.78, blue: 0.60),
    deviceContactShadow: Color(red: 0.20, green: 0.45, blue: 0.28).opacity(0.22)
)

// MARK: - Render Helper

@MainActor
func render<V: View>(view: V, canvas: CGSize, scale: CGFloat, to url: URL) throws {
    let sized = view.frame(width: canvas.width, height: canvas.height)
    let renderer = ImageRenderer(content: sized)
    renderer.scale = scale
    renderer.proposedSize = ProposedViewSize(width: canvas.width, height: canvas.height)

    guard let cg = renderer.cgImage else {
        throw NSError(domain: "Screenshots", code: 1,
                      userInfo: [NSLocalizedDescriptionKey: "ImageRenderer returned nil for \(url.lastPathComponent)"])
    }
    let bitmap = NSBitmapImageRep(cgImage: cg)
    bitmap.size = NSSize(width: cg.width, height: cg.height)
    guard let data = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "Screenshots", code: 2,
                      userInfo: [NSLocalizedDescriptionKey: "PNG encoding failed for \(url.lastPathComponent)"])
    }
    try data.write(to: url)
}

// MARK: - Raw screens mode (clean app screenshots for Nano Banana compose)

@MainActor
func renderRawScreens() throws {
    let device = DeviceKind.iPhone6_5
    let canvas = device.screenPointSize            // 414×896 pts
    let locale = "en-US"
    let outDir = URL(fileURLWithPath: NSString(string: "../fastlane/raw-screens").expandingTildeInPath)
    try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

    let screens: [(String, AnyView)] = [
        ("01_home",      AnyView(MainScreen(locale: locale))),
        ("02_safecuts",  AnyView(Feature1Screen(locale: locale))),
        ("03_recipes",   AnyView(Feature2Screen(locale: locale))),
        ("04_diary",     AnyView(SettingsScreen(locale: locale))),
        ("05_allergens", AnyView(OnboardingScreen(locale: locale)))
    ]
    for (name, view) in screens {
        let url = outDir.appendingPathComponent("\(name).png")
        try render(view: view, canvas: canvas, scale: 3.0, to: url)
        print("✅ raw screen \(name) — done")
    }
    print("\n5 raw screens at: \(outDir.path)")
}

MainActor.assumeIsolated {
    if CommandLine.arguments.contains("screens") {
        print("📱 Mode: RAW SCREENS — clean app screenshots for Nano Banana")
        do { try renderRawScreens() } catch { print("❌ \(error)"); exit(1) }
    } else {
        let mode: RenderMode = CommandLine.arguments.contains("initial") ? .initial : .abtest
        print(mode == .initial
              ? "🎬 Mode: INITIAL — single set per locale at 6.9\" (default product page)"
              : "🧪 Mode: A/B TEST — 3 treatments × N locales (PPO experiment)")
        do {
            try runFullRenderPipeline(mode: mode)
        } catch {
            print("❌ Pipeline failed: \(error)")
            exit(1)
        }
    }
}
