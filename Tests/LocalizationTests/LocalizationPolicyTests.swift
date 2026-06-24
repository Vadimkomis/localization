import Testing
import Foundation
@testable import Localization

@Suite("Localization policy")
struct LocalizationPolicyTests {
    @Test("source locale is en-US")
    func sourceLocale() {
        #expect(LocalizationPolicy.sourceLocale == .enUS)
        #expect(LocalizationPolicy.sourceLocale.identifier == "en-US")
    }

    @Test("target locales match V1 language set")
    func targetLocales() {
        #expect(LocalizationPolicy.targetLocales == [.es, .ptBR, .ja, .de, .fr, .he])
    }

    @Test("supported locales include source first followed by targets")
    func supportedLocales() {
        #expect(LocalizationPolicy.supportedLocales == [.enUS, .es, .ptBR, .ja, .de, .fr, .he])
    }

    @Test("locale identifiers are stable")
    func localeIdentifiers() {
        #expect(LocalizationPolicy.supportedLocaleIdentifiers == [
            "en-US",
            "es",
            "pt-BR",
            "ja",
            "de",
            "fr",
            "he"
        ])
    }

    @Test("supported countries match European launch set")
    func supportedCountries() {
        #expect(LocalizationPolicy.supportedCountries == [
            .austria,
            .belgium,
            .denmark,
            .finland,
            .france,
            .germany,
            .italy,
            .netherlands,
            .norway,
            .spain,
            .sweden,
            .switzerland
        ])
    }

    @Test("supported country codes are stable")
    func supportedCountryCodes() {
        #expect(LocalizationPolicy.supportedCountryCodes == [
            "AT",
            "BE",
            "DK",
            "FI",
            "FR",
            "DE",
            "IT",
            "NL",
            "NO",
            "ES",
            "SE",
            "CH"
        ])
    }

    @Test("supported country names are stable")
    func supportedCountryNames() {
        #expect(LocalizationPolicy.supportedCountries.map(\.name) == [
            "Austria",
            "Belgium",
            "Denmark",
            "Finland",
            "France",
            "Germany",
            "Italy",
            "Netherlands",
            "Norway",
            "Spain",
            "Sweden",
            "Switzerland"
        ])
    }

    @Test("all supported locales expose stable identifiers")
    func supportedLocaleIdentifiers() {
        #expect(SupportedLocale.allCases.map(\.identifier) == [
            "en-US",
            "es",
            "pt-BR",
            "ja",
            "de",
            "fr",
            "he"
        ])
    }

    @Test("supported locale exposes Foundation locale")
    func foundationLocale() {
        #expect(SupportedLocale.ptBR.locale.identifier == "pt-BR")
        #expect(SupportedLocale.enUS.locale.identifier == "en-US")
    }

    @Test("all supported countries expose stable codes")
    func allSupportedCountryCodes() {
        #expect(SupportedCountry.allCases.map(\.code) == LocalizationPolicy.supportedCountryCodes)
    }

    @Test("supported locale codable round trip")
    func codableRoundTrip() throws {
        let encoded = try JSONEncoder().encode(SupportedLocale.he)
        let decoded = try JSONDecoder().decode(SupportedLocale.self, from: encoded)

        #expect(decoded == .he)
    }

    @Test("supported country codable round trip")
    func countryCodableRoundTrip() throws {
        let encoded = try JSONEncoder().encode(SupportedCountry.switzerland)
        let decoded = try JSONDecoder().decode(SupportedCountry.self, from: encoded)

        #expect(decoded == .switzerland)
    }
}
