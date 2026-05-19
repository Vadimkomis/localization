import Foundation

public enum SupportedLocale: String, CaseIterable, Codable, Equatable, Hashable, Sendable {
    case enUS = "en-US"
    case es = "es"
    case ptBR = "pt-BR"
    case ja = "ja"
    case de = "de"
    case fr = "fr"
    case he = "he"

    public var identifier: String {
        rawValue
    }

    public var locale: Locale {
        Locale(identifier: rawValue)
    }
}
