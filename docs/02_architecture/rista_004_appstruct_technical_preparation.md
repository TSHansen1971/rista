# RISTA-004 – App Structure Technical Preparation

## Decision

Rísta is ready for a controlled technical preparation step toward the selected Apple-platform target model.

The selected model remains:

- `RistaCore` as shared core
- `RistaMac` as macOS 26+ app surface
- `RistaTouch` as iPad/iPhone app surface

This step is a preparation gate only. It does not restructure the project.

## Current technical state

The current repository is still a Swift Package starter.

It already separates part of the logic into `RistaCore`, while the current app entry and Mac-oriented editor/preview files are still under the initial app target.

This is acceptable for the starter phase, but it should not become the long-term structure if Rísta is to remain a true Apple-platform product.

## Technical implication

The current package should not be casually converted by using Xcode's New Project flow.

The next implementation must preserve existing Git history, keep the shared core testable, and avoid unnecessary churn in source paths.

## Recommended first technical restructuring

The first controlled technical restructuring should be small:

1. Preserve `RistaCore` as the shared target.
2. Rename or split the current app surface toward `RistaMac`.
3. Keep Mac-specific editor files out of the future shared core.
4. Do not introduce `RistaTouch` implementation until the Mac split is clean.
5. Keep tests focused on `RistaCore`.
6. Do not introduce signing, bundle identifiers, entitlements or document type registration in the same step.

## Recommended target direction

The preferred technical direction is:

- `RistaCore`
  - shared pure product logic
  - Markdown parsing and normalization
  - document model
  - rendering model
  - export model later
  - shared tests

- `RistaMac`
  - macOS app entry
  - Mac editor surface
  - AppKit bridge if needed
  - Mac preview shell
  - Mac commands and window behavior later

- `RistaTouch`
  - iPad/iPhone app surface later
  - touch-first editor strategy
  - compact/regular layout adaptation
  - document browser integration later

## Why not create all targets immediately

Creating all targets immediately would add Xcode/project complexity before the shared boundaries have been proven.

The safer path is:

1. make the current Mac starter structurally honest as `RistaMac`
2. keep `RistaCore` clean and tested
3. introduce `RistaTouch` only when the shared core boundary is stable enough

## Implementation constraints for the next step

The next implementation step may modify project structure, but only if it stays narrow.

It should not introduce:

- App Store configuration
- signing changes
- sandbox changes
- iCloud support
- document type registration
- PDF export
- HTML export
- WYSIWYG editor changes
- new product behavior

## Proposed next gate

The next gate should be:

RISTA-APPSTRUCT-001D – first controlled Mac surface split toward `RistaMac`.

That gate should decide the smallest safe code/package change needed to make the existing Mac app surface explicit without introducing iPad/iPhone code prematurely.

## Boundary of this step

This step does not introduce:

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

## Observed baseline

### Git

~~~text
HEAD: 74c035fda28f5ce28629377e6644aea86ee53cb2
Branch: main
Origin main: 74c035fda28f5ce28629377e6644aea86ee53cb2
~~~

### Toolchain

~~~text
xcode-select: /Applications/Xcode-beta.app/Contents/Developer
xcodebuild: Xcode 27.0 Build version 27A5209h
swift: Apple Swift version 6.4 (swiftlang-6.4.0.23.5 clang-2100.3.23.3)
~~~

### Package target lines

~~~text
15:        .target(
18:        .executableTarget(
22:        .testTarget(
~~~

### Sources

~~~text
Sources/RistaApp/ContentView.swift
Sources/RistaApp/EditorPreviewSplitView.swift
Sources/RistaApp/MarkdownPreviewView.swift
Sources/RistaApp/MarkdownTextView.swift
Sources/RistaApp/RistaApp.swift
Sources/RistaCore/MarkdownBlockParser.swift
Sources/RistaCore/MarkdownUtilities.swift
Sources/RistaCore/RistaDocument.swift
~~~

### Tests

~~~text
Tests/RistaCoreTests/MarkdownBlockParserTests.swift
Tests/RistaCoreTests/MarkdownUtilitiesTests.swift
~~~
