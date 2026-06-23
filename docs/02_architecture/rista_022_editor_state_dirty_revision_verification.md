# Rísta — Editor-state dirty/revision verification

This document records `RISTA-EDITORSTATE-001I`, a verification gate after the first visible Mac editor-state binding.

The baseline commit before this task was:

`05b05bf831f04fdb8a8d9c04de79fc0958159809`

## Scope

This task is verification-only.

It does not patch product code.

The task verifies that the visible editor-state binding introduced in `RISTA-EDITORSTATE-001H` still preserves the expected visible editor behavior: keyboard input, preview updates, and macOS edited/dirty document status.

## Verified structure

The Mac content view owns a `RistaMacEditorModel` as SwiftUI state.

The content view exposes an editor text binding that writes through `RistaMacEditorModel.replaceText(with:)` and continues to update `document.text`.

`EditorPreviewSplitView` still receives the same editor binding and passes it to both the Markdown text view and the Markdown preview view.

The Mac editor model remains a non-ObservableObject model surface and is still not changed by this verification task.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/ContentView.swift`
- `Sources/RistaMac/EditorPreviewSplitView.swift`
- `Sources/RistaMac/MarkdownPreviewView.swift`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`
- `Sources/RistaMac/Resources`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, WYSIWYG behavior, export behavior, App Store configuration, preview rendering repair, or table rendering repair.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed:

- the app starts
- new editor input is accepted
- preview updates from editor input
- the window shows edited/dirty status after text changes
- Space and Enter work
- Cmd+A, Cmd+C, Cmd+V, and Delete/backspace work
- subsequent edits continue to update preview
- the Mac About identity remains intact

Markdown table rendering remains out of scope for this task.

## Result

`RISTA-EDITORSTATE-001I` confirms that the first visible Mac editor-state binding is usable as a baseline for later editor-state work.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
