import SwiftUI

// MARK: - Breakouts (canonical LOOK)
//
// One WHOLE app section per print, popped out over the device mockup:
// scaled wider than the phone (overflows both bezels), white border +
// soft GLOW in the brand primary — the SAME green on all 5 prints.
// Components are faithful copies of the sections rendered inside the
// device screens, authored at a fixed 430pt width.

let breakoutGlow = MockTheme.primaryBright
let breakoutBaseWidth: CGFloat = 430

// MARK: - Glow card wrapper

struct BreakoutCard<C: View>: View {
    @ViewBuilder let content: () -> C

    var body: some View {
        content()
            .background(MockTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.white.opacity(0.95), lineWidth: 2.5)
            )
            // Flatten before the shadows — without this every child layer
            // casts its own glow INSIDE the card and it renders frosted.
            .compositingGroup()
            .shadow(color: breakoutGlow.opacity(0.90), radius: 30)
            .shadow(color: breakoutGlow.opacity(0.50), radius: 75)
            .shadow(color: .black.opacity(0.28), radius: 22, y: 12)
            .frame(width: breakoutBaseWidth)
    }
}

// MARK: - Slot 1 — Progress card (home)

struct ProgressBreakout: View {
    let locale: String

    var body: some View {
        BreakoutCard {
            VStack(alignment: .leading, spacing: 18) {
                HStack(spacing: 12) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(MockTheme.blue)
                        .frame(width: 42, height: 42)
                        .background(MockTheme.blue.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text(L(BLWStrings.progress, locale))
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(MockTheme.textPrimary)
                }
                HStack {
                    stat("12", L(BLWStrings.foodsTried, locale), MockTheme.primary)
                    divider
                    stat("28", L(BLWStrings.records, locale), MockTheme.blue)
                    divider
                    stat("9", L(BLWStrings.photos, locale), MockTheme.secondary)
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(L(BLWStrings.foodsTried, locale))
                            .font(.system(size: 17)).foregroundStyle(MockTheme.textSecondary)
                        Spacer()
                        Text("12 / 200")
                            .font(.system(size: 17, weight: .semibold)).foregroundStyle(MockTheme.primary)
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(MockTheme.separator.opacity(0.3))
                            Capsule().fill(MockTheme.primary).frame(width: geo.size.width * 0.32)
                        }
                    }
                    .frame(height: 11)
                }
            }
            .padding(20)
        }
    }

    private var divider: some View {
        Rectangle().fill(MockTheme.separator).frame(width: 1, height: 60)
    }

    private func stat(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.system(size: 38, weight: .bold)).foregroundStyle(color)
            Text(label).font(.system(size: 15, weight: .medium)).foregroundStyle(MockTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Slot 2 — Cut steps card (safe cuts)

struct CutStepsBreakout: View {
    let locale: String

    var body: some View {
        BreakoutCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "scissors")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(MockTheme.secondary)
                        .frame(width: 42, height: 42)
                        .background(MockTheme.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Text(L(BLWStrings.howToCut, locale))
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(MockTheme.textPrimary)
                }
                step("1", L(BLWStrings.cutStep1, locale))
                step("2", L(BLWStrings.cutStep2, locale))
                step("3", L(BLWStrings.cutStep3, locale))
            }
            .padding(20)
        }
    }

    private func step(_ n: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Text(n)
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(MockTheme.primary, in: Circle())
            Text(text)
                .font(.system(size: 19))
                .foregroundStyle(MockTheme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
    }
}

// MARK: - Slot 3 — Recipe rows (recipes)

struct RecipesBreakout: View {
    let locale: String

    var body: some View {
        BreakoutCard {
            VStack(spacing: 0) {
                ForEach(Array(BLWData.recipes.prefix(2).enumerated()), id: \.offset) { index, recipe in
                    if index > 0 { Divider().padding(.leading, 82) }
                    row(recipe)
                }
            }
        }
    }

    private func row(_ recipe: RecipeItem) -> some View {
        HStack(spacing: 14) {
            Text(recipe.emoji)
                .font(.system(size: 38))
                .frame(width: 66, height: 66)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text(L(recipe.name, locale))
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundStyle(MockTheme.textPrimary)
                    .lineLimit(1)
                Text(L(recipe.age, locale))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(MockTheme.primary)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(MockTheme.textTertiary)
        }
        .padding(14)
    }
}

// MARK: - Slot 4 — Diary rows (food diary)

struct DiaryBreakout: View {
    let locale: String

    var body: some View {
        BreakoutCard {
            VStack(spacing: 0) {
                ForEach(Array(BLWData.recentDiary.prefix(2).enumerated()), id: \.offset) { index, entry in
                    if index > 0 { Divider().padding(.leading, 76) }
                    row(entry)
                }
            }
        }
    }

    private func row(_ entry: DiaryEntry) -> some View {
        HStack(spacing: 14) {
            Text(entry.emoji)
                .font(.system(size: 34))
                .frame(width: 60, height: 60)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            VStack(alignment: .leading, spacing: 3) {
                Text(L(entry.name, locale))
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(MockTheme.textPrimary)
                Text("\(entry.reaction)  \(L(entry.when, locale))")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(MockTheme.textSecondary)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(MockTheme.textTertiary)
        }
        .padding(14)
    }
}

// MARK: - Slot 5 — Allergen rows (allergen tracker)

struct AllergensBreakout: View {
    let locale: String

    var body: some View {
        BreakoutCard {
            VStack(spacing: 0) {
                ForEach(Array(BLWData.allergens.prefix(3).enumerated()), id: \.offset) { index, item in
                    if index > 0 { Divider().padding(.leading, 76) }
                    row(item)
                }
            }
        }
    }

    private func row(_ item: AllergenItem) -> some View {
        HStack(spacing: 14) {
            Text(item.emoji)
                .font(.system(size: 34))
                .frame(width: 60, height: 60)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            Text(L(item.name, locale))
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(MockTheme.textPrimary)
            Spacer(minLength: 0)
            statusPill(item.introduced)
        }
        .padding(14)
    }

    private func statusPill(_ introduced: Bool) -> some View {
        let color = introduced ? MockTheme.primary : MockTheme.textTertiary
        let label = introduced ? L(BLWStrings.introduced, locale) : L(BLWStrings.pending, locale)
        let icon = introduced ? "checkmark.circle.fill" : "circle"
        return HStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 17, weight: .bold))
            Text(label).font(.system(size: 17, weight: .semibold))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(color.opacity(0.12), in: Capsule())
    }
}
