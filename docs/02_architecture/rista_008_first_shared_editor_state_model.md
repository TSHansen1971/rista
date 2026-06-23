# RISTA-008 – First Shared Editor State Model

## Decision

Rísta has introduced the first minimal shared editor state model in `RistaCore`.

The model is named:

~~~text
RistaEditingSession
~~~

It is intentionally small and platform-independent.

## Reason

Rísta needs a shared product-level editing state before adding `RistaTouch`.

This gives the project a common boundary for editor-relevant behavior while keeping actual text view implementations inside platform surfaces.

## Technical change

This step introduced:

~~~text
Sources/RistaCore/RistaEditingSession.swift
Tests/RistaCoreTests/RistaEditingSessionTests.swift
~~~

The implementation adds:

- `RistaEditingSession`
- `RistaRenderInvalidationReason`
- normalized Markdown text on initialization
- text replacement with line-ending normalization
- dirty-state tracking
- revision tracking
- render invalidation tracking

## Platform boundary

The new editor state model does not import:

- SwiftUI
- AppKit
- UIKit

The model is not a text view, not a document window and not a UI controller.

## Preserved structure

This step did not introduce:

- `RistaTouch`
- UI changes in `RistaMac`
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
- WYSIWYG behavior
- App Store configuration

## Verification

Baseline before change:

~~~text
HEAD: b916920beb77ea6fe5c9724d19f294def55bcc97
~~~

After the change:

- local build succeeded
- local tests succeeded
- `RistaEditingSession` tests were added
- `Package.swift` remained unchanged
- no `RistaTouch` target was introduced
- the new editor-state source file did not import SwiftUI, AppKit or UIKit

## Next gate

The next gate should be:

RISTA-EDITORSTATE-001B – decide whether to connect `RistaMac` to `RistaEditingSession` or first expand shared editor-state tests.

The preferred next step is likely to add one more narrow core test pass before wiring the Mac UI to the new model.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
