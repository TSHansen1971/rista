# RISTA-DOCOPEN-001B – Explicit Markdown document open after manual development app update

Initial publication: 2026-06-24
Last modified: 2026-06-24

## Status

RISTA-DOCOPEN-001B is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task verifies explicit Markdown document opening after RISTA-INSTALL-001B updated the user-local development app and RISTA-RUN-001B verified controlled app launch.

The installed app was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The explicit document open method was:

`/usr/bin/open -F -a /Users/tostha/Applications/Rista-dev/Rista.app <temporary Markdown file>`

This is not a default file association test.

## Baseline

The expected repository baseline was:

`f3b0229c7ecc306b3de7b40c1de8b5df11b4006b`

The local repository and `origin/main` matched the expected baseline before document-open verification.

## Installed app bundle

The installed development app bundle identity was verified before document open:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`
- `CFBundleVersion`: `1`

The installed app passed codesign verification and had no entitlements.

## Test document

The temporary test document was created outside the repository:

`/tmp/rista-docopen-001b-explicit-markdown-open-after-manual-update-20260624-001411/rista_docopen_001b_after_update.md`

SHA-256:

`2703d448c31b017837cc743eb539b03a7b21d4fdb0fd657df87519e40e347817`

Size in bytes:

`199`

The test content was:

```markdown
# Rísta DOCOPEN 001B

Dette er en eksplisitt dokumentåpningstest etter manuell dev-app update.

Hvis testen virker, skal bare dette dokumentvinduet vises i Rísta, uten ekstra tomt Untitled-vindu.
```

## Launch verification

The document was opened with:

`/usr/bin/open -F -a /Users/tostha/Applications/Rista-dev/Rista.app /tmp/rista-docopen-001b-explicit-markdown-open-after-manual-update-20260624-001411/rista_docopen_001b_after_update.md`

The following were explicitly not used:

- plain `open <file.md>`
- Finder UI launch
- `lsregister`
- default Markdown handler modification
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

Exactly one `Rista` process was observed after document open.

The launched process had zero IP sockets.

## Manual visual verification

The user accepted the run with the marker:

`RISTA_DOCOPEN001B_AFTER_UPDATE_VISUAL_OK`

The accepted visual condition was:

- the title `Rísta DOCOPEN 001B` was visible
- the test text was visible in the editor and preview
- no extra empty `Untitled` window was visible
- no other app opened the test file

## Stop verification

The app was stopped after visual verification.

No `Rista` process remained after cleanup.

## Boundary decision

Explicit Markdown document opening after manual user-local development app update is approved.

This does not establish:

- default file association
- Finder double-click behavior
- release install
- DMG
- PKG
- notarization
- Developer ID signing policy
- App Store packaging
- entitlements
- iCloud/document-container behavior

## Verification

The task verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- expected prior window, LaunchServices, install and launch documents
- installed app metadata
- installed app codesign
- no installed app entitlements
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- controlled explicit Markdown document open through `open -F -a`
- exactly one `Rista` process
- zero IP sockets after document open
- manual visual verification
- clean app stop

No product code was changed.

No metadata was changed.

## Next allowed narrow track

The next allowed track is one of:

1. a product/UI task unrelated to packaging;
2. a documentation gate for GitHub Releases use of developer-only archives;
3. a decision gate for whether to defer all further packaging work until the editor feature set is richer.

The safest next step is likely to return to product/editor functionality rather than continue packaging, because the development app placement, launch, explicit document open and developer archive path are now controlled.

## Negative confirmations

This task did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
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

MERK 1: This is explicit document-open verification only. It is not default file association or release install verification.
