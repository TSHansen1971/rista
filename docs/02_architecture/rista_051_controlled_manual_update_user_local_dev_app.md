# RISTA-INSTALL-001B – Controlled manual update of user-local development app

Initial publication: 2026-06-24
Last modified: 2026-06-24

## Status

RISTA-INSTALL-001B is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task establishes a controlled manual update procedure for the user-local Rísta development app placement.

The update target is:

`/Users/tostha/Applications/Rista-dev/Rista.app`

This is a local development placement, not a release install.

## Baseline

The expected repository baseline was:

`5da5c6854f2ff12809ab77657c820b49460f3e54`

The local repository and `origin/main` matched the expected baseline before the update task.

## Source app bundle

The source app bundle was materialized from the repository using the existing build tool:

`tools/build_macos_app_bundle.zsh`

The generated source app bundle was:

`.build/rista-macos-app/Rista.app`

The generated bundle identity was:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`
- `CFBundleVersion`: `1`

The generated app passed codesign verification and had no entitlements.

## Update procedure

The update procedure was:

1. ensure no existing `Rista` process was running
2. build and test the repository
3. materialize the generated app bundle
4. verify the generated app bundle
5. copy the generated app bundle to a staged install path under `/Users/tostha/Applications/Rista-dev`
6. verify the staged app bundle
7. remove the previous user-local development app if present
8. move the staged app bundle into final position
9. verify the installed app bundle
10. verify that Rísta was not launched during the update

## Installed app bundle

The installed user-local development app is:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The installed bundle identity was verified:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`
- `CFBundleVersion`: `1`

The installed app passed codesign verification and had no entitlements.

## Verification

The task verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- expected install, packaging, archive and version-policy documents
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- local build
- local tests
- app bundle materialization
- generated app metadata
- generated app codesign
- no generated app entitlements
- staged install app metadata
- staged install app codesign
- no staged install app entitlements
- final installed app metadata
- final installed app codesign
- no final installed app entitlements
- no `Rista` process after update

No app was launched.

No document was opened.

No Finder test was run.

No `lsregister` command was run.

## Boundary decision

The user-local development app can now be updated by a controlled manual replacement procedure.

This does not establish:

- release install
- DMG
- PKG
- notarization
- Developer ID signing policy
- App Store packaging
- entitlements
- iCloud/document-container behavior
- Finder double-click behavior
- default Markdown handler changes

## Next allowed narrow track

The next allowed track is one of:

1. a controlled app launch verification after manual update;
2. a controlled explicit document-open verification after manual update;
3. a documentation gate for whether developer-only archives should later be attached to GitHub Releases;
4. a product/UI task unrelated to packaging.

The safest next packaging-adjacent task is a controlled app launch verification after the manual update.

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

MERK 1: This is a development install/update procedure only. It is not a release install procedure.
