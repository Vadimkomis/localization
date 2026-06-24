public struct LocaleCoverageResult: Equatable, Sendable {
    public let requiredLocales: [SupportedLocale]
    public let availableIdentifiers: Set<String>
    public let missingLocales: [SupportedLocale]

    public var isValid: Bool {
        missingLocales.isEmpty
    }
}

public struct CountryCoverageResult: Equatable, Sendable {
    public let requiredCountries: [SupportedCountry]
    public let availableCodes: Set<String>
    public let missingCountries: [SupportedCountry]

    public var isValid: Bool {
        missingCountries.isEmpty
    }
}

public enum LocalizationValidation {
    public static func coverage(
        availableIdentifiers: some Sequence<String>,
        requiredLocales: [SupportedLocale] = LocalizationPolicy.supportedLocales
    ) -> LocaleCoverageResult {
        let available = Set(availableIdentifiers)
        let missing = requiredLocales.filter { !available.contains($0.identifier) }

        return LocaleCoverageResult(
            requiredLocales: requiredLocales,
            availableIdentifiers: available,
            missingLocales: missing
        )
    }

    public static func missingLocales(
        in availableIdentifiers: some Sequence<String>,
        requiredLocales: [SupportedLocale] = LocalizationPolicy.supportedLocales
    ) -> [SupportedLocale] {
        coverage(
            availableIdentifiers: availableIdentifiers,
            requiredLocales: requiredLocales
        ).missingLocales
    }

    public static func countryCoverage(
        availableCodes: some Sequence<String>,
        requiredCountries: [SupportedCountry] = LocalizationPolicy.supportedCountries
    ) -> CountryCoverageResult {
        let available = Set(availableCodes)
        let missing = requiredCountries.filter { !available.contains($0.code) }

        return CountryCoverageResult(
            requiredCountries: requiredCountries,
            availableCodes: available,
            missingCountries: missing
        )
    }

    public static func missingCountries(
        in availableCodes: some Sequence<String>,
        requiredCountries: [SupportedCountry] = LocalizationPolicy.supportedCountries
    ) -> [SupportedCountry] {
        countryCoverage(
            availableCodes: availableCodes,
            requiredCountries: requiredCountries
        ).missingCountries
    }
}
