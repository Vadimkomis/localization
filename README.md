# Localization

Shared iOS localization policy for app projects.

## V1 locales

- Source locale: `en-US`
- Target locales: `es`, `pt-BR`, `ja`, `de`, `fr`, `he`

Apps own their translated `.xcstrings` files. This package owns the shared locale list and validation helpers that app tests can use to keep catalogs aligned.
