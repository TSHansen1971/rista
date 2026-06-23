# Rísta — Save/open lifecycle gate

This document records `RISTA-SAVE-001A`, a controlled gate before changing the Mac save/open lifecycle and before implementing a TextEdit-like document browser experience.

The baseline commit before this task was:

`5e6344571cb84f66f7c8a3ba666b817d640acff4`

## Scope

This task is a decision and verification gate only.

It does not patch product code.

The task establishes the desired direction for Rísta as an Apple-style document-based Markdown app.

## Product direction

Rísta should behave like a native Apple document app.

The desired future behavior is:

- startup should present a standard Apple document browser/open surface where appropriate
- the default document area should be Rísta's own document location
- when iCloud Drive is available and properly configured, the preferred document location should be a Rísta iCloud document area
- when iCloud Drive is unavailable, Rísta should fall back to a local user document location
- the document browser should expose a clear `New Document` action
- `New Document` should open a blank, unsaved `Untitled` Markdown document
- existing Markdown documents should be openable through the standard Apple document flow
- save, save-as, dirty/edited status, and open/reopen behavior should remain native and predictable

Rísta should not implement a custom file browser when a native Apple document workflow can provide the correct behavior.

## iCloud and branded folder boundary

The desired Rísta iCloud document area and a possible Finder folder identity using the Rísta icon are separate follow-up tasks.

They may require bundle identity, document type registration, iCloud document container configuration, signing/entitlement decisions, and Finder metadata behavior.

They must not be mixed into this save/open gate.

## Current baseline

The current Mac app is already document-based at the SwiftUI level through `DocumentGroup`.

The current development build may open directly into an untitled document rather than showing a TextEdit-style document browser.

That is acceptable for this gate. This task does not attempt to change startup behavior.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources`
- resources
- app targets
- document type registration
- entitlements
- iCloud container configuration
- Finder folder branding

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, WYSIWYG behavior, export behavior, App Store configuration, preview rendering repair, or table rendering repair.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the current app starts, that editor input and preview updates still work, and that the current document lifecycle baseline can be observed without product changes.

## Result

`RISTA-SAVE-001A` establishes the first controlled save/open lifecycle gate.

The recommended next task is a narrow product or decision task that targets the native Apple document browser/open/new-document behavior before any iCloud folder branding is attempted.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
