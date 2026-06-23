# RISTA-010 – Mac Editor Model Binding Decision

## Decision

Rísta shall not connect `RistaMac` directly and broadly to `RistaEditingSession` from the SwiftUI view layer.

The selected direction is to introduce a small Mac-specific editor adapter model before wiring the Mac editor UI to the shared editing session.

A future implementation may use a name such as:

~~~text
RistaMacEditorModel
~~~

or:

~~~text
RistaMacEditingViewModel
~~~

The exact name shall be chosen during implementation.

## Reason

`RistaEditingSession` belongs in `RistaCore` and represents shared product-level editor state.

`RistaMac` owns the Mac user interface, including the SwiftUI/AppKit editor surface.

Connecting `ContentView`, `EditorPreviewSplitView` or `MarkdownTextView` directly and repeatedly to core state would make the platform boundary less clear.

A small Mac-specific model gives Rísta a safer boundary:

- `RistaCore` remains platform-independent
- `RistaMac` owns platform binding and UI adaptation
- AppKit/SwiftUI details do not leak into shared core
- future `RistaTouch` can use the same core state through its own adapter
- editor behavior can be tested in smaller layers

## Selected binding pattern

The preferred pattern is:

~~~text
RistaCore
  RistaEditingSession

RistaMac
  RistaMacEditorModel
    owns or wraps RistaEditingSession
    exposes Mac-appropriate text binding
    translates user edits into session updates
    exposes dirty/render state for Mac UI
~~~

The Mac editor view should bind to the Mac model, not directly to every detail of the shared core session.

## Responsibilities of the future Mac editor model

A future Mac editor model may own:

- one `RistaEditingSession`
- current editor text binding
- dirty-state exposure
- render invalidation observation
- document-load synchronization
- save/mark-clean coordination
- Mac-specific UI state that should not enter `RistaCore`

It should not own:

- Markdown parsing rules
- Markdown normalization rules
- platform-independent document semantics
- export behavior
- `RistaTouch` behavior
- generic product rules that belong in `RistaCore`

## What shall remain in RistaCore

`RistaCore` should continue to own:

- document model
- Markdown normalization
- Markdown parsing
- shared editor-state model
- render model later
- export model later
- shared tests

`RistaCore` shall not import SwiftUI, AppKit or UIKit.

## What shall remain in RistaMac

`RistaMac` should own:

- Mac app entry
- Mac editor view
- Mac preview layout
- SwiftUI/AppKit bridging
- Mac window/document behavior
- Mac-specific editor adapter model

## Why not connect UI directly now

Direct connection from the current Mac UI to `RistaEditingSession` may be faster, but it risks making `RistaEditingSession` serve Mac UI needs too early.

That would weaken the later `RistaTouch` boundary.

The next implementation should therefore add a narrow Mac adapter first, then connect the existing UI through it only if the build/test and visual smoke result remains clean.

## Recommended next gate

The next gate should be:

RISTA-EDITORSTATE-001D – first minimal `RistaMacEditorModel` without visible UI behavior change.

That gate may introduce code in `Sources/RistaMac`, but should not change the user-visible editor behavior yet.

## Boundary of this step

This decision does not introduce:

- product code changes
- `Package.swift` changes
- file moves
- `RistaTouch`
- new Xcode project
- new Xcode workspace
- new app targets
- visible UI changes
- bundle identifier changes
- signing changes
- sandbox changes
- document type registration
- iCloud support
- export implementation
- WYSIWYG behavior
- App Store configuration

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
