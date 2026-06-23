# RISTA-003 – Target Model Decision

## Decision

Rísta shall use separate platform app surfaces sharing the same core.

The selected target model is:

- one shared core for document, Markdown, rendering and export logic
- one macOS app surface for macOS 26 and newer
- one iPad/iPhone app surface for iPadOS and iOS, unless later implementation evidence shows that separate iPad and iPhone targets are required

This decision rejects a lowest-common-denominator single-interface strategy.

## Reason

Rísta must feel native on Mac, iPad and iPhone.

The Mac version will likely need Mac-specific editor behavior, keyboard behavior, menu commands, window behavior and possibly AppKit integration through `NSTextView`.

iPad and iPhone need platform-appropriate editing, navigation, document access and preview behavior. They should share product logic with the Mac version, but they should not inherit Mac-only UI assumptions.

## Selected structure

The preferred structure is:

- `RistaCore`
  - document model
  - Markdown normalization
  - Markdown parsing
  - rendering model
  - export model
  - file semantics
  - shared product rules
  - shared tests

- `RistaMac`
  - macOS 26+ app surface
  - Mac editor implementation
  - Mac preview layout
  - Mac commands, menus and keyboard shortcuts
  - Mac document-window behavior

- `RistaTouch`
  - iPad and iPhone app surface
  - touch-first editor implementation
  - compact and regular-width layout adaptation
  - platform document browser integration
  - touch navigation and preview behavior

The exact target names may be adjusted during implementation, but the architectural separation shall remain.

## Xcode implication

Rísta may continue as a Swift Package starter while the codebase is still small.

When app targets are introduced, the project should move toward a controlled Xcode project or workspace that references shared core logic rather than burying core behavior inside one platform target.

The Xcode structure should be introduced deliberately, not by casually creating a new project from Xcode templates and dragging files around.

## Target model rejected for now

A single universal app target with all UI logic embedded in one surface is not the preferred direction.

It may appear simpler at first, but it risks:

- Mac UI being constrained by iPhone assumptions
- iPhone UI being constrained by desktop assumptions
- editor implementation becoming tangled
- platform-specific behavior leaking into shared core
- weaker testability
- unclear product boundaries

## Implementation rule

No target restructuring shall happen in this step.

Any future creation of Xcode project, workspace, app targets, bundle identifiers, signing settings, entitlements, document type declarations or platform-specific app entry points shall be done in a separate controlled implementation step.

## Next implementation gate

The next implementation gate should be:

RISTA-APPSTRUCT-001C – controlled technical preparation for Apple-platform target structure.

That gate should inspect the current Swift Package layout and decide the smallest safe technical step toward the selected model.

## Current boundary

This decision does not introduce:

- product code changes
- Package.swift changes
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
