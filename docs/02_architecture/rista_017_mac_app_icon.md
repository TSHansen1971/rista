# Rísta — Mac app icon

This document records `RISTA-APPICON-001A`, which adds the first Rísta app icon to the Mac app target.

The baseline commit before this task was:

`1f1343a5e9a72b4c9a06f59c100ac4f50136b9d2`

## Scope

This task is limited to the Mac app icon surface.

It adds icon resources to the Mac target, configures the target resource bundle, and installs the icon image at Mac app launch.

It does not introduce a new platform target, a new Xcode project, editor-state binding, Markdown preview rendering repair, table rendering repair, WYSIWYG behavior, export behavior, or App Store configuration.

## Added resources

The task adds a source icon, a generated asset catalog app icon set, and an `.icns` file under the Mac target resources.

The app icon image is loaded from the target resource bundle and assigned to the running Mac application.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A short manual visual pass confirmed that Rísta starts with the app icon surface in place, that the editor still accepts keyboard input, and that preview updates still work.

## Product-code boundary

This task does not change:

- `Sources/RistaCore`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`

`RistaTouch` has not been created.

Markdown rendering limitations, including table rendering details, remain out of scope for this task.

## Result

`RISTA-APPICON-001A` establishes the first Mac app icon for Rísta while preserving the editor input and preview baseline.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
