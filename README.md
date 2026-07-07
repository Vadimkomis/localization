![Localization banner](assets/banner.png)

# Localization

[![CI](https://github.com/Vadimkomis/localization/actions/workflows/ci.yml/badge.svg)](https://github.com/Vadimkomis/localization/actions/workflows/ci.yml)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](Package.swift)
[![JitPack](https://img.shields.io/badge/JitPack-compatible-brightgreen.svg)](https://jitpack.io/#Vadimkomis/localization)
[![Locales](https://img.shields.io/badge/locales-13-blue.svg)](#supported-locales)
[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](Package.swift)
[![Kotlin](https://img.shields.io/badge/Kotlin-2.2-purple.svg)](build.gradle.kts)
[![iOS](https://img.shields.io/badge/iOS-26%2B-lightgrey.svg)](Package.swift)
[![Android](https://img.shields.io/badge/Android-compatible-green.svg)](build.gradle.kts)

Shared localization policy for iOS and Android app projects.

Current release: `1.2.0`

## Why this exists

Use this package as the single source of truth for the languages supported across iOS and Android apps. It keeps the locale list, fallback assumptions, and validation helpers in one reusable package instead of duplicating that policy in every app repo.

The canonical locale list lives in [`locales.json`](locales.json). The Swift and Kotlin implementations both expose that same list, and each platform's test suite verifies its implementation against the manifest, so the two platforms can never drift apart.

This package does not own app copy. Each app should still keep its translated strings in its native localization resources — `.xcstrings`, `.strings`, or `.stringsdict` on iOS, and `strings.xml` resource qualifiers on Android.

## Supported locales

- Source locale: `en-US`
- Target locales: `es`, `pt-BR`, `ja`, `de`, `fr`, `he`, `da`, `fi`, `it`, `nl`, `nb`, `sv`

## Installation

### iOS (Swift Package Manager)

Add the package in Xcode:

```text
File -> Add Package Dependencies...
```

Use this repository URL:

```text
git@github.com:Vadimkomis/localization.git
```

Then add the `Localization` product to the app target or test target that needs the shared policy.

### Android (Gradle via JitPack)

Add the JitPack repository to `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven("https://jitpack.io")
    }
}
```

Then add the dependency to the module that needs the shared policy:

```kotlin
dependencies {
    implementation("com.github.Vadimkomis:localization:1.2.0")
}
```

## Usage

Both platforms expose the same API: `SupportedLocale` is the centralized language list; `LocalizationPolicy` exposes the same values for app policy code.

### Swift

```swift
import Localization

let sourceLocale = SupportedLocale.sourceLocale
let targetLocales = SupportedLocale.targetLocales
let supportedIdentifiers = SupportedLocale.supportedLocaleIdentifiers
```

### Kotlin

```kotlin
import com.vadimkomis.localization.SupportedLocale

val sourceLocale = SupportedLocale.sourceLocale
val targetLocales = SupportedLocale.targetLocales
val supportedIdentifiers = SupportedLocale.supportedLocaleIdentifiers
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
    "he",
    "da",
    "fi",
    "it",
    "nl",
    "nb",
    "sv"
]
```

## Validating an app

Apps can use `LocalizationValidation` from their own tests to make sure their localization resources include every required locale.

### Swift

```swift
import Testing
import Localization

@Test("app includes all required locales")
func appIncludesAllRequiredLocales() {
    let result = LocalizationValidation.coverage(
        availableIdentifiers: Bundle.main.localizations
    )

    #expect(result.isValid)
    #expect(result.missingLocales.isEmpty)
}
```

### Kotlin

```kotlin
import com.vadimkomis.localization.LocalizationValidation
import kotlin.test.Test
import kotlin.test.assertTrue

class LocalizationCoverageTests {
    @Test
    fun `app includes all required locales`() {
        val result = LocalizationValidation.coverage(
            availableIdentifiers = appLocaleIdentifiers
        )

        assertTrue(result.isValid)
        assertTrue(result.missingLocales.isEmpty())
    }
}
```

When Hebrew (`he`) is enabled, apps should also test right-to-left layout behavior for critical screens and controls.

## Changing the locale list

1. Update [`locales.json`](locales.json).
2. Update `SupportedLocale` in [`Sources/Localization/SupportedLocale.swift`](Sources/Localization/SupportedLocale.swift) and [`src/main/kotlin/com/vadimkomis/localization/SupportedLocale.kt`](src/main/kotlin/com/vadimkomis/localization/SupportedLocale.kt).
3. Run both test suites — the manifest sync tests fail if either platform drifts from `locales.json`:

```bash
swift test
./gradlew test
```

## Ownership boundary

- `Localization` owns shared locale policy and validation helpers for both platforms.
- Each app owns its translated copy and platform localization resources.
- Codex localization work should use this package instead of inventing a separate language list.
