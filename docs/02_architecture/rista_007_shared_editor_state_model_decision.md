# RISTA-007 – Shared Editor State Model Decision

## Decision

Rísta shall define the shared editor state model before introducing a real `RistaTouch` target.

The selected direction is:

- keep platform text views inside platform surfaces
- keep shared document and Markdown behavior inside `RistaCore`
- introduce a future shared editor state model only when its responsibilities are explicit
- avoid placing AppKit, UIKit, SwiftUI view behavior or platform selection mechanics inside shared core
- avoid creating `RistaTouch` as an empty symbolic target before the editor boundary is clear

## Reason

Rísta is an editor-centered product.

The text view itself is platform-specific, but the product state around editing must become coherent across Mac, iPad and iPhone.

If Rísta adds `RistaTouch` before defining this boundary, the codebase may split into two unrelated editors:

- one Mac editor path
- one touch editor path

That would weaken the product identity and make future WYSIWYG-oriented behavior harder to implement consistently.

## Shared editor state purpose

A future shared editor state model should represent editor-relevant product state that is not inherently platform UI.

It may later include:

- current Markdown text
- normalized text representation
- document identity
- document dirty state
- active editor mode
- preview synchronization intent
- selected block or structural focus where platform-independent
- editor diagnostics where platform-independent
- undo/redo coordination rules if they can be shared safely
- render invalidation intent

It should not own platform text rendering.

## What must remain platform-specific

The following must remain outside shared core unless a later decision explicitly proves a safe abstraction:

- `NSTextView`
- `UITextView`
- SwiftUI `TextEditor`
- platform selection handles
- insertion point rendering
- platform spellchecking UI
- platform input accessory UI
- platform keyboard command routing
- platform scroll physics
- platform menu commands
- platform document window behavior
- platform navigation stacks

## Mac implication

`RistaMac` may continue to use Mac-native editor implementation details.

A Mac-native editor can use AppKit and `NSTextView` where appropriate.

That must not define the internal shape of `RistaTouch`.

## Touch implication

`RistaTouch` should not be added merely because the target model says it will exist.

It should be introduced when the first touch implementation has a clear minimum purpose, such as:

- opening a Markdown document
- editing plain Markdown text
- switching between edit and preview
- using shared parser/render behavior from `RistaCore`
- proving the shared editor state boundary

## Recommended first editor-state implementation

The first implementation should not try to solve WYSIWYG.

The recommended first implementation is a small, testable model in `RistaCore` that can describe the product-level editing session without importing platform UI frameworks.

A future name may be:

~~~text
RistaEditorState
~~~

or:

~~~text
RistaEditingSession
~~~

The exact name shall be chosen during implementation.

## Required tests for future implementation

When the shared editor state model is introduced, tests should verify at minimum:

- creation from Markdown text
- line ending normalization behavior
- text update behavior
- dirty-state transition
- render invalidation signal or equivalent
- no dependency on AppKit/UIKit/SwiftUI view types

## Why not add RistaTouch now

Adding `RistaTouch` now would be structurally visible but technically weak.

A target without a clear editor model risks becoming either:

- a placeholder with no value
- a second independent editor path
- a SwiftUI `TextEditor` experiment that later must be replaced
- an unnecessary package/project complication

The safer path is to define the shared editor state boundary first.

## Recommended next gate

The next gate should be:

RISTA-EDITORSTATE-001A – first minimal shared editor state model in `RistaCore`.

That gate may introduce code, but only if it remains small, testable and platform-independent.

## Boundary of this step

This decision does not introduce:

- product code changes
- `Package.swift` changes
- file moves
- `RistaTouch`
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

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
