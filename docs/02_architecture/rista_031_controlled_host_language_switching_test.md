# Rísta — Controlled host-language switching test

This document records `RISTA-LOCALIZATION-001D`, a controlled localization verification task.

The baseline commit before this task was:

`15acbe7fd895274f390aed883a4a59a1a11b4112`

## Scope

This task verifies the existing Rísta-owned localization behavior without changing product code.

It does not patch product source, resources, package metadata, app icon resources, bundle metadata, entitlements, iCloud configuration, Finder folder branding, file association behavior, document browser behavior, preview rendering, table rendering, WYSIWYG behavior, or export behavior.

## Method

The app was built and tested from the SwiftPM development environment.

Rísta was then launched twice with process-specific language arguments:

- Norwegian: `-AppleLanguages (nb)` and `-AppleLocale nb_NO`
- English: `-AppleLanguages (en)` and `-AppleLocale en_US`

The global macOS language settings were not changed.

The test only evaluates Rísta-owned UI strings. System/AppKit menu strings that are outside Rísta's ownership are not pass/fail criteria in this task.

## Expected Norwegian surface

The Norwegian run should show Rísta-owned strings such as:

- `Merkespråk, ren tekst, ingen friksjon.`
- `Forhåndsvisning`
- `Formatert dokument`
- `# Nytt dokument`
- `Skriv markdown her.`
- `Om Rísta`

## Expected English surface

The English run should show Rísta-owned strings such as:

- `Markup, plain text, no friction.`
- `Preview`
- `Formatted document`
- `# New Document`
- `Write Markdown here.`
- `About Rísta`

## Verification

The localization resources were verified present and valid.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

The Norwegian visual pass was confirmed.

The English visual pass was confirmed.

Product files were verified unchanged after build, tests, and visual language switching checks.

## Result

`RISTA-LOCALIZATION-001D` verifies that the current SwiftPM development build can switch Rísta-owned UI text between Norwegian and English through controlled process-specific language arguments.

The recommended next task is to continue with active bundle metadata, where full app-bundle language behavior can be tested more realistically.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
