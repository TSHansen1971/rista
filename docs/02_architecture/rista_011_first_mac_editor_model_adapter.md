# RISTA-011 – First Mac Editor Model Adapter

## Decision

Rísta has introduced the first minimal Mac-specific editor adapter model in `RistaMac`.

The model is named:

~~~text
RistaMacEditorModel
~~~

This is the first code-level bridge between the Mac app surface and the shared editor-state model, but it is not yet connected to the visible editor UI.

## Reason

`RistaEditingSession` belongs in `RistaCore`.

`RistaMac` needs a Mac-owned adapter before the visible SwiftUI/AppKit editor surface is connected to shared editor state.

This keeps the platform boundary clear:

- `RistaCore` owns shared editor state
- `RistaMac` owns Mac-specific binding and adaptation
- future `RistaTouch` can use its own adapter later
- the current Mac UI is not changed prematurely

## Technical change

This step added:

~~~text
Sources/RistaMac/RistaMacEditorModel.swift
~~~

The model wraps one `RistaEditingSession` and exposes:

- current text
- dirty state
- revision
- render invalidation revision
- last render invalidation reason
- text replacement
- clean-state marking
- manual render invalidation
- session replacement from Markdown text

## Preserved behavior

This step does not connect the model to:

- `ContentView`
- `EditorPreviewSplitView`
- `MarkdownTextView`
- visible editor behavior
- document save behavior
- preview update behavior

The user-visible app behavior should therefore remain unchanged.

## Preserved boundaries

This step did not introduce:

- `RistaTouch`
- `Package.swift` changes
- `RistaCore` changes
- visible UI changes
- file moves
- new Xcode project
- new Xcode workspace
- new app targets
- bundle identifier changes
- signing changes
- sandbox changes
- document type registration
- iCloud support
- export implementation
- WYSIWYG behavior
- App Store configuration

## Verification

Baseline before change:

~~~text
HEAD: cdb998a0173af14094f22bc3ad2e40127729e0dc
~~~

After the change:

- local build succeeded
- local tests succeeded
- `Package.swift` remained unchanged
- `RistaTouch` was not introduced
- `RistaMacEditorModel` did not import SwiftUI, AppKit or UIKit directly
- `RistaMacEditorModel` was not connected to existing visible UI files

## Next gate

The next gate should be:

RISTA-EDITORSTATE-001E – decide and implement the first controlled, non-visual connection between `RistaMacEditorModel` and the existing Mac document flow.

That gate should remain narrow and should verify that visible editor behavior does not regress.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
