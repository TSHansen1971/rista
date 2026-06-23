# RISTA-006 – Touch Editor Strategy Decision

## Decision

Rísta shall not introduce `RistaTouch` as a real implementation target before the touch editor strategy is defined.

The selected strategy is a progressive touch editor architecture:

- keep Markdown and document behavior in shared core logic
- keep Mac editor implementation inside `RistaMac`
- define iPad and iPhone editor behavior before adding `RistaTouch`
- allow `RistaTouch` to start simple, but do not bind the long-term editor to SwiftUI `TextEditor` alone
- preserve the option to use UIKit, TextKit or a wrapped native text view when serious editor behavior requires it

## Reason

A Markdown editor is primarily an editor. The text surface is therefore not incidental UI; it is the core interaction surface.

Mac, iPad and iPhone have different editing constraints:

- Mac has windows, menus, keyboard shortcuts, pointer precision and strong AppKit text editing options
- iPad has touch, pointer, hardware keyboard, split view, large canvas options and regular/compact size classes
- iPhone has compact layout, touch-first navigation and limited simultaneous editor/preview space

Rísta should preserve one product identity across these platforms without forcing one text editor implementation onto all of them.

## Strategic rule

`RistaTouch` shall be a platform surface, not a diluted Mac surface.

It shall share product logic with `RistaCore`, but it shall have its own editor and layout decisions.

## Touch editor options

The touch editor strategy shall remain open to three implementation levels.

### Level 1 – SwiftUI starter

A SwiftUI-native editor may be acceptable for the first minimal touch surface if the goal is only to prove document flow, text entry and preview navigation.

This level is not enough to define the long-term editor.

### Level 2 – UIKit/TextKit bridge

A UIKit-backed editor may be required for stronger control over:

- selection behavior
- scrolling
- keyboard behavior
- input accessory behavior
- large document performance
- syntax treatment
- editor-specific gestures
- platform text system integration

This is the likely long-term direction if SwiftUI alone is too constrained.

### Level 3 – dedicated editor layer

A later dedicated editor layer may be introduced if both Mac and touch platforms need shared editor state, syntax model, cursor-affordance model or render coordination beyond what view wrappers should own.

That layer should still not contain platform UI directly.

## iPad layout principle

On iPad, Rísta should support a writing experience that can resemble the Mac principle where space allows it:

- editor and preview side by side on larger iPad layouts
- editor-focused mode when needed
- preview-focused mode when needed
- hardware keyboard support
- touch and pointer behavior that feels native to iPadOS

## iPhone layout principle

On iPhone, Rísta should not force side-by-side layout.

The preferred direction is a compact flow where writing and preview remain close, but not necessarily simultaneous.

Possible iPhone patterns may include:

- edit view with quick preview access
- segmented editor/preview mode
- preview sheet
- focused writing mode
- document outline or navigation added later

The product principle remains the same: plain text writing, visible structure, open Markdown files and minimal friction.

## Shared core boundary

`RistaCore` should own behavior that must be identical across platforms:

- document model
- Markdown normalization
- Markdown parsing
- render model
- export model later
- product rules
- shared tests

`RistaCore` should not own platform text view code.

## Mac boundary

`RistaMac` may continue to use AppKit through `NSTextView`.

That decision must not leak into `RistaTouch`.

## Touch boundary

`RistaTouch` shall not be created merely as an empty symbolic target.

It should be introduced only when the first minimal touch implementation step is clear.

## Recommended next gate

The next gate should be:

RISTA-APPSTRUCT-001F – decide whether to introduce a placeholder `RistaTouch` target or first define a shared editor state model.

The preferred direction is to define the shared editor state model before adding a real touch app target.

## Current boundary

This decision does not introduce:

- `RistaTouch`
- product code changes
- `Package.swift` changes
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
- App Store configuration

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
