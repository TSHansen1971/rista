# Rísta — Host language localization gate

This document records `RISTA-LOCALIZATION-001A`, a gate for making Rísta's user interface follow the host macOS language settings.

The baseline commit before this task was:

`16c1693d5f6e6f4d064075bbce08c0548ab5e7a3`

## Scope

This task is a decision and verification gate only.

It does not patch product code.

It does not create localization resources.

It documents why the current app-specific UI text does not yet follow macOS global language settings and establishes the intended direction.

## Current observation

The current app shows a mixture of host/system-provided menu text and app-specific UI text.

System-level menus may be provided by macOS/AppKit and can follow host runtime behavior.

Rísta-specific UI labels and phrases are currently hardcoded in Swift source. Hardcoded app strings are not automatically translated by macOS. They must be moved into localization resources before the app can follow the host language preferences for app-specific UI.

## Desired behavior

Rísta should follow the native Apple localization model.

The desired future behavior is:

- app-specific UI strings are not hardcoded directly in Swift views
- strings are defined through reviewed localization resources
- English is the base/development language
- Norwegian Bokmål is the first additional localization
- macOS selects the best available language from the user's language preferences
- unsupported languages fall back to English
- app name and product identity remain stable
- localization is introduced without changing editor behavior, document behavior, iCloud behavior, or Finder metadata behavior

## Localization boundary

Localization must be implemented as its own controlled track.

It must not be mixed with:

- active bundle metadata
- iCloud document containers
- Finder folder branding
- file association behavior
- document browser behavior
- preview rendering
- Markdown table rendering
- WYSIWYG behavior
- export behavior

## Candidate strings

The first localization implementation should inspect and convert visible app-specific UI strings such as:

- header title and subtitle
- editor pane labels
- preview pane labels
- default untitled document content
- About panel text where appropriate
- app-specific menu/help text where owned by Rísta

The implementation should avoid localizing internal identifiers, file names, bundle identifiers, code symbols, and stable product metadata unless explicitly required by Apple platform conventions.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources`
- `Sources/RistaMac/Resources`
- `metadata`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, active bundle metadata, LaunchServices registration, entitlements, iCloud configuration, Finder folder branding, preview rendering repair, table rendering repair, WYSIWYG behavior, or export behavior.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed the current language baseline, app icon/About identity, editor input, preview updates, and edited/dirty status.

## Result

`RISTA-LOCALIZATION-001A` establishes the localization direction for host-language-driven app UI.

The recommended next task is a narrow localization implementation preparation task, likely introducing reviewed localization resources and converting a very small first set of visible UI strings.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
