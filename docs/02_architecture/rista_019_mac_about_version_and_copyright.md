# Rísta — Mac About version and copyright

This document records `RISTA-APPINFO-001C`, which adds explicit version, build, and Apple-style copyright text to the Mac About surface.

The baseline commit before this task was:

`5f99458eda11168d86f772387d60feddafd461b2`

## Scope

This task is limited to the Mac About/app-info metadata surface.

The About surface follows the standard Apple-style pattern: icon, app name, version/build line, and copyright lines.

It must show the Rísta icon, a version and build line, and the following copyright lines directly below the version/build line:

`Copyright © 2026 Tor-Ståle Hansen.`
`Alle rettigheter forbeholdes.`

No additional tagline is added to the About panel.

## Implementation

The Mac About panel reads version and build metadata from the app bundle when available.

If bundle metadata is not available in the current SwiftPM launch mode, the About panel falls back to:

- version: `0.1`
- build: `1`

The displayed version/build line is formatted as:

`Versjon 0.1 (1)`

The copyright text is supplied through the About panel credits text because the AppKit About panel option API used in this target does not expose a dedicated copyright option key.

## Product-code boundary

This task changes only:

- `Sources/RistaMac/RistaMacApp.swift`

It does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`
- `Sources/RistaMac/Resources`

It does not introduce a new platform target, a new Xcode project, editor-state binding, Markdown preview rendering repair, table rendering repair, WYSIWYG behavior, export behavior, or App Store configuration.

`RistaTouch` has not been created.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A short manual visual pass confirmed that the About surface shows the Rísta icon, version/build text, and the required Apple-style copyright lines. The editor still accepts keyboard input, and preview updates still work.

Markdown rendering limitations, including table rendering details, remain out of scope for this task.

## Result

`RISTA-APPINFO-001C` establishes the first explicit visible About-version and copyright identity for Rísta on Mac.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
