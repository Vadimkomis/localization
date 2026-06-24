import Testing
@testable import Localization

@Suite("Localization validation")
struct LocalizationValidationTests {
    @Test("coverage is valid when all required identifiers are available")
    func completeCoverage() {
        let result = LocalizationValidation.coverage(
            availableIdentifiers: LocalizationPolicy.supportedLocaleIdentifiers
        )

        #expect(result.isValid)
        #expect(result.missingLocales.isEmpty)
    }

    @Test("coverage reports missing required locales")
    func missingCoverage() {
        let result = LocalizationValidation.coverage(
            availableIdentifiers: ["en-US", "es", "fr"]
        )

        #expect(!result.isValid)
        #expect(result.missingLocales == [.ptBR, .ja, .de, .he])
    }

    @Test("missingLocales returns missing locales directly")
    func missingLocalesShortcut() {
        let missing = LocalizationValidation.missingLocales(
            in: ["en-US", "es", "pt-BR", "ja", "de", "fr"]
        )

        #expect(missing == [.he])
    }

    @Test("country coverage is valid when all required codes are available")
    func completeCountryCoverage() {
        let result = LocalizationValidation.countryCoverage(
            availableCodes: LocalizationPolicy.supportedCountryCodes
        )

        #expect(result.isValid)
        #expect(result.missingCountries.isEmpty)
    }

    @Test("country coverage reports missing required countries")
    func missingCountryCoverage() {
        let result = LocalizationValidation.countryCoverage(
            availableCodes: ["AT", "BE", "FR", "DE", "CH"]
        )

        #expect(!result.isValid)
        #expect(result.missingCountries == [
            .denmark,
            .finland,
            .italy,
            .netherlands,
            .norway,
            .spain,
            .sweden
        ])
    }

    @Test("missingCountries returns missing countries directly")
    func missingCountriesShortcut() {
        let missing = LocalizationValidation.missingCountries(
            in: ["AT", "BE", "DK", "FI", "FR", "DE", "IT", "NL", "NO", "ES", "SE"]
        )

        #expect(missing == [.switzerland])
    }
}
