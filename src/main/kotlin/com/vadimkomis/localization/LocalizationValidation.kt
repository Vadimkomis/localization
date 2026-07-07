package com.vadimkomis.localization

data class LocaleCoverageResult(
    val requiredLocales: List<SupportedLocale>,
    val availableIdentifiers: Set<String>,
    val missingLocales: List<SupportedLocale>
) {
    val isValid: Boolean
        get() = missingLocales.isEmpty()
}

object LocalizationValidation {
    fun coverage(
        availableIdentifiers: Iterable<String>,
        requiredLocales: List<SupportedLocale> = LocalizationPolicy.supportedLocales
    ): LocaleCoverageResult {
        val available = availableIdentifiers.toSet()
        val missing = requiredLocales.filter { it.identifier !in available }

        return LocaleCoverageResult(
            requiredLocales = requiredLocales,
            availableIdentifiers = available,
            missingLocales = missing
        )
    }

    fun missingLocales(
        availableIdentifiers: Iterable<String>,
        requiredLocales: List<SupportedLocale> = LocalizationPolicy.supportedLocales
    ): List<SupportedLocale> = coverage(
        availableIdentifiers = availableIdentifiers,
        requiredLocales = requiredLocales
    ).missingLocales
}
