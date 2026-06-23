# RISTA-PACKAGING-001B – Development-release packaging strategy

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-PACKAGING-001B is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This decision gate defines the next packaging strategy after Rísta has verified:

1. generated macOS app bundle metadata
2. user-local development app placement
3. direct executable launch
4. controlled app-bundle launch through `open -F`
5. explicit Markdown document open through app-bundle targeting
6. bundle-identifier targeted Markdown document open
7. default Markdown handler strategy after plain `open <file.md>` failure

This is a decision gate only.

It does not create a release package.

## Baseline

The expected repository baseline was:

`7ccc7d734a9ed9ddb010eb51c3d2ff56a631366c`

The local repository and `origin/main` matched the expected baseline before this decision gate.

## Current known packaging state

Rísta currently has a generated macOS app bundle path:

`.build/rista-macos-app/Rista.app`

Rísta also has a controlled user-local development placement:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The current generated app has the expected bundle identity:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`

The generated app is ad-hoc signed and has no entitlements.

## Decision

The next packaging track is a developer-only archive boundary, not a release package.

The selected next narrow track is:

RISTA-PACKAGING-001C – first developer-only app archive of the generated macOS app bundle

That future task may create a local developer-only archive of the generated `.app`, but it must not claim release packaging.

## Packaging strategy

The strategy is:

1. Keep `/Users/tostha/Applications/Rista-dev/Rista.app` as the local development install placement.
2. Keep `.build/rista-macos-app/Rista.app` as the generated build artifact.
3. Allow a later developer-only archive step for transport or snapshot purposes.
4. Do not introduce DMG, PKG, notarization, signing-policy or entitlements yet.
5. Do not use packaging to force Markdown default handler ownership.
6. Keep default Markdown handler behavior user-controlled and packaging-dependent.
7. Treat Finder double-click and default `open <file.md>` as later release-level behavior, not as an immediate development packaging requirement.

## Developer-only archive definition

A developer-only archive, if later allowed, means a local archive of the already generated app bundle for controlled development transfer or snapshot.

It is not:

- a public release
- a notarized artifact
- a signed distribution package
- a DMG
- a PKG
- an installer
- a default-handler registration mechanism
- a Finder branding mechanism
- an iCloud/document-container mechanism

## Not selected

The following alternatives are explicitly not selected now:

- DMG packaging
- PKG packaging
- notarization workflow
- Developer ID signing-policy work
- App Store packaging
- entitlements file
- iCloud document container
- Finder folder branding
- automatic Markdown default handler registration
- `lsregister`
- broad Finder double-click testing
- release notes or versioning policy beyond current bundle metadata

## Verification in this gate

This gate verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- presence of the relevant prior install, document-open and LaunchServices strategy documents
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- `.build` is not Git-tracked
- local build
- local tests
- materialization of the existing app bundle for verification only
- valid generated `Info.plist`
- expected bundle identity
- no entitlements on the generated app
- no Git-tracked release/archive artifacts

No app was launched.

No document was opened.

No archive was created.

## Next allowed narrow track

The next allowed track is:

RISTA-PACKAGING-001C – first developer-only app archive of generated macOS app bundle

That implementation must be narrow.

It may create a local archive under a controlled output directory, but it must not:

- create DMG
- create PKG
- run notarization
- introduce Developer ID signing policy
- introduce entitlements
- change bundle metadata
- change source code
- change resources
- change build tools unless explicitly approved
- use `lsregister`
- change default Markdown handler
- run Finder double-click tests
- introduce iCloud/document-container behavior

## Negative confirmations

This decision gate did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
- app launch
- document open
- Finder UI test
- `lsregister`
- default-handler modification
- archive creation
- DMG
- PKG
- notarization
- signing-policy
- entitlements file
- iCloud/document-container configuration
- iPad/iPhone implementation
- preview/rendering repair
- WYSIWYG
- export functionality

## Note

MERK 1: `.swiftpm/xcode/package.xcworkspace` remains treated as local SwiftPM package tooling, not as a manually introduced app workspace.
