# RISTA-RUN-001B – Controlled app launch after manual development app update

Initial publication: 2026-06-24
Last modified: 2026-06-24

## Status

RISTA-RUN-001B is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task verifies controlled app launch after RISTA-INSTALL-001B updated the user-local development app.

The launched app was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The launch method was:

`/usr/bin/open -F /Users/tostha/Applications/Rista-dev/Rista.app`

No document was opened.

## Baseline

The expected repository baseline was:

`d619a4b9a13b360824dd95ea1bfb346ebfa7d9bb`

The local repository and `origin/main` matched the expected baseline before launch verification.

## Installed app bundle

The installed development app bundle identity was verified before launch:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`
- `CFBundleVersion`: `1`

The installed app passed codesign verification and had no entitlements.

## Launch verification

The launch used:

`/usr/bin/open -F /Users/tostha/Applications/Rista-dev/Rista.app`

The following were explicitly not used:

- Finder UI launch
- document open
- `lsregister`
- default Markdown handler modification
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

Exactly one `Rista` process was observed after launch.

The launched process had zero IP sockets.

## Manual visual verification

The user accepted the run with the marker:

`RISTA_RUN001B_AFTER_UPDATE_VISUAL_OK`

The accepted visual condition was:

- the Rísta window was visible
- the app appeared as the expected Rísta development app
- no extra unexpected empty windows were visible
- no document file opened automatically

## Stop verification

The app was stopped after visual verification.

No `Rista` process remained after cleanup.

## Boundary decision

Controlled app launch after manual user-local development app update is approved.

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

## Verification

The task verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- expected prior launch and install documents
- installed app metadata
- installed app codesign
- no installed app entitlements
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- controlled app launch through `open -F`
- exactly one `Rista` process
- zero IP sockets after launch
- manual visual verification
- clean app stop

No product code was changed.

No metadata was changed.

No document was opened.

## Next allowed narrow track

The next allowed track is one of:

1. controlled explicit Markdown document-open verification after manual update;
2. a product/UI task unrelated to packaging;
3. a documentation gate for GitHub Releases use of developer-only archives.

The safest next packaging-adjacent task is controlled explicit Markdown document-open verification after the manual update.

## Negative confirmations

This task did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
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

MERK 1: This is a development app launch verification only. It is not a release install or release launch verification.
