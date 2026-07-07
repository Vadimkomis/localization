# Localization package

Shared locale policy for iOS and Android. One repo, two parallel implementations of the same API.

## Layout

- `locales.json` — canonical locale list (single source of truth). Change this first.
- `Sources/Localization/` + `Tests/LocalizationTests/` — Swift package (SPM, iOS 26+).
- `src/main/kotlin/` + `src/test/kotlin/` — Kotlin JVM library (Gradle, consumed by Android via JitPack).
- Manifest sync tests on both platforms fail if an implementation drifts from `locales.json`.

## Rules

- Any locale list change must touch `locales.json`, `SupportedLocale.swift`, and `SupportedLocale.kt` together.
- Keep the Swift and Kotlin public APIs mirrored (`SupportedLocale`, `LocalizationPolicy`, `LocalizationValidation`).

## Commands

```bash
swift test        # Swift tests
./gradlew test    # Kotlin tests (needs JAVA_HOME, e.g. /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home)
```

## Releasing

Versions are git tags without a `v` prefix (e.g. `1.2.0`). SPM resolves the tag directly; JitPack builds the Gradle project from the same tag. Bump `version` in `build.gradle.kts` and the release references in `README.md` to match the tag.
