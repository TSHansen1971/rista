# Rísta — Editor-state restart gate

This document records `RISTA-EDITORSTATE-001G`, a restart gate before returning to the editor-state track after the previously aborted `EDITORSTATE-001F`.

The baseline commit before this task was:

`d26757cda8acba0e167da515b5a072cfa2d9ab64`

## Scope

This task is a baseline and restart-gate task only.

It does not connect `RistaMacEditorModel` to the visible editor UI. It does not resume or reuse any aborted `EDITORSTATE-001F` product patch.

## Verified baseline

The repository was clean at the start of the task.

Local `HEAD` and `origin/main` matched the expected baseline.

No `RistaTouch` target or source surface was present.

No manual Xcode project or workspace was introduced. A SwiftPM-generated local `.swiftpm/xcode/package.xcworkspace` may exist as package tooling, but it is not treated as a product target, app workspace, or platform-structure change.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A short manual visual pass confirmed that the Mac app still starts, that the editor still accepts keyboard input, that preview still updates, and that the Mac About/app-info identity from the preceding icon/About tasks remains in place.

## Editor-state position

`RistaEditingSession` remains present in `Sources/RistaCore`.

`RistaMacEditorModel` remains present as a Mac-side model surface, but it is still not connected to the visible editor UI path.

The next editor-state task should therefore be a new controlled product task, not a continuation of the aborted `EDITORSTATE-001F` patch.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`
- `Sources/RistaMac/Resources`

It does not introduce a new platform target, a new manual Xcode project, editor-state binding, Markdown preview rendering repair, table rendering repair, WYSIWYG behavior, export behavior, or App Store configuration.

## Result

`RISTA-EDITORSTATE-001G` confirms that the project can safely return to the editor-state track in a new, controlled product task.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
