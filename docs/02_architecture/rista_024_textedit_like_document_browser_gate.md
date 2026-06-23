# Rísta — TextEdit-like document browser gate

This document records `RISTA-DOCBROWSER-001A`, a gate for the native Apple document browser direction.

The baseline commit before this task was:

`5fa540709c8cbe41795073f100c63739b6ce9ee2`

## Scope

This task is a decision and verification gate only.

It does not patch product code.

It exists to separate three concerns that must not be mixed:

1. the current SwiftUI `DocumentGroup` and `FileDocument` baseline
2. the desired TextEdit-like startup document browser and New Document behavior
3. future iCloud document-area and Finder folder identity work

## Current baseline

Rísta is already a SwiftUI document app at the source level.

The Mac app uses `DocumentGroup(newDocument: RistaDocument())`.

`RistaDocument` is a `FileDocument`.

The document type surface currently uses a Markdown-oriented `.md` UTType fallback.

In direct SwiftPM launch, the app may open straight into an untitled document. This is an acceptable development-run baseline and must not by itself be treated as a failed native document-browser design.

## Desired native behavior

Rísta should follow the native Apple document-app pattern.

The desired future behavior is:

- startup presents a standard Apple document browser/open surface where appropriate
- the document browser defaults to Rísta's own document area
- a clear `New Document` action is available
- `New Document` opens a blank, unsaved `Untitled` Markdown document
- existing Markdown documents can be opened through the standard Apple document flow
- save, save-as, dirty/edited status, open, recent documents, and reopen behavior remain native and predictable

Rísta should not implement a custom file browser unless the native Apple document architecture cannot provide the required behavior.

## iCloud and folder branding boundary

The desired Rísta iCloud document area and a Finder-visible Rísta-branded folder are separate follow-up tracks.

They may require bundle identity, document type registration, iCloud document container configuration, signing/entitlement decisions, and Finder metadata behavior.

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

A manual visual pass observed the current development startup behavior and confirmed that editor input, preview updates, and edited/dirty status still work.

## Result

`RISTA-DOCBROWSER-001A` establishes the native document-browser direction while preserving the current green product baseline.

The recommended next task is a narrow implementation planning or product task for native document type and bundle metadata before any iCloud folder branding is attempted.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
