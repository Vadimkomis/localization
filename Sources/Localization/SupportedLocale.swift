import Foundation

public enum SupportedLocale: String, CaseIterable, Codable, Equatable, Hashable, Sendable {
    case enUS = "en-US"
    case es = "es"
    case ptBR = "pt-BR"
    case ja = "ja"
    case de = "de"
    case fr = "fr"
    case he = "he"
    case da = "da"
    case fi = "fi"
    case it = "it"
    case nl = "nl"
    case nb = "nb"
    case sv = "sv"

    public static let sourceLocale: SupportedLocale = .enUS

    public static let targetLocales: [SupportedLocale] = [
        .es,
        .ptBR,
        .ja,
        .de,
        .fr,
        .he,
        .da,
        .fi,
        .it,
        .nl,
        .nb,
        .sv
    ]

    public static var supportedLocales: [SupportedLocale] {
        [sourceLocale] + targetLocales
    }

    public static var supportedLocaleIdentifiers: [String] {
        supportedLocales.map(\.identifier)
    }

    public var identifier: String {
        rawValue
    }

    public var locale: Locale {
        Locale(identifier: rawValue)
    }
}
