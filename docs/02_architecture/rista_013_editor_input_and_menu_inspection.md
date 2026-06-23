# RISTA-013 – Editor Input and App Menu Inspection

## Decision

Rísta shall pause further editor-state binding until Mac editor keyboard handling, responder-chain behavior and app menu behavior have been inspected and repaired.

`RISTA-EDITORSTATE-001F` shall not be resumed before this editor-input track is resolved.

## Reason

During visual smoke verification for the first non-visual Mac editor-model ownership attempt, the app launched and showed the editor/preview surface, but full keyboard manipulation was not acceptable.

Observed behavior:

- mouse selection worked
- right-click paste worked
- delete/backspace worked
- Command+A and Command+V did not work as expected
- Enter/line break did not work
- Spacebar did not work
- full keyboard manipulation therefore did not work
- the app did not show normal app menu/basic controls as expected
- visible Rísta UI text was Norwegian

This blocks further editor-state binding because the current editor surface must behave as a normal Mac text editor before the binding model becomes more complex.

## Current source structure

The current active Mac surface is:

~~~text
Sources/RistaMac
~~~

The current shared editor state model is:

~~~text
Sources/RistaCore/RistaEditingSession.swift
~~~

The current Mac editor adapter exists but is not connected to visible UI:

~~~text
Sources/RistaMac/RistaMacEditorModel.swift
~~~

## Current editor implementation to inspect

The current editor surface is implemented in:

~~~text
Sources/RistaMac/MarkdownTextView.swift
~~~

This file is the primary repair candidate because it owns the `NSTextView` / `NSViewRepresentable` bridge.

## Current app/menu implementation to inspect

The current app entry is:

~~~text
Sources/RistaMac/RistaMacApp.swift
~~~

This file is a repair candidate if the app needs explicit SwiftUI command/menu declarations for standard Mac text editing commands.

## Likely repair areas

The next repair step should inspect and, if needed, repair:

- `NSTextView` first responder behavior
- `NSViewRepresentable` update behavior
- text input routing
- standard text editing command routing
- app menu / Edit menu availability
- select-all behavior
- paste behavior
- line-break behavior
- spacebar behavior
- whether the Swift Package executable launch path affects normal app menu behavior

## UI language observation

The Norwegian visible UI text is currently treated as hardcoded app UI text, not as automatic macOS localization.

This should be handled in a later product language/localization decision. It is not the same issue as keyboard input handling.

## Required next gate

The next gate should be:

RISTA-EDITOR-INPUT-001B – repair Mac editor keyboard handling and app menu behavior.

That gate may change `MarkdownTextView.swift` and possibly `RistaMacApp.swift`, but should remain narrowly scoped to Mac editor input and standard app menu behavior.

## Boundary of this step

This inspection does not introduce:

- product code changes
- `Package.swift` changes
- file moves
- `RistaTouch`
- new Xcode project
- new Xcode workspace
- new app targets
- editor-state binding changes
- visible product redesign
- document model changes
- preview behavior changes
- export implementation
- WYSIWYG behavior
- App Store configuration

## Verification

Baseline before this inspection:

~~~text
HEAD: 3e75ad4d43177593f9b2c4e08af486ed37a8277a
~~~

The inspection verified:

- local build succeeded
- local tests succeeded
- no product files were changed
- `RistaMacEditorModel` remained disconnected from visible UI
- `RistaTouch` was not introduced
- `Package.swift` remained unchanged

## Evidence location

Local inspection evidence was written to:

~~~text
/tmp/rista-editor-input-001a-inspection-20260623-150935
~~~

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
