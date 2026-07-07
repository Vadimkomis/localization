import Foundation
import Testing
@testable import Localization

private struct LocaleManifest: Decodable {
    let sourceLocale: String
    let targetLocales: [String]
}

@Suite("Locale manifest sync")
struct LocaleManifestTests {
    private func loadManifest() throws -> LocaleManifest {
        let manifestURL = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("locales.json")
        let data = try Data(contentsOf: manifestURL)

        return try JSONDecoder().decode(LocaleManifest.self, from: data)
    }

    @Test("source locale matches locales.json manifest")
    func sourceLocaleMatchesManifest() throws {
        let manifest = try loadManifest()

        #expect(manifest.sourceLocale == SupportedLocale.sourceLocale.identifier)
    }

    @Test("target locales match locales.json manifest order")
    func targetLocalesMatchManifest() throws {
        let manifest = try loadManifest()

        #expect(manifest.targetLocales == SupportedLocale.targetLocales.map(\.identifier))
    }

    @Test("every manifest identifier resolves to a supported locale")
    func manifestIdentifiersResolve() throws {
        let manifest = try loadManifest()
        let identifiers = [manifest.sourceLocale] + manifest.targetLocales

        for identifier in identifiers {
            #expect(SupportedLocale(rawValue: identifier) != nil)
        }
    }
}
