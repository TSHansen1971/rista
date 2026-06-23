# Rísta — Baseline after Mac editor input focus repair

This document records the baseline after `RISTA-EDITOR-INPUT-001D-REPAIR002`, which repaired Mac application activation and editor focus ownership for the visible Markdown editor.

The verified baseline commit before this document was:

`2b0fd1359906b73a594aecb63f9d548b040b3c71`

## Scope

`RISTA-EDITOR-INPUT-001E` is a baseline and verification task only.

It does not introduce product code changes, editor-state binding, new platform targets, preview rendering repairs, WYSIWYG behavior, export behavior, or App Store configuration.

## Verified behavior

The Mac app baseline was verified after the application activation and editor focus repair.

The editor accepts keyboard input. Space, Enter, standard selection, clipboard operations, cutting, deletion, and backspace behavior were verified through a short manual baseline pass.

The live preview still updates from editor input.

The automated test suite was also run and confirmed as 13 XCTest tests with 0 failures.

## Product-code boundary

This baseline does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`

`RistaMacEditorModel` remains outside the visible editor UI path.

`RistaTouch` has not been created.

## Known out-of-scope rendering limitations

Markdown rendering is not complete yet.

Known limitations, including table rendering and other preview details, are explicitly out of scope for this editor-input baseline. They should be handled later in a separate preview/rendering task.

## Result

`RISTA-EDITOR-INPUT-001E` confirms that the repository is stable after the Mac activation and editor focus repair, and that the project can safely return to the editor-state track in a later controlled task.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
