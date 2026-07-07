# Features

Single source of truth for all features in the Localization package.

```gherkin
Feature: Shared locale policy

  Scenario: Canonical locale manifest
    Given the repository contains locales.json at the root
    When the locale list needs to change
    Then locales.json is updated first and both platform implementations follow
    And the status is "completed"

  Scenario: Swift supported locale list
    Given an iOS app depends on the Localization Swift package
    When it imports Localization
    Then SupportedLocale exposes the source locale, target locales, and stable identifiers
    And the status is "completed"

  Scenario: Kotlin supported locale list
    Given an Android app depends on com.github.Vadimkomis:localization via JitPack
    When it imports com.vadimkomis.localization
    Then SupportedLocale exposes the same source locale, target locales, and identifiers as the Swift package
    And the status is "completed"

  Scenario: Cross-platform locale list sync
    Given both Swift and Kotlin implementations of SupportedLocale
    When either platform's test suite runs
    Then manifest sync tests verify the implementation matches locales.json
    And the status is "completed"

Feature: Localization validation

  Scenario: Swift locale coverage validation
    Given an iOS app with localization resources
    When its tests call LocalizationValidation.coverage with the available identifiers
    Then the result reports whether all required locales are covered and which are missing
    And the status is "completed"

  Scenario: Kotlin locale coverage validation
    Given an Android app with localization resources
    When its tests call LocalizationValidation.coverage with the available identifiers
    Then the result reports whether all required locales are covered and which are missing
    And the status is "completed"

Feature: Continuous integration

  Scenario: Swift tests on CI
    Given a push or pull request to main
    When CI runs
    Then swift test runs with code coverage on macOS
    And the status is "completed"

  Scenario: Kotlin tests on CI
    Given a push or pull request to main
    When CI runs
    Then ./gradlew test runs on ubuntu with JDK 17
    And the status is "completed"
```
