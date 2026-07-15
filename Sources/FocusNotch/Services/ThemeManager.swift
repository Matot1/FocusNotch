import SwiftUI

func currentTheme() -> String {
    UserDefaults.standard.string(forKey: "theme") ?? "dark"
}

struct ThemeColors {
    static func background(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return .white
        case "colorless": return Color(white: 0.95)
        default: return .black
        }
    }

    static func secondaryBackground(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return Color(white: 0.9)
        case "colorless": return Color(white: 0.9)
        default: return Color(white: 0.15)
        }
    }

    static func text(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light", "colorless": return .black
        default: return .white
        }
    }

    static func secondaryText(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return .black.opacity(0.5)
        case "colorless": return .black.opacity(0.4)
        default: return .white.opacity(0.5)
        }
    }

    static func tertiaryText(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return .black.opacity(0.3)
        case "colorless": return .black.opacity(0.3)
        default: return .white.opacity(0.3)
        }
    }

    static func quaternaryText(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return .black.opacity(0.15)
        default: return .white.opacity(0.1)
        }
    }

    static func cardBackground(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return Color(white: 0.95)
        case "colorless": return Color(white: 0.95)
        default: return Color.white.opacity(0.05)
        }
    }

    static func stroke(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return .black.opacity(0.1)
        case "colorless": return .black.opacity(0.08)
        default: return .white.opacity(0.2)
        }
    }

    static func progressBackground(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        switch t {
        case "light": return Color(white: 0.85)
        case "colorless": return Color(white: 0.85)
        default: return Color(white: 0.15)
        }
    }

    static func accent(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        if t == "colorless" {
            return Color(white: 0.4)
        }
        return Color(red: 0.7, green: 0.2, blue: 0.7)
    }

    static func accentDim(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        if t == "colorless" {
            return Color(white: 0.4).opacity(0.4)
        }
        return Color(red: 0.7, green: 0.2, blue: 0.7).opacity(0.4)
    }

    static func toggleTint(_ theme: String? = nil) -> Color {
        let t = theme ?? currentTheme()
        if t == "colorless" {
            return Color(white: 0.5)
        }
        return .orange
    }
}

// MARK: - NSColor variants for AppKit

extension ThemeColors {
    static func nsBackground(_ theme: String? = nil) -> NSColor {
        NSColor(ThemeColors.background(theme))
    }

    static func nsSecondaryBackground(_ theme: String? = nil) -> NSColor {
        NSColor(ThemeColors.secondaryBackground(theme))
    }

    static func nsCardBackground(_ theme: String? = nil) -> NSColor {
        NSColor(ThemeColors.cardBackground(theme))
    }

    static func nsText(_ theme: String? = nil) -> NSColor {
        NSColor(ThemeColors.text(theme))
    }
}