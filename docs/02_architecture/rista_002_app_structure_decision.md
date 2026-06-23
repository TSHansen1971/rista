# RISTA-002 – App Structure Decision

## Decision

Rísta shall be structured as an Apple-platform application, not as a macOS-only application with possible mobile ports later.

The project shall support:

- macOS 26 and newer
- iPad
- iPhone

The architecture shall separate shared product logic from platform-specific user interface implementation.

## Direction

Rísta shall use a shared core for document and Markdown behavior, and platform-specific app surfaces for Mac, iPad and iPhone.

The project shall not force all platforms into the same editor implementation. The correct target is a coherent Apple-platform product with native behavior on each device class.

## Shared core

The following shall be shared where possible:

- document model
- Markdown normalization
- Markdown parsing
- rendering model
- export model
- file semantics
- product rules
- tests

The current `RistaCore` target is the beginning of this shared core.

## Platform-specific surfaces

The following may be platform-specific:

- text editor implementation
- preview layout
- window and scene behavior
- menu commands
- keyboard shortcuts
- toolbar and navigation model
- document browser integration
- platform-specific export surfaces

The Mac editor may use AppKit through `NSTextView`.

iPad and iPhone shall use platform-appropriate UIKit/SwiftUI/TextKit strategy rather than inheriting Mac-only editor assumptions.

## Xcode structure

The current Swift Package starter is acceptable as an early development foundation.

However, the project shall move toward a controlled Xcode workspace or Xcode project structure when platform targets are introduced.

That future structure should preserve the shared core while adding platform targets in a controlled way.

Expected future direction:

- shared Swift package or shared internal modules for core logic
- macOS app target for macOS 26 and newer
- iPad/iPhone app target or targets
- common product name: Rísta
- platform-specific UI shells
- shared tests for core behavior
- platform tests added later where useful

## Naming rule

The public product name is Rísta.

The technical ASCII-safe name remains Rista for bundle identifiers, paths, source targets and automation where needed.

## Implementation rule

No app target restructuring shall be done casually from Xcode's New Project flow.

Any future creation of Xcode project, workspace, app targets, bundle identifiers, signing settings, entitlements or document type declarations shall be handled as a separate controlled implementation step.

## Current boundary

This decision does not change product code.

This decision does not introduce:

- new Xcode project
- new app targets
- Package.swift changes
- bundle identifier changes
- signing changes
- sandbox changes
- document type registration
- iCloud support
- export implementation
- App Store configuration

## Next implementation gate

The next implementation gate should be:

RISTA-APPSTRUCT-001B – controlled creation or restructuring of Xcode project and Apple-platform targets.

That gate must decide whether Rísta should use:

- one multi-platform app target with platform adaptations, or
- separate macOS and iOS/iPadOS app targets sharing the same core.

The preferred direction is separate platform app surfaces sharing the same core, unless Xcode 27 beta demonstrates that one multi-platform app target gives equal clarity without forcing lowest-common-denominator UI.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
