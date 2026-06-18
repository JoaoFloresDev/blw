import SwiftUI
import GambitScreenshotKit

// MARK: - Onboarding Screen slot (Slot 5 — Allergens tracker)
//
// Despite the file name (template slot), this renders the top-9 allergen
// tracker: each allergen with its introduced / to-try status.

struct OnboardingScreen: View {
    let locale: String

    var body: some View {
        ZStack {
            MockTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                iOSStatusBar()
                navBar
                VStack(spacing: 12) {
                    hero
                    ForEach(BLWData.allergens) { item in
                        allergenRow(item)
                    }
                }
                .padding(20)

                Spacer(minLength: 0)
            }
        }
    }

    private var navBar: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(MockTheme.primary)
            Spacer()
            Text(L(BLWStrings.allergensTitle, locale))
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(MockTheme.textPrimary)
            Spacer()
            Image(systemName: "chevron.left").font(.system(size: 20)).opacity(0)
        }
        .padding(.horizontal, 18).padding(.vertical, 10)
    }

    private var hero: some View {
        HStack(spacing: 14) {
            HeroImage(assetName: "allergens_hero", size: 76)
            VStack(alignment: .leading, spacing: 4) {
                Text(L(BLWStrings.allergensTitle, locale))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Text(L(BLWStrings.allergensSubtitle, locale))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(LinearGradient(colors: [MockTheme.secondary, Color(red: 0xFF/255, green: 0x6B/255, blue: 0x00/255)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func allergenRow(_ item: AllergenItem) -> some View {
        HStack(spacing: 14) {
            Text(item.emoji)
                .font(.system(size: 26))
                .frame(width: 48, height: 48)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            Text(L(item.name, locale))
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(MockTheme.textPrimary)
            Spacer(minLength: 0)
            statusPill(item.introduced)
        }
        .padding(14)
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private func statusPill(_ introduced: Bool) -> some View {
        let color = introduced ? MockTheme.primary : MockTheme.textTertiary
        let label = introduced ? L(BLWStrings.introduced, locale) : L(BLWStrings.pending, locale)
        let icon = introduced ? "checkmark.circle.fill" : "circle"
        return HStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 13, weight: .bold))
            Text(label).font(.system(size: 13, weight: .semibold))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(color.opacity(0.12), in: Capsule())
    }
}
