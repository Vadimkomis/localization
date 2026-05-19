public enum LocalizationPolicy {
    public static let sourceLocale: SupportedLocale = .enUS

    public static let targetLocales: [SupportedLocale] = [
        .es,
        .ptBR,
        .ja,
        .de,
        .fr,
        .he
    ]

    public static var supportedLocales: [SupportedLocale] {
        [sourceLocale] + targetLocales
    }

    public static var supportedLocaleIdentifiers: [String] {
        supportedLocales.map(\.identifier)
    }
}
