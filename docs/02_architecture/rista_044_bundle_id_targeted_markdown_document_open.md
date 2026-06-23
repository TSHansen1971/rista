# RISTA-LAUNCHSERVICES-001B – Bundle-id targeted Markdown document open

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-LAUNCHSERVICES-001B is closed with:

FEIL 0 / AVVIK 0 / MERK 2 / Decision: Ready with note

## Purpose

This document records the first controlled LaunchServices-near Markdown document open verification using Rísta's bundle identifier.

The verification opened a temporary Markdown file with:

`/usr/bin/open -F -b no.tostha.rista <temporary Markdown file>`

This was not a default file association test. The test did not use `open <file.md>` without specifying a bundle identifier.

## Baseline

The expected repository baseline was:

`a4b74a597b1faf08b440c13d27e2d398759317fa`

The local repository and `origin/main` matched the expected baseline before the verification.

## Preconditions

RISTA-WINDOW-001A had repaired the extra empty `Untitled` window during explicit Markdown document open.

RISTA-LAUNCHSERVICES-001B therefore tested the next narrower boundary: LaunchServices-resolved document open by bundle identifier, still without default Markdown association or Finder double-click behavior.

## Test document

The temporary test document was created outside the repository:

`/tmp/rista-launchservices-001b-bundle-id-targeted-markdown-document-open-20260623-234807/rista_launchservices_001b_test.md`

SHA-256:

`92cfcbd39528964c5e46133f09ca056314a7938c75bc2a82ad711edb01cf07e4`

Size in bytes:

`180`

The test content was:

```markdown
# Rísta LAUNCHSERVICES 001B

Dette er en bundle-id-målrettet Markdown-test.

Hvis testen virker, åpner Rísta denne filen via bundle identifier uten ekstra tomt Untitled-vindu.
```

## Verified app placement

The installed development app was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The app bundle metadata was verified before launch:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`

The app bundle was verified with `codesign --verify --deep --strict`.

No entitlements were observed on the installed development app.

## Launch method

The document was opened with:

`/usr/bin/open -F -b no.tostha.rista /tmp/rista-launchservices-001b-bundle-id-targeted-markdown-document-open-20260623-234807/rista_launchservices_001b_test.md`

The following were explicitly not used:

- Finder UI launch
- `lsregister`
- default `open <file.md>` file association path
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

## Process and socket verification

The run established a clean preflight with no existing `Rista` process.

After bundle-id targeted document open, exactly one `Rista` process was observed.

The launched process had zero IP sockets after document open.

The app was stopped after visual verification, and no `Rista` process remained after cleanup.

## Manual visual verification

The user accepted the run with the marker:

`RISTA_LS001B_BUNDLE_ID_DOCOPEN_VISUAL_OK`

The accepted visual condition was:

- Rísta opened the temporary Markdown test file through bundle-id targeting
- the title `Rísta LAUNCHSERVICES 001B` was visible
- the test body text was visible
- no extra empty `Untitled` window was visible
- no default file association path was exercised

## Boundary decision

Rísta can now open a deliberately selected Markdown file when LaunchServices is given Rísta's bundle identifier.

This does not yet approve:

- default Markdown file association
- Finder double-click behavior
- `open <file.md>` without `-b no.tostha.rista` or `-a Rista.app`
- `lsregister`
- release packaging
- notarization
- signing policy
- iCloud/document-container behavior

## Next allowed narrow track

The next efficient narrow track is a decision gate for observing default Markdown file association behavior without changing the user's default editor.

That gate must explicitly decide whether a temporary `.md` file may be opened with plain `open <file.md>`, and how to classify the result if macOS routes the file to an existing default editor other than Rísta.

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
- default Markdown file association test
- Finder double-click test
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

MERK 2: This verification used bundle identifier targeting. Default LaunchServices association for Markdown remains a separate boundary.
