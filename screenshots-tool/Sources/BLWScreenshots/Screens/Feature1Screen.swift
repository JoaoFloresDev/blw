import SwiftUI
import GambitScreenshotKit

// MARK: - Feature 1 Screen (Slot 2 — Food detail / safe cuts)
//
// The killer BLW feature: how to cut each food safely to lower choking risk.

struct Feature1Screen: View {
    let locale: String

    var body: some View {
        ZStack {
            MockTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                iOSStatusBar()
                navBar
                VStack(spacing: 16) {
                    foodHeader
                    safeNote
                    // cutCard intentionally omitted — the marketing breakout
                    // (CutStepsBreakout) renders it enlarged over the device.
                }
                .padding(20)

                Spacer(minLength: 0)
            }
        }
    }

    // MARK: - Nav bar

    private var navBar: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(MockTheme.primary)
            Spacer()
            Text(L(BLWStrings.bananaName, locale))
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(MockTheme.textPrimary)
            Spacer()
            Image(systemName: "heart")
                .font(.system(size: 19, weight: .semibold))
                .foregroundStyle(MockTheme.primary)
        }
        .padding(.horizontal, 18).padding(.vertical, 10)
    }

    // MARK: - Food header

    private var foodHeader: some View {
        VStack(spacing: 12) {
            Text("🍌").font(.system(size: 78))
            Text(L(BLWStrings.bananaName, locale))
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(MockTheme.textPrimary)
            HStack(spacing: 8) {
                tag(L(BLWStrings.fruit, locale), MockTheme.primary)
                tag(L(BLWStrings.fromAge, locale), MockTheme.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func tag(_ text: String, _ color: Color) -> some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(color)
            .padding(.horizontal, 12).padding(.vertical, 6)
            .background(color.opacity(0.12), in: Capsule())
    }

    // MARK: - Safe note

    private var safeNote: some View {
        HStack(spacing: 14) {
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 26))
                .foregroundStyle(.white)
            Text(L(BLWStrings.allergenWarning, locale))
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(18)
        .background(MockTheme.primaryGradient)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    // MARK: - Cut steps

    private var cutCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "scissors")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(MockTheme.secondary)
                    .frame(width: 34, height: 34)
                    .background(MockTheme.secondary.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
                Text(L(BLWStrings.howToCut, locale))
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(MockTheme.textPrimary)
            }
            step("1", L(BLWStrings.cutStep1, locale))
            step("2", L(BLWStrings.cutStep2, locale))
            step("3", L(BLWStrings.cutStep3, locale))
        }
        .padding(20)
        .background(MockTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private func step(_ n: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Text(n)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(MockTheme.primary, in: Circle())
            Text(text)
                .font(.system(size: 15))
                .foregroundStyle(MockTheme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
    }
}
