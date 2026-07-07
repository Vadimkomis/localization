package com.vadimkomis.localization

object LocalizationPolicy {
    val sourceLocale: SupportedLocale = SupportedLocale.sourceLocale

    val targetLocales: List<SupportedLocale> = SupportedLocale.targetLocales

    val supportedLocales: List<SupportedLocale> = SupportedLocale.supportedLocales

    val supportedLocaleIdentifiers: List<String> = SupportedLocale.supportedLocaleIdentifiers
}
