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

    @Test("target locales match expanded country language set")
    func targetLocales() {
        #expect(LocalizationPolicy.targetLocales == [
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
        ])
    }

    @Test("supported locales include source first followed by targets")
    func supportedLocales() {
        #expect(LocalizationPolicy.supportedLocales == [
            .enUS,
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
        ])
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
            "he",
            "da",
            "fi",
            "it",
            "nl",
            "nb",
            "sv"
        ])
    }

    @Test("supported locale identifiers are unique")
    func supportedLocaleIdentifiersAreUnique() {
        let identifiers = LocalizationPolicy.supportedLocaleIdentifiers

        #expect(Set(identifiers).count == identifiers.count)
    }

    @Test("localization policy delegates language list to SupportedLocale")
    func policyDelegatesLanguageList() {
        #expect(LocalizationPolicy.sourceLocale == SupportedLocale.sourceLocale)
        #expect(LocalizationPolicy.targetLocales == SupportedLocale.targetLocales)
        #expect(LocalizationPolicy.supportedLocales == SupportedLocale.supportedLocales)
        #expect(LocalizationPolicy.supportedLocaleIdentifiers == SupportedLocale.supportedLocaleIdentifiers)
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
            "he",
            "da",
            "fi",
            "it",
            "nl",
            "nb",
            "sv"
        ])
    }

    @Test("supported locale exposes Foundation locale")
    func foundationLocale() {
        #expect(SupportedLocale.ptBR.locale.identifier == "pt-BR")
        #expect(SupportedLocale.enUS.locale.identifier == "en-US")
    }

    @Test("supported locale codable round trip")
    func codableRoundTrip() throws {
        let encoded = try JSONEncoder().encode(SupportedLocale.he)
        let decoded = try JSONDecoder().decode(SupportedLocale.self, from: encoded)

        #expect(decoded == .he)
    }
}
