# Rísta — Bundle and document type metadata gate

This document records `RISTA-BUNDLE-001A`, a controlled gate for app bundle and document type metadata before implementing iCloud document areas or Finder folder branding.

The baseline commit before this task was:

`68e5a06de98ed6226d006d4f81bb5fc104c8786a`

## Scope

This task is a decision and verification gate only.

It does not patch product code.

It exists to separate four concerns that must not be mixed:

1. the current SwiftPM `DocumentGroup` and `FileDocument` baseline
2. future app bundle identity and LaunchServices document metadata
3. future TextEdit-like startup document browser behavior
4. later iCloud document-area and Finder folder branding work

## Current baseline

Rísta is currently built and launched directly through SwiftPM during development.

The source-level Mac app already uses `DocumentGroup(newDocument: RistaDocument())`.

`RistaDocument` is a `FileDocument`.

The document type surface currently uses a Markdown-oriented `.md` UTType fallback.

The current package has app icon resources, but no committed manual Xcode project, no committed app bundle metadata file, no entitlements file, no iCloud container configuration, and no Finder folder branding configuration.

## Required future metadata surface

Before Rísta can reliably behave like a fully integrated native Apple document app outside direct SwiftPM launch, the project needs a controlled bundle/document metadata step.

That future step should decide and implement, in a narrow and reviewable way:

- bundle identifier
- app display name and bundle name
- version and build metadata source of truth
- app icon use in the built app bundle
- document type registration for Markdown documents
- whether Rísta should declare its own exported type or use a recognized Markdown/plain text type
- file extension handling for `.md`
- LaunchServices behavior for open, recent documents, and document icons
- default document role and handler behavior
- how this interacts with the SwiftUI `DocumentGroup` source-level document model

This metadata step should happen before iCloud document-area work and before Finder folder branding.

## iCloud and Finder folder boundary

The desired Rísta iCloud document area and a Finder-visible Rísta-branded folder are separate follow-up tracks.

They may require signing, entitlements, iCloud document container configuration, stable bundle identity, and Finder metadata behavior.

They must not be implemented in this gate.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources`
- resources
- app targets
- document type registration
- entitlements
- iCloud container configuration
- Finder folder branding
- bundle identity
- Info.plist or LaunchServices metadata

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, WYSIWYG behavior, export behavior, App Store configuration, preview rendering repair, or table rendering repair.

## Verification

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass observed the current SwiftPM development startup behavior and confirmed that the current app icon/About identity, editor input, preview updates, and edited/dirty status still work.

## Result

`RISTA-BUNDLE-001A` establishes the controlled boundary for app bundle and document type metadata.

The recommended next task is a narrow metadata implementation or preparation task before any iCloud folder branding is attempted.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
