# Rísta — First visible editor-state binding

This document records `RISTA-EDITORSTATE-001H`, the first narrow product task that connects the visible Mac editor surface to the existing Mac editor-state model.

The baseline commit before this task was:

`b2553b8bcb4517f5ff1c88e44e213b4ecb22bb08`

## Scope

This task is intentionally narrow.

Inspection showed that the Mac app scene in `RistaMacApp.swift` opens `ContentView(document: file.$document)`, and that the actual editor and preview anchor is in `ContentView.swift`, where `EditorPreviewSplitView` receives the document text binding.

The product patch therefore belongs in `Sources/RistaMac/ContentView.swift`.

This task connects the visible Mac editor and preview path to `RistaMacEditorModel` without changing the editor model implementation, the core editing session implementation, the text view implementation, preview rendering behavior, table rendering, app icon resources, About metadata, platform targets, or project structure.

## Implementation

The visible Mac content view now owns a `RistaMacEditorModel` instance as SwiftUI `@State`.

The editor text binding uses the model text through `RistaMacEditorModel.replaceText(with:)`.

The document text remains updated from the editor binding so the document group continues to receive text changes.

The preview path reads through the same binding, preserving the existing editor-to-preview behavior while moving visible editor-state ownership into the Mac editor model surface.

This repair uses `@State`, not `@StateObject`, because the existing `RistaMacEditorModel` is not an `ObservableObject`.

## Product-code boundary

This task changes only:

- `Sources/RistaMac/ContentView.swift`

It does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/RistaMacApp.swift`
- `Sources/RistaMac/MarkdownTextView.swift`
- `Sources/RistaMac/RistaMacEditorModel.swift`
- `Sources/RistaMac/Resources`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, WYSIWYG behavior, export behavior, App Store configuration, preview rendering repair, or table rendering repair.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A short manual visual pass confirmed that the app starts, the editor still accepts keyboard input, preview still updates from editor input, standard basic editing operations still work, the edited-state behavior remains normal, and the Mac About identity remains intact.

## Result

`RISTA-EDITORSTATE-001H` establishes the first visible Mac editor-state binding and creates a controlled baseline for later editor-state improvements.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
