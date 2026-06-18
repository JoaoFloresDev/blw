import SwiftUI

// MARK: - Mock Theme
//
// Decoupled copy of the BLW Flutter app's `AppColors` constants
// (lib/main.dart). The screenshots tool runs as a macOS executable and
// imports nothing from the Flutter app, so we mirror the colors here.

enum MockTheme {
    // MARK: - Background Colors
    static let background = Color(red: 0xF2/255, green: 0xF2/255, blue: 0xF7/255) // iOS system gray 6
    static let cardBackground = Color.white
    static let cardHeader = Color.white

    // MARK: - Text Colors
    static let textPrimary = Color(red: 0x1C/255, green: 0x1C/255, blue: 0x1E/255)
    static let textSecondary = Color(red: 0x8E/255, green: 0x8E/255, blue: 0x93/255)
    static let textTertiary = Color(red: 0xC7/255, green: 0xC7/255, blue: 0xCC/255)

    // MARK: - Accent Colors (iOS system)
    static let primary = Color(red: 0x34/255, green: 0xC7/255, blue: 0x59/255)       // iOS green
    static let primaryDark = Color(red: 0x1F/255, green: 0xA0/255, blue: 0x47/255)
    static let primaryBright = Color(red: 0x3F/255, green: 0xD1/255, blue: 0x68/255)
    static let secondary = Color(red: 0xFF/255, green: 0x95/255, blue: 0x00/255)     // iOS orange
    static let blue = Color(red: 0x00/255, green: 0x7A/255, blue: 0xFF/255)
    static let purple = Color(red: 0xAF/255, green: 0x52/255, blue: 0xDE/255)
    static let indigo = Color(red: 0x58/255, green: 0x56/255, blue: 0xD6/255)
    static let yellow = Color(red: 0xFF/255, green: 0xCC/255, blue: 0x00/255)
    static let destructive = Color(red: 0xFF/255, green: 0x3B/255, blue: 0x30/255)
    static let pink = Color(red: 0xFF/255, green: 0x2D/255, blue: 0x55/255)

    // MARK: - Separator
    static let separator = Color(red: 0xC6/255, green: 0xC6/255, blue: 0xC8/255)
    static let borderLight = Color(red: 0xE5/255, green: 0xE5/255, blue: 0xEA/255)

    // MARK: - Gradients
    static let bannerGradient = LinearGradient(
        colors: [primaryBright, primaryDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let primaryGradient = LinearGradient(
        colors: [primary, primary.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
