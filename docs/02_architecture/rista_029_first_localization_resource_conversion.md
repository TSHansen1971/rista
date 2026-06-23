# Rísta — First localization resource conversion

This document records `RISTA-LOCALIZATION-001B`, the first narrow product step for host-language-driven app UI.

The baseline commit before this task was:

`9064c8ffd07074002c043ddd722c08f3e1a7df83`

## Scope

This task introduces the first controlled localization resources and converts a small set of visible Rísta-owned UI strings.

It does not attempt to localize the whole app.

It does not change document behavior, preview rendering, table rendering, WYSIWYG behavior, export behavior, bundle metadata activation, iCloud configuration, Finder folder branding, or file association behavior.

## SwiftPM default localization

SwiftPM requires `defaultLocalization` in `Package.swift` when localized resources such as `en.lproj` and `nb.lproj` are present.

This task therefore sets:

`defaultLocalization: "en"`

English remains the base/development language, consistent with the localization gate.

## Added localization resources

This task adds:

- `Sources/RistaMac/RistaL10n.swift`
- `Sources/RistaMac/Resources/en.lproj/Localizable.strings`
- `Sources/RistaMac/Resources/nb.lproj/Localizable.strings`

The localization helper reads from `Bundle.module`, because the current Mac target is built as a SwiftPM target with processed resources.

## Converted strings

This first conversion moves the following visible UI strings into localization resources:

- app header subtitle
- Markdown pane title and subtitle
- preview pane title and subtitle
- empty preview message
- About version format
- About copyright text
- Rísta-owned About menu item label

The product name `Rísta` and the rune symbol are intentionally kept as stable product identity.

The default document template remains out of scope for this task because it belongs to the shared document/core surface and should be handled in a separate localization step.

## Product-code boundary

This task changes only:

- `Package.swift`
- `Sources/RistaMac/RistaL10n.swift`
- `Sources/RistaMac/ContentView.swift`
- `Sources/RistaMac/EditorPreviewSplitView.swift`
- `Sources/RistaMac/MarkdownPreviewView.swift`
- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/Resources/en.lproj/Localizable.strings`
- `Sources/RistaMac/Resources/nb.lproj/Localizable.strings`

It does not change:

- `Sources/RistaCore`
- app icon resources
- `metadata`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, active bundle metadata, LaunchServices registration, entitlements, iCloud configuration, Finder folder branding, preview rendering repair, table rendering repair, WYSIWYG behavior, or export behavior.

## Verification

Both `Localizable.strings` files were validated with `plutil -lint`.

The app was built successfully after adding `defaultLocalization: "en"`.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the app starts, the first localized UI surface is visually safe on the current host, app icon/About identity remains correct, and editor/preview/edited-status behavior still works.

## Result

`RISTA-LOCALIZATION-001B` establishes the first resource-backed localization surface for Rísta-owned Mac UI text.

The recommended next task is a second narrow localization step for the shared default document template and remaining app-owned UI strings, or a controlled test of host-language switching once the active bundle metadata is in place.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
