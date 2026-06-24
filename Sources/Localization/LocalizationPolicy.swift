public enum LocalizationPolicy {
    public static let sourceLocale: SupportedLocale = SupportedLocale.sourceLocale

    public static let targetLocales: [SupportedLocale] = SupportedLocale.targetLocales

    public static var supportedLocales: [SupportedLocale] {
        SupportedLocale.supportedLocales
    }

    public static var supportedLocaleIdentifiers: [String] {
        SupportedLocale.supportedLocaleIdentifiers
    }

}
