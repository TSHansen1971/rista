# RISTA-OPEN-001A – Controlled app-bundle launch through open

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-OPEN-001A is closed with:

FEIL 0 / AVVIK 0 / MERK 2 / Decision: Ready with note

## Purpose

This document records the first controlled app-bundle launch verification of the user-local Rísta development app through `/usr/bin/open`.

The verification opened the already placed development app bundle:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The command used was:

`/usr/bin/open -F /Users/tostha/Applications/Rista-dev/Rista.app`

This was an app-bundle launch verification only.

It was not a Markdown file association test, not a document open test, not `lsregister`, not release packaging, not notarization, not signing-policy work and not iCloud/document-container configuration.

## Baseline

The expected repository baseline was:

`bb35015411993dbbf56f18e966b8542a86060a23`

The local repository and `origin/main` matched the expected baseline before the verification.

## Precondition

RISTA-INSTALL-001A had already verified the user-local development app placement.

RISTA-RUN-001A-REPAIR005 had already verified direct executable launch from a clean saved-window-state surface.

RISTA-OPEN-001A therefore tested the next narrower boundary: app-bundle launch through `open`, still without opening any document path.

## Verified app placement

The verified app was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The app bundle metadata was verified before launch:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`

The app bundle was verified with `codesign --verify --deep --strict`.

No entitlements were observed on the installed development app.

## Launch method

The app was launched with:

`/usr/bin/open -F /Users/tostha/Applications/Rista-dev/Rista.app`

The `-F` option was used to request a fresh app launch without restoring prior windows.

The following were explicitly not used:

- Finder UI launch
- `lsregister`
- `.md` file path
- Markdown document open test
- file association test
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

## Process and socket verification

The run established a clean preflight with no existing `Rista` process.

After `open -F` app-bundle launch, exactly one `Rista` process was observed.

The launched process had zero IP sockets after startup.

The app was stopped after visual verification, and no `Rista` process remained after cleanup.

## Manual visual verification

The user accepted the run with the marker:

`RISTA_OPEN001A_VISUAL_OK`

The accepted visual condition was:

- Rísta opened through the app-bundle path
- exactly one Rísta window was visible from the run
- no `.md` file was opened
- no file association path was exercised

## Boundary decision

Controlled app-bundle launch through `/usr/bin/open -F` is now verified for the user-local development app placement.

This does not yet approve:

- Finder UI launch as a user-facing behavior
- Markdown file association
- opening `.md` files through Finder or `open`
- `lsregister`
- release packaging
- notarization
- signing policy
- iCloud/document-container behavior

## Next allowed narrow track

The next efficient narrow track is a decision gate for Markdown file association testing.

That gate should decide whether a deliberately created temporary `.md` file may be opened through the app bundle, and whether that test should use Finder UI, `/usr/bin/open`, or remain deferred until release packaging is defined.

## Negative confirmations

This verification did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
- `lsregister`
- Markdown file association test
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

## Notes

MERK 1: `.swiftpm/xcode/package.xcworkspace` remains treated as local SwiftPM package tooling, not as a manually introduced app workspace.

MERK 2: This verification used `open -F` for fresh app-bundle launch. Normal Finder UI behavior and Markdown file association behavior remain separate boundaries.
