package com.vadimkomis.localization

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

class LocalizationPolicyTests {
    @Test
    fun `source locale is en-US`() {
        assertEquals(SupportedLocale.EN_US, LocalizationPolicy.sourceLocale)
        assertEquals("en-US", LocalizationPolicy.sourceLocale.identifier)
    }

    @Test
    fun `target locales match expanded country language set`() {
        assertEquals(
            listOf(
                SupportedLocale.ES,
                SupportedLocale.PT_BR,
                SupportedLocale.JA,
                SupportedLocale.DE,
                SupportedLocale.FR,
                SupportedLocale.HE,
                SupportedLocale.DA,
                SupportedLocale.FI,
                SupportedLocale.IT,
                SupportedLocale.NL,
                SupportedLocale.NB,
                SupportedLocale.SV
            ),
            LocalizationPolicy.targetLocales
        )
    }

    @Test
    fun `supported locales include source first followed by targets`() {
        assertEquals(
            listOf(LocalizationPolicy.sourceLocale) + LocalizationPolicy.targetLocales,
            LocalizationPolicy.supportedLocales
        )
    }

    @Test
    fun `locale identifiers are stable`() {
        assertEquals(
            listOf(
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
            ),
            LocalizationPolicy.supportedLocaleIdentifiers
        )
    }

    @Test
    fun `supported locale identifiers are unique`() {
        val identifiers = LocalizationPolicy.supportedLocaleIdentifiers

        assertEquals(identifiers.size, identifiers.toSet().size)
    }

    @Test
    fun `localization policy delegates language list to SupportedLocale`() {
        assertEquals(SupportedLocale.sourceLocale, LocalizationPolicy.sourceLocale)
        assertEquals(SupportedLocale.targetLocales, LocalizationPolicy.targetLocales)
        assertEquals(SupportedLocale.supportedLocales, LocalizationPolicy.supportedLocales)
        assertEquals(SupportedLocale.supportedLocaleIdentifiers, LocalizationPolicy.supportedLocaleIdentifiers)
    }

    @Test
    fun `supported locale exposes java locale`() {
        assertEquals("pt-BR", SupportedLocale.PT_BR.locale.toLanguageTag())
        assertEquals("en-US", SupportedLocale.EN_US.locale.toLanguageTag())
    }

    @Test
    fun `fromIdentifier resolves known identifiers`() {
        assertEquals(SupportedLocale.HE, SupportedLocale.fromIdentifier("he"))
        assertEquals(SupportedLocale.EN_US, SupportedLocale.fromIdentifier("en-US"))
    }

    @Test
    fun `fromIdentifier returns null for unknown identifiers`() {
        assertNull(SupportedLocale.fromIdentifier("zh"))
        assertNull(SupportedLocale.fromIdentifier(""))
    }
}
