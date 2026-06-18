import SwiftUI
import GambitScreenshotKit

// MARK: - Settings Screen slot (Slot 4 — Food diary + reactions)
//
// Despite the file name (template slot), this renders the food diary:
// every food logged with the baby's acceptance reaction and date.

struct SettingsScreen: View {
    let locale: String

    var body: some View {
        ZStack {
            MockTheme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                iOSStatusBar()
                header
                VStack(spacing: 12) {
                    ForEach(BLWData.recentDiary) { entry in
                        diaryRow(entry)
                    }
                    ForEach(extraEntries) { entry in
                        diaryRow(entry)
                    }
                }
                .padding(20)

                Spacer(minLength: 0)
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(L(BLWStrings.diaryTitle, locale))
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(MockTheme.textPrimary)
            Text(L(BLWStrings.diarySubtitle, locale))
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(MockTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20).padding(.top, 6).padding(.bottom, 10)
    }

    // MARK: - Row

    private func diaryRow(_ entry: DiaryEntry) -> some View {
        HStack(spacing: 14) {
            Text(entry.emoji)
                .font(.system(size: 26))
                .frame(width: 48, height: 48)
                .background(MockTheme.background, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            VStack(alignment: .leading, spacing: 3) {
                Text(L(entry.name, locale))
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(MockTheme.textPrimary)
                Text("\(entry.reaction)  \(L(entry.when, locale))")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(MockTheme.textSecondary)
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

    // MARK: - Extra curated entries (to fill the list)

    private var extraEntries: [DiaryEntry] {
        [
            DiaryEntry(emoji: "🍠", name: ["en-US": "Sweet potato", "pt-BR": "Batata-doce", "es-ES": "Batata"],
                       reaction: "😋", when: ["en-US": "2 days ago", "pt-BR": "Há 2 dias", "es-ES": "Hace 2 días"]),
            DiaryEntry(emoji: "🥚", name: ["en-US": "Egg", "pt-BR": "Ovo", "es-ES": "Huevo"],
                       reaction: "🙂", when: ["en-US": "3 days ago", "pt-BR": "Há 3 dias", "es-ES": "Hace 3 días"]),
            DiaryEntry(emoji: "🥕", name: ["en-US": "Carrot", "pt-BR": "Cenoura", "es-ES": "Zanahoria"],
                       reaction: "😐", when: ["en-US": "4 days ago", "pt-BR": "Há 4 dias", "es-ES": "Hace 4 días"])
        ]
    }
}
