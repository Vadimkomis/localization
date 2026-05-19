public struct LocaleCoverageResult: Equatable, Sendable {
    public let requiredLocales: [SupportedLocale]
    public let availableIdentifiers: Set<String>
    public let missingLocales: [SupportedLocale]

    public var isValid: Bool {
        missingLocales.isEmpty
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
}
