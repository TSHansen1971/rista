# Rísta — Mac app info icon repair

This document records `RISTA-APPICON-001B`, which repairs the Mac app information surface so that it uses the Rísta icon instead of the generic folder icon.

The baseline commit before this task was:

`6ded8d776c18010e11a2cad7e4fd88c44a602cd3`

## Scope

This task is limited to the Mac app information and About panel icon surface.

`RISTA-APPICON-001A` added the Rísta icon resources and installed the runtime application icon. A follow-up visual check showed that at least one app information surface could still show a generic folder icon.

This task makes the Mac About/app-info command explicitly present the Rísta icon from the existing target resource bundle.

## Implementation boundary

This task changes only the Mac app entry surface needed for the app-info icon repair.

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

A short manual visual pass confirmed that the Mac app-info/About surface shows the Rísta icon rather than the generic folder icon, that the Dock icon still shows the Rísta icon, that the editor still accepts keyboard input, and that preview updates still work.

Markdown rendering limitations, including table rendering details, remain out of scope for this task.

## Result

`RISTA-APPICON-001B` closes the visible generic-folder app-info issue while preserving the editor input and preview baseline.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
