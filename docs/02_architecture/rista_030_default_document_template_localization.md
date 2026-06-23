# Rísta — Default document template localization

This document records `RISTA-LOCALIZATION-001C`, a narrow localization step for the Mac app's default new document template.

The baseline commit before this task was:

`56b68f2af732e6335390692dd49529a88ff51c58`

## Scope

This task localizes the default new document template used by the Mac app's `DocumentGroup`.

It does not change the shared `RistaCore` fallback document initializer.

This is intentional. The Mac app can provide a localized new document template while the shared core document type keeps a deterministic fallback for non-UI use and future platform integration.

## Repair note

The first 001C attempt built successfully, but the manual visual check showed English UI and English default document text on a Norwegian host.

That did not satisfy the 001C test criteria.

The repair keeps the localized default document template and adds a narrow host-preferred-language bridge in `RistaL10n` for SwiftPM development runs.

The bridge checks `Locale.preferredLanguages`, selects `nb.lproj` for Norwegian (`nb` or `no`), selects `en.lproj` for English, and falls back to English and then `Bundle.module`.

This is a SwiftPM development bridge until active bundle metadata and full app localization behavior are introduced.

## Implementation

This task adds the localization key:

- `document.defaultText`

to:

- `Sources/RistaMac/Resources/en.lproj/Localizable.strings`
- `Sources/RistaMac/Resources/nb.lproj/Localizable.strings`

The Mac app's `DocumentGroup` now creates new documents with:

`RistaDocument(text: RistaL10n.string("document.defaultText"))`

The Norwegian Bokmål value remains:

`# Nytt dokument`

`Skriv markdown her.`

The English value is:

`# New Document`

`Write Markdown here.`

## Product-code boundary

This task changes only:

- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/RistaL10n.swift`
- `Sources/RistaMac/Resources/en.lproj/Localizable.strings`
- `Sources/RistaMac/Resources/nb.lproj/Localizable.strings`

It does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/ContentView.swift`
- `Sources/RistaMac/EditorPreviewSplitView.swift`
- `Sources/RistaMac/MarkdownPreviewView.swift`
- app icon resources
- `metadata`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, active bundle metadata, LaunchServices registration, entitlements, iCloud configuration, Finder folder branding, preview rendering repair, table rendering repair, WYSIWYG behavior, or export behavior.

## Verification

Both `Localizable.strings` files were validated with `plutil -lint`.

The shared `RistaCore` fallback document initializer was verified unchanged.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the app starts, the new document template is visually correct on the current Norwegian host, the localized UI from the previous localization step remains correct, and app icon/About/editor/preview/edited-status behavior still works.

## Result

`RISTA-LOCALIZATION-001C` localizes the Mac app's default new document template while preserving the shared core fallback.

The recommended next task is a controlled host-language switching test or a narrow continuation that localizes remaining app-owned strings.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
