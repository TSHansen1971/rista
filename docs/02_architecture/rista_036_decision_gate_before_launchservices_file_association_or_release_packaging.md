# RISTA-BUNDLE-001F — Decision gate before LaunchServices/file association or release/install packaging

## Status

Status: Ready with note  
Task: RISTA-BUNDLE-001F  
Repair run: RISTA-BUNDLE-001F-REPAIR001  
Date: 2026-06-23  
Repository: `/Users/tostha/prosjekter/rista`  
Remote: `git@github.com:TSHansen1971/rista.git`  
Branch: `main`  
Baseline HEAD: `a775ccb4ad8705e6cfdaf5daf010422d00d67fa3`  
Local HEAD at gate start: `a775ccb4ad8705e6cfdaf5daf010422d00d67fa3`  
Origin/main at gate start: `a775ccb4ad8705e6cfdaf5daf010422d00d67fa3`

## Purpose

This document closes a documentation-only decision gate before any later work on LaunchServices/file association, install-location behavior, release packaging, Finder branding, or iCloud/document-container behavior.

The gate does not implement any of those tracks. It verifies the current generated macOS app bundle baseline, clarifies the boundary between passive bundle metadata and active LaunchServices behavior, and records the next permitted narrow track.

## Repair note

The first RISTA-BUNDLE-001F script stopped because it treated existing `CFBundleDocumentTypes`, `LSHandlerRank`, `LSItemContentTypes`, and `UTImportedTypeDeclarations` entries in the active metadata template as a blocking failure.

That was too broad for this gate. Those keys are now treated as an existing generated-bundle metadata contract observation. They are not treated as active LaunchServices registration, Finder behavior, install-location behavior, release packaging, or iCloud/document-container behavior.

## Verified baseline

The gate verified the following before writing this document:

- Local repository HEAD was the expected baseline `a775ccb4ad8705e6cfdaf5daf010422d00d67fa3`.
- `origin/main` was the same expected baseline.
- Git status was clean before the decision document was written.
- The macOS app bundle build tool exists: `tools/build_macos_app_bundle.zsh`.
- The active macOS metadata template exists: `metadata/apple/macos/RistaMacInfo.plist.template`.
- The previous independent generated app bundle verification document exists: `docs/02_architecture/rista_035_independent_generated_app_bundle_verification_after_copyright_repair.md`.
- Documentation traces for BUNDLE-001D, BUNDLE-001E-REPAIR001, and BUNDLE-001E-RERUN001 were present.
- `.build` has no Git-tracked files.
- Local build completed successfully.
- Local tests completed successfully.
- The generated macOS app bundle was materialized for verification only: `.build/rista-macos-app/Rista.app`.
- The generated `Info.plist` passed `plutil -lint`: `.build/rista-macos-app/Rista.app/Contents/Info.plist`.

## Generated bundle identity observed

The generated app bundle metadata observed at this gate was:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundleShortVersionString`: `0.1`

## Existing document-type metadata observation

Existing document-type/UTI metadata was observed in the active macOS metadata template and/or generated Info.plist. This is treated as a baseline metadata contract observation, not as active LaunchServices registration or a new implementation by this gate.

Observed document-type metadata indicators:

- Template marker count: `4`
- Generated `Info.plist` has `CFBundleDocumentTypes`: `1`
- Generated `Info.plist` has `UTImportedTypeDeclarations`: `1`
- Generated `Info.plist` has `UTExportedTypeDeclarations`: `0`
- Generated `Info.plist` includes `LSHandlerRank` marker: `1`
- Generated `Info.plist` includes `LSItemContentTypes` marker: `1`

This means the next LaunchServices-related step must not be framed as introducing file association metadata from zero. It must instead decide whether the existing metadata contract should be kept as-is, narrowed, renamed, deferred behind release packaging, or split into a stricter future implementation gate.

## Explicitly closed surfaces

The following remain explicitly closed after this gate:

- No `Package.swift` change.
- No `Sources` change.
- No `Resources` change.
- No metadata-template change.
- No `tools` change.
- No build-tool change.
- No `lsregister` call.
- No active LaunchServices registration.
- No Finder or `open` file-association test.
- No opening of a Markdown file through Finder as an association test.
- No install-location behavior.
- No release packaging.
- No DMG, PKG, notarization, stapling, or signing-policy work.
- No entitlements file.
- No iCloud container configuration.
- No Finder folder branding.
- No document-browser implementation.
- No RistaTouch work.
- No new Xcode project or workspace.
- No new app targets.
- No iPad or iPhone implementation.
- No preview/rendering repair.
- No table-rendering repair.
- No WYSIWYG work.
- No export feature.

## Risk locks before any first implementation

Before any active LaunchServices/file association implementation or release/install packaging work, the following risks must be locked in a separate narrow gate:

1. Whether Rísta should declare Markdown ownership as an editor, viewer, alternate handler, or imported type participant.
2. Whether the existing `CFBundleDocumentTypes` and UTI metadata should be retained unchanged or narrowed before any active association test.
3. Whether file association should be tested only after a defined install location exists, to avoid misleading LaunchServices behavior from `.build`.
4. Whether release packaging must be defined before Finder branding or file association validation.
5. Whether iCloud/document-container behavior should remain fully deferred until the multi-platform document model is clearer.

## Decision

Decision: Ready for a first narrow LaunchServices/file association decision gate.

That next gate must still be documentation-first and boundary-setting. Its purpose should be to decide the exact file association metadata contract and whether active association testing should wait for release/install packaging. It must not combine file association, install location, release packaging, Finder branding, and iCloud/document-container behavior in one implementation step.

Release packaging, install-location behavior, Finder branding, and iCloud/document-container behavior are deliberately deferred.

## Notes

- Observed .swiftpm/xcode/package.xcworkspace. This is treated as local SwiftPM package tooling, not as a manually introduced app workspace.
- Existing document-type/UTI metadata is a baseline observation and must be handled explicitly in the next LaunchServices-related gate.

## Negative confirmations

This gate did not change product code, resources, metadata templates, build tools, package configuration, app targets, entitlements, or platform implementation surfaces.

This gate did not register LaunchServices handlers, run `lsregister`, test file association through Finder, open Markdown documents as association tests, define install-location behavior, create release packages, create DMG/PKG artifacts, notarize, staple, introduce signing policy, configure iCloud containers, introduce Finder folder branding, or add document-browser behavior.

## Closure

Final status: FEIL 0 / AVVIK 0 / MERK 2 / Beslutning Klar med merknad

Initial publication: 2026-06-23  
Last modified: 2026-06-23
