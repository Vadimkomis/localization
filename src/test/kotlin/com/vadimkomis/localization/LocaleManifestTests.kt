package com.vadimkomis.localization

import com.google.gson.Gson
import java.io.File
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotNull

private data class LocaleManifest(
    val sourceLocale: String,
    val targetLocales: List<String>
)

class LocaleManifestTests {
    private fun loadManifest(): LocaleManifest {
        val path = System.getProperty("locales.manifest") ?: "locales.json"

        return Gson().fromJson(File(path).readText(), LocaleManifest::class.java)
    }

    @Test
    fun `source locale matches manifest`() {
        val manifest = loadManifest()

        assertEquals(manifest.sourceLocale, SupportedLocale.sourceLocale.identifier)
    }

    @Test
    fun `target locales match manifest order`() {
        val manifest = loadManifest()

        assertEquals(manifest.targetLocales, SupportedLocale.targetLocales.map { it.identifier })
    }

    @Test
    fun `every manifest identifier resolves to a supported locale`() {
        val manifest = loadManifest()
        val identifiers = listOf(manifest.sourceLocale) + manifest.targetLocales

        for (identifier in identifiers) {
            assertNotNull(SupportedLocale.fromIdentifier(identifier), "Unknown identifier: $identifier")
        }
    }
}
