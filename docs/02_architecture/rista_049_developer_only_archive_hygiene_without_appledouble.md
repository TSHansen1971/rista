# RISTA-PACKAGING-001D – Developer-only archive hygiene without AppleDouble entries

Initial publication: 2026-06-24
Last modified: 2026-06-24

## Status

RISTA-PACKAGING-001D is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task creates a cleaner developer-only archive of the generated Rísta macOS app bundle.

RISTA-PACKAGING-001C successfully created the first developer-only archive, but its archive listing contained AppleDouble `._*` entries.

RISTA-PACKAGING-001D therefore verifies a cleaner archive method that excludes AppleDouble and `__MACOSX` entries.

This remains a developer-only archive.

It is not a release package.

## Baseline

The expected repository baseline was:

`44cd0e2be814abea12b547f2cf33a10050e3fb0b`

The local repository and `origin/main` matched the expected baseline before the archive-hygiene task.

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

The hygienic developer-only archive was created outside the repository:

`/Users/tostha/Downloads/rista-dev-archives/Rista-dev-0.1-44cd0e2be814-clean-20260624-000248.zip`

SHA-256:

`eb97833b9fbb2e36696616ce15b99a0f135c43e0189579956afb3cd738c2cfa8`

Size in bytes:

`4556829`

The archive was created with:

`COPYFILE_DISABLE=1 ditto -c -k --norsrc --keepParent Rista.app <archive.zip>`

## Archive verification

The archive listing was verified to contain:

- `Rista.app/Contents/Info.plist`
- `Rista.app/Contents/MacOS/Rista`

The archive listing was also verified to contain no:

- AppleDouble `._*` entries
- `__MACOSX` entries

The archive was extracted to the task run directory and the extracted app was verified.

The extracted app bundle identity matched the generated app bundle.

The extracted app passed codesign verification and had no entitlements.

## Boundary decision

The cleaner archive method is approved for developer-only app archive snapshots.

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
- expected strategy and first archive documents
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
- absence of AppleDouble/`__MACOSX` entries
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

1. a documentation gate for version/build numbering policy before wider packaging;
2. a controlled manual-install/update procedure for the user-local development app;
3. a decision gate for whether developer-only archives should later be attached to GitHub Releases.

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
