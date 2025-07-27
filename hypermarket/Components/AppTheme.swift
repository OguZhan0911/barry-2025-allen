import SwiftUI

struct AppColors {
    static let primary = Color.blue
    static let secondary = Color.cyan
    static let background = Color(.systemGray6)
    static let card = Color.white
    static let cardShadow = Color(.systemGray3).opacity(0.13)
    static let tagBackground = Color(.systemGray5)
    static let tagText = Color.gray
    static let star = Color.yellow
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
}

struct AppFonts {
    static let largeTitle = Font.system(size: 32, weight: .bold)
    static let title = Font.system(size: 24, weight: .bold)
    static let headline = Font.system(size: 18, weight: .semibold)
    static let subheadline = Font.system(size: 16, weight: .regular)
    static let body = Font.system(size: 15, weight: .regular)
    static let caption = Font.system(size: 13, weight: .regular)
} 