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
}
