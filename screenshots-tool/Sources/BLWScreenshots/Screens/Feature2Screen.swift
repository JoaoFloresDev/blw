import SwiftUI
import GambitScreenshotKit

// MARK: - Feature 2 Screen (Slot 3 — Recipes)
//
// Age-appropriate, baby-led recipes list.

struct Feature2Screen: View {
    let locale: String

    var body: some View {
        ZStack {
            MockTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                iOSStatusBar()
                navBar
                VStack(spacing: 14) {
                    hero
                    ForEach(BLWData.recipes) { recipe in
                        recipeCard(recipe)
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
            Text(L(BLWStrings.recipesTitle, locale))
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(MockTheme.textPrimary)
            Spacer()
            Image(systemName: "chevron.left").font(.system(size: 20)).opacity(0)
        }
        .padding(.horizontal, 18).padding(.vertical, 10)
    }

    private var hero: some View {
        HStack(spacing: 14) {
            HeroImage(assetName: "recipes_hero", size: 76)
            VStack(alignment: .leading, spacing: 4) {
                Text(L(BLWStrings.recipesTitle, locale))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Text(L(BLWStrings.recipesSubtitle, locale))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(LinearGradient(colors: [MockTheme.purple, MockTheme.indigo],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func recipeCard(_ recipe: RecipeItem) -> some View {
        HStack(spacing: 14) {
            Text(recipe.emoji)
                .font(.system(size: 30))
                .frame(width: 54, height: 54)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text(L(recipe.name, locale))
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(MockTheme.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                Text(L(recipe.age, locale))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(MockTheme.primary)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(MockTheme.textTertiary)
        }
        .padding(14)
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
