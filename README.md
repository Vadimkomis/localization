![Localization banner](assets/banner.png)

# Localization

[![CI](https://github.com/Vadimkomis/localization/actions/workflows/ci.yml/badge.svg)](https://github.com/Vadimkomis/localization/actions/workflows/ci.yml)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](Package.swift)
[![Locales](https://img.shields.io/badge/locales-V1-blue.svg)](#supported-policy)
[![Countries](https://img.shields.io/badge/countries-12-blue.svg)](#supported-policy)
[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](Package.swift)
[![iOS](https://img.shields.io/badge/iOS-26%2B-lightgrey.svg)](Package.swift)

Shared iOS 26 localization policy for app projects.

## Why this exists

Use this package as the single source of truth for the languages and countries supported across iOS apps. It keeps the locale list, country list, fallback assumptions, and validation helpers in one reusable Swift package instead of duplicating that policy in every app repo.

This package does not own app copy. Each app should still keep its translated strings in native Apple localization resources such as `.xcstrings`, `.strings`, or `.stringsdict`.

## Supported policy

- Source locale: `en-US`
- Target locales: `es`, `pt-BR`, `ja`, `de`, `fr`, `he`
- Supported countries: Austria (`AT`), Belgium (`BE`), Denmark (`DK`), Finland (`FI`), France (`FR`), Germany (`DE`), Italy (`IT`), the Netherlands (`NL`), Norway (`NO`), Spain (`ES`), Sweden (`SE`), and Switzerland (`CH`)

## Installation

Add the package in Xcode:

```text
File -> Add Package Dependencies...
```

Use this repository URL:

```text
git@github.com:Vadimkomis/localization.git
```

Then add the `Localization` product to the app target or test target that needs the shared policy.

## Usage

Import the package wherever app code or tests need the supported locale policy:

```swift
import Localization
```

Read the source locale, target locales, supported countries, or stable identifiers. `SupportedLocale` is the centralized language list; `LocalizationPolicy` exposes the same values for app policy code.

```swift
let sourceLocale = SupportedLocale.sourceLocale
let targetLocales = SupportedLocale.targetLocales
let supportedIdentifiers = SupportedLocale.supportedLocaleIdentifiers
let supportedCountries = LocalizationPolicy.supportedCountries
let supportedCountryCodes = LocalizationPolicy.supportedCountryCodes
```

Supported identifiers are stable and ordered with the source locale first:

```swift
[
    "en-US",
    "es",
    "pt-BR",
    "ja",
    "de",
    "fr",
    "he"
]
```

Supported country codes are stable and ordered by the launch country list:

```swift
[
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
]
```

## Validating an app

Apps can use `LocalizationValidation` from their own tests to make sure their localization resources include every required locale.

```swift
import Testing
import Localization

@Test("app includes all required locales")
func appIncludesAllRequiredLocales() {
    let appLocaleIdentifiers = [
        "en-US",
        "es",
        "pt-BR",
        "ja",
        "de",
        "fr",
        "he"
    ]

    let result = LocalizationValidation.coverage(
        availableIdentifiers: appLocaleIdentifiers
    )

    #expect(result.isValid)
    #expect(result.missingLocales.isEmpty)
}
```

When Hebrew (`he`) is enabled, apps should also test right-to-left layout behavior for critical screens and controls.

Apps can also validate country availability from their own tests:

```swift
import Testing
import Localization

@Test("app is available in all supported countries")
func appIncludesAllRequiredCountries() {
    let appCountryCodes = [
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
    ]

    let result = LocalizationValidation.countryCoverage(
        availableCodes: appCountryCodes
    )

    #expect(result.isValid)
    #expect(result.missingCountries.isEmpty)
}
```

## Ownership boundary

- `Localization` owns shared locale policy, country policy, and validation helpers.
- Each app owns its translated copy and Apple localization resources.
- Codex localization work should use this package instead of inventing a separate language list.
