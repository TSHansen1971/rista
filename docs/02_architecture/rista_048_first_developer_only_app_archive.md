# RISTA-PACKAGING-001C – First developer-only app archive

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-PACKAGING-001C is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task creates the first developer-only archive of the generated Rísta macOS app bundle.

The archive is a local development artifact only.

It is not a public release package.

## Baseline

The expected repository baseline was:

`794afe7b40664edb87fb0a7274a56eea2eadd2a3`

The local repository and `origin/main` matched the expected baseline before the archive task.

## Source app bundle

The source app bundle was:

`.build/rista-macos-app/Rista.app`

The app bundle was materialized using the existing build tool:

`tools/build_macos_app_bundle.zsh`

The app bundle identity was verified:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`

The generated app passed codesign verification and had no entitlements.

## Archive

The developer-only archive was created outside the repository:

`/Users/tostha/Downloads/rista-dev-archives/Rista-dev-0.1-794afe7b4066-20260623-235943.zip`

SHA-256:

`4b7f1b7903af506ce6171f69ff74102c8f906ee8a14a43004b0969130206788c`

Size in bytes:

`4564587`

The archive was created with `ditto -c -k --keepParent`.

## Archive verification

The archive listing was verified to contain:

- `Rista.app/Contents/Info.plist`
- `Rista.app/Contents/MacOS/Rista`

The archive was extracted to the task run directory and the extracted app was verified.

The extracted app bundle identity matched the generated app bundle.

The extracted app passed codesign verification and had no entitlements.

## Boundary decision

This task establishes that a local developer-only archive of the generated Rísta macOS app bundle can be created and verified.

This does not establish a release packaging process.

This does not approve:

- DMG
- PKG
- notarization
- Developer ID signing policy
- App Store packaging
- entitlements
- iCloud/document-container behavior
- Finder double-click behavior
- default Markdown handler changes

## Verification

The task verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- expected strategy document
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- `.build` is not Git-tracked
- no Git-tracked release/archive artifacts existed before the task
- local build
- local tests
- generated app materialization
- generated app metadata
- generated app codesign
- no generated app entitlements
- archive creation outside the repository
- archive SHA-256
- archive structure
- extraction into the run directory
- extracted app metadata
- extracted app codesign
- no extracted app entitlements

No app was launched.

No document was opened.

No Finder test was run.

No `lsregister` command was run.

## Next allowed narrow track

The next allowed narrow track is one of:

1. a controlled documentation gate for version/build numbering policy before any wider packaging;
2. a controlled manual-install/update procedure for the user-local development app;
3. a decision gate for whether a developer-only archive should be attached to GitHub Releases later.

None of those should introduce DMG, PKG, notarization, signing-policy, entitlements or iCloud behavior without a separate explicit gate.

## Negative confirmations

This task did not introduce:

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

MERK 1: The archive is local and developer-only. It is not committed to Git and is not a release artifact.
