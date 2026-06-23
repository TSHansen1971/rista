# RISTA-VERSION-001A – Version and build numbering policy

Initial publication: 2026-06-24
Last modified: 2026-06-24

## Status

RISTA-VERSION-001A is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This decision gate defines the first version and build numbering policy for Rísta before wider packaging work.

This is a decision gate only.

It does not change bundle metadata.

## Baseline

The expected repository baseline was:

`91fccdcb7931ff0516444d27c8021b74ccb3ee91`

The local repository and `origin/main` matched the expected baseline before this decision gate.

## Observed bundle identity

The generated app bundle was materialized for observation only:

`.build/rista-macos-app/Rista.app`

The observed bundle identity was:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`
- `CFBundleVersion`: `1`

The observed CFBundleVersion was `1`.

The generated app passed codesign verification and had no entitlements.

## Decision

Rísta will treat `CFBundleShortVersionString = 0.1` as the current early development version.

Rísta will not change version metadata as part of developer-only archive hygiene.

Developer-only archive names may continue to include:

1. short app version
2. short Git commit
3. timestamp
4. an explicit hygiene marker when relevant

Example pattern:

`Rista-dev-0.1-<short-head>-clean-<timestamp>.zip`

## Build number policy

Rísta does not yet require release-grade build numbering.

A future metadata task may refine CFBundleVersion rules, but this gate does not change metadata.

A future controlled metadata task may add or standardize `CFBundleVersion`.

Until then:

- Git commit is the authoritative build identity for developer artifacts.
- Archive timestamp is a local artifact discriminator.
- `CFBundleShortVersionString` remains the user-facing app version.
- Archive filenames must not imply notarized release status.

## Not selected

The following alternatives are explicitly not selected in this gate:

- changing `CFBundleShortVersionString`
- adding or changing `CFBundleVersion`
- introducing semantic version release policy beyond `0.1`
- creating release notes
- creating DMG
- creating PKG
- notarization workflow
- Developer ID signing policy
- App Store packaging
- entitlements file
- iCloud/document-container behavior
- default Markdown handler changes
- Finder double-click claims

## Verification in this gate

This gate verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- expected packaging documents and build surfaces
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- local build
- local tests
- app bundle materialization for observation
- generated `Info.plist`
- generated bundle identity
- generated `CFBundleShortVersionString`
- generated app codesign
- no generated app entitlements

No app was launched.

No document was opened.

No archive was created.

## Next allowed narrow track

The next allowed narrow track is one of:

1. RISTA-INSTALL-001B – controlled manual update procedure for the user-local development app;
2. RISTA-VERSION-001B – first controlled metadata task for `CFBundleVersion`, if build numbering should be materialized now;
3. a documentation gate for whether developer-only archives should later be attached to GitHub Releases.

The safer next step is likely RISTA-INSTALL-001B, because the current version identity is sufficient for local development artifacts.

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
