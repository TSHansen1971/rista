# RISTA-002 – Platform Target Policy

## Decision

Rísta shall be developed for macOS 26 and newer, and simultaneously for iPad and iPhone.

The project shall not be treated as a macOS-only app with a possible mobile port later. It shall be treated as an Apple-platform product from the start.

## Platform targets

The current platform policy is:

- macOS 26 and newer
- iPad
- iPhone

The exact minimum iPadOS and iOS versions shall be decided when the first multi-platform Xcode target structure is introduced.

## Architecture rule

Shared logic shall be kept separate from platform-specific user interface code.

The following should be shared where possible:

- document model
- Markdown parsing and normalization
- rendering model
- export logic
- file/document semantics
- tests
- product rules

The following may be platform-specific:

- editor surface implementation
- window and scene behavior
- keyboard and shortcut handling
- menu and command structure
- toolbar/navigation model
- preview layout
- file picker and document browser integration

## Editor rule

The Mac editor may use AppKit through `NSTextView` where that gives better control than a basic SwiftUI editor.

iPad and iPhone shall not inherit Mac-only editor assumptions. They require a platform-appropriate editor strategy that preserves the same document and Markdown behavior through shared core logic.

## Layout rule

Side-by-side editor and preview is a preferred layout where the device class supports it, especially on Mac and larger iPad configurations.

Compact iPhone layouts may use a different interaction model while preserving the same product principle: plain text writing, live structure, open Markdown files and minimal friction.

## Product rule

Rísta shall remain native to each supported Apple platform. Multi-platform support must not mean lowest-common-denominator UI.

The goal is a coherent Apple-platform Markdown editor, not three unrelated apps and not a Mac app mechanically stretched onto smaller devices.

## Non-goals for this policy step

This policy step does not introduce:

- new app targets
- Xcode project restructuring
- code changes
- build setting changes
- App Store configuration
- sandbox/notarization configuration
- export implementation
- iCloud or sync implementation

Those must be handled by separate controlled implementation steps.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
