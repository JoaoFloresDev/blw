import SwiftUI
import GambitScreenshotKit

// MARK: - Main Screen (Slot 1 — Home dashboard)
//
// Recreates the BLW home: green greeting banner with hero illustration,
// quick-actions card, and a progress/stats card.

struct MainScreen: View {
    let locale: String

    var body: some View {
        ZStack {
            MockTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                iOSStatusBar()

                VStack(spacing: 16) {
                    banner
                    quickActionsCard
                    // statsCard intentionally omitted — the marketing breakout
                    // (ProgressBreakout) renders it enlarged over the device.
                }
                .padding(20)

                Spacer(minLength: 0)
            }
        }
    }

    // MARK: - Banner

    private var banner: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text(L(BLWStrings.appTitle, locale))
                    .font(.system(size: 23, weight: .heavy))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Text(L(BLWStrings.appSubtitle, locale))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.92))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 8)
            HeroImage(assetName: "home_hero", size: 104)
        }
        .padding(.vertical, 16)
        .padding(.leading, 20)
        .padding(.trailing, 10)
        .background(MockTheme.bannerGradient)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 12, y: 5)
    }

    // MARK: - Quick Actions

    private var quickActionsCard: some View {
        VStack(spacing: 0) {
            cardHeader(icon: "bolt.fill", tint: MockTheme.primary, title: L(BLWStrings.quickActions, locale))
            Divider()
            actionRow(icon: "plus.circle.fill", tint: MockTheme.primary,
                      title: L(BLWStrings.addRecord, locale), sub: L(BLWStrings.addRecordSub, locale))
            Divider().padding(.leading, 56)
            actionRow(icon: "exclamationmark.triangle.fill", tint: MockTheme.secondary,
                      title: L(BLWStrings.allergens, locale), sub: L(BLWStrings.allergensSub, locale))
            Divider().padding(.leading, 56)
            actionRow(icon: "book.fill", tint: MockTheme.purple,
                      title: L(BLWStrings.recipes, locale), sub: L(BLWStrings.recipesSub, locale), pro: true)
        }
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private func actionRow(icon: String, tint: Color, title: String, sub: String, pro: Bool = false) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 23))
                .foregroundStyle(tint)
                .frame(width: 26)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(MockTheme.textPrimary)
                Text(sub)
                    .font(.system(size: 13))
                    .foregroundStyle(MockTheme.textSecondary)
            }
            Spacer()
            if pro {
                Text("PRO")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(MockTheme.secondary, in: Capsule())
            }
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(MockTheme.textTertiary)
        }
        .padding(.horizontal, 16).padding(.vertical, 13)
    }

    // MARK: - Stats

    private var statsCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 12) {
                iconBadge("chart.bar.fill", MockTheme.blue)
                Text(L(BLWStrings.progress, locale))
                    .font(.system(size: 17, weight: .semibold))
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
                        .font(.system(size: 13)).foregroundStyle(MockTheme.textSecondary)
                    Spacer()
                    Text("12 / 200")
                        .font(.system(size: 13, weight: .semibold)).foregroundStyle(MockTheme.primary)
                }
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(MockTheme.separator.opacity(0.3))
                        Capsule().fill(MockTheme.primary).frame(width: geo.size.width * 0.32)
                    }
                }
                .frame(height: 8)
            }
        }
        .padding(20)
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var divider: some View {
        Rectangle().fill(MockTheme.separator).frame(width: 1, height: 50)
    }

    private func stat(_ value: String, _ label: String, _ color: Color) -> some View {
        VStack(spacing: 4) {
            Text(value).font(.system(size: 28, weight: .bold)).foregroundStyle(color)
            Text(label).font(.system(size: 11)).foregroundStyle(MockTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Shared bits

    private func cardHeader(icon: String, tint: Color, title: String) -> some View {
        HStack(spacing: 12) {
            iconBadge(icon, tint)
            Text(title).font(.system(size: 17, weight: .semibold)).foregroundStyle(MockTheme.textPrimary)
            Spacer()
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
    }

    private func iconBadge(_ icon: String, _ tint: Color) -> some View {
        Image(systemName: icon)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: 34, height: 34)
            .background(tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
