package com.vadimkomis.localization

import java.util.Locale

enum class SupportedLocale(val identifier: String) {
    EN_US("en-US"),
    ES("es"),
    PT_BR("pt-BR"),
    JA("ja"),
    DE("de"),
    FR("fr"),
    HE("he"),
    DA("da"),
    FI("fi"),
    IT("it"),
    NL("nl"),
    NB("nb"),
    SV("sv");

    val locale: Locale
        get() = Locale.forLanguageTag(identifier)

    companion object {
        val sourceLocale: SupportedLocale = EN_US

        val targetLocales: List<SupportedLocale> = listOf(
            ES,
            PT_BR,
            JA,
            DE,
            FR,
            HE,
            DA,
            FI,
            IT,
            NL,
            NB,
            SV
        )

        val supportedLocales: List<SupportedLocale> = listOf(sourceLocale) + targetLocales

        val supportedLocaleIdentifiers: List<String> = supportedLocales.map { it.identifier }

        fun fromIdentifier(identifier: String): SupportedLocale? =
            entries.firstOrNull { it.identifier == identifier }
    }
}
