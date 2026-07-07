package com.vadimkomis.localization

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class LocalizationValidationTests {
    @Test
    fun `coverage is valid when all required identifiers are available`() {
        val result = LocalizationValidation.coverage(
            availableIdentifiers = LocalizationPolicy.supportedLocaleIdentifiers
        )

        assertTrue(result.isValid)
        assertTrue(result.missingLocales.isEmpty())
    }

    @Test
    fun `coverage reports missing required locales`() {
        val result = LocalizationValidation.coverage(
            availableIdentifiers = listOf("en-US", "es", "fr")
        )

        assertFalse(result.isValid)
        assertEquals(
            listOf(
                SupportedLocale.PT_BR,
                SupportedLocale.JA,
                SupportedLocale.DE,
                SupportedLocale.HE,
                SupportedLocale.DA,
                SupportedLocale.FI,
                SupportedLocale.IT,
                SupportedLocale.NL,
                SupportedLocale.NB,
                SupportedLocale.SV
            ),
            result.missingLocales
        )
    }

    @Test
    fun `missingLocales returns missing locales directly`() {
        val missing = LocalizationValidation.missingLocales(
            availableIdentifiers = listOf(
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
                "nb"
            )
        )

        assertEquals(listOf(SupportedLocale.SV), missing)
    }

    @Test
    fun `coverage with empty identifiers reports every locale missing`() {
        val result = LocalizationValidation.coverage(availableIdentifiers = emptyList())

        assertFalse(result.isValid)
        assertEquals(LocalizationPolicy.supportedLocales, result.missingLocales)
    }
}
