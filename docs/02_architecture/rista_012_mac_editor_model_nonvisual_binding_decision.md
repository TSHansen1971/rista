# RISTA-012 – Mac Editor Model Non-Visual Binding Decision

## Decision

Rísta shall connect `RistaMacEditorModel` to the Mac document flow before connecting it to the visible editor surface.

The first connection shall be non-visual.

The selected next implementation direction is:

- keep the visible editor behavior unchanged
- keep `MarkdownTextView` unchanged
- keep preview behavior unchanged
- keep `Package.swift` unchanged
- keep `RistaCore` unchanged
- introduce only the smallest Mac-side ownership/binding needed to initialize a `RistaMacEditorModel` from the current document text

## Reason

`RistaMacEditorModel` exists as a Mac-specific adapter around `RistaEditingSession`.

The next risk is connecting it too deeply into the UI too early.

A direct editor binding could accidentally change text editing behavior, preview update behavior or document mutation behavior before the adapter boundary is proven.

The safer path is to establish the model as a non-visual companion to the existing Mac document flow first.

## Binding principle

The first binding should prove that `RistaMacEditorModel` can exist beside the current document binding without changing what the user sees.

The model may be initialized from the current document Markdown text, but the visible editor should continue to use the existing document binding until a later gate explicitly changes that behavior.

## Preferred implementation shape

The preferred first implementation is a narrow Mac-side holder or state point, likely near the current document-facing view boundary.

A future implementation may introduce one of these patterns:

~~~text
@State private var editorModel = RistaMacEditorModel()
~~~

or a small Mac-specific holder that owns:

~~~text
RistaMacEditorModel
~~~

The exact implementation shall be chosen in the next gate after inspecting the current `ContentView`, `EditorPreviewSplitView` and `MarkdownTextView` structure.

## What the first implementation must not do

The first implementation must not:

- change visible editor behavior
- replace the existing text binding in `MarkdownTextView`
- change preview rendering behavior
- change document save behavior
- change document load behavior in a user-visible way
- add `RistaTouch`
- change `Package.swift`
- change `RistaCore`
- introduce WYSIWYG behavior
- introduce export behavior

## Required verification for the next implementation

The next implementation must verify:

- local build succeeds
- local tests succeed
- `Package.swift` remains unchanged
- `RistaTouch` is not introduced
- `RistaEditingSession` remains platform-independent
- `RistaMacEditorModel` remains Mac-owned
- visible editor behavior is unchanged by manual smoke verification
- the app can still open and edit the existing document surface

## Why not connect MarkdownTextView directly yet

`MarkdownTextView` is the actual editor surface.

Changing its binding is more likely to alter user-visible behavior.

That should happen only after the Mac adapter has first been introduced safely into the document-flow boundary.

## Recommended next gate

The next gate should be:

RISTA-EDITORSTATE-001F – first non-visual `RistaMacEditorModel` ownership in the Mac document flow.

That gate may introduce a small code change in `Sources/RistaMac`, but must not change visible editor behavior.

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
- editor binding changes
- document save changes
- preview behavior changes
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
