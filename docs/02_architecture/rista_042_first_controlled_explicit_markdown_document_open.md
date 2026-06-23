# RISTA-DOCOPEN-001A – First controlled explicit Markdown document open

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-DOCOPEN-001A is closed as not ready with:

FEIL 0 / AVVIK 1 / MERK 0 / Decision: Not ready

## Purpose

This document records the first controlled explicit Markdown document open verification for the user-local Rísta development app.

The verification used an explicit app-bundle-directed open command:

`/usr/bin/open -F -a /Users/tostha/Applications/Rista-dev/Rista.app <temporary Markdown file>`

This was not a default file association test. The test did not use `open <file.md>` without specifying Rísta.

## Baseline

The expected repository baseline was:

`ffa2b752ec500abef4106b8651de0de0502032e4`

The local repository and `origin/main` matched the expected baseline before the verification.

## Preconditions

RISTA-INSTALL-001A had verified user-local development app placement.

RISTA-RUN-001A-REPAIR005 had verified direct executable launch.

RISTA-OPEN-001A had verified controlled app-bundle launch through `/usr/bin/open -F`.

RISTA-DOCOPEN-001A therefore tested the next narrower boundary: opening a deliberately created temporary Markdown document with Rísta explicitly named as the target app.

## Test document

The temporary test document was created outside the repository:

`/tmp/rista-docopen-001a-first-controlled-explicit-markdown-document-open-20260623-233627/rista_docopen_001a_test.md`

SHA-256:

`5c8e2b62d15838d18d8cecd33fb4b4f61800900130d30c0771f97849b6ba190d`

Size in bytes:

`196`

The test content was:

```markdown
# Rísta DOCOPEN 001A

Dette er en kontrollert midlertidig Markdown-testfil.

Hvis Rísta åpner denne filen korrekt, skal denne tittelen og teksten være synlig i editoren og forhåndsvisningen.
```

## Command used

The document was opened with:

`/usr/bin/open -F -a /Users/tostha/Applications/Rista-dev/Rista.app /tmp/rista-docopen-001a-first-controlled-explicit-markdown-document-open-20260623-233627/rista_docopen_001a_test.md`

The following were explicitly not used:

- Finder UI launch
- `lsregister`
- default `open <file.md>` file association path
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

## Passing observations

The run confirmed:

- local repository matched expected baseline
- `origin/main` matched expected baseline
- installed app bundle existed
- `Info.plist` was valid
- `CFBundleIdentifier` was `no.tostha.rista`
- `CFBundleName` was `Rísta`
- `CFBundleExecutable` was `Rista`
- `CFBundlePackageType` was `APPL`
- codesign verification passed
- no entitlements were observed on the installed development app
- no active forbidden implementation signals were found in active surfaces
- the temporary Markdown test file was created outside the repository
- exactly one `Rista` process was observed after explicit document open
- zero IP sockets were observed after document open

## Visual result

The user explicitly rejected the visual verification with:

`RISTA_DOCOPEN001A_CONTENT_VISUAL_NOT_OK`

The visual observation was:

- the Markdown file did load in a foreground Rísta window
- the title `Rísta DOCOPEN 001A` was visible
- the test body text was visible in editor/preview
- an additional empty `Untitled` Rísta window was also created behind the document window

## Deviation

AVVIK 1:

Rísta opens the explicitly selected Markdown document, but also creates an extra empty `Untitled` window during the same document-open flow.

This means explicit Markdown document open is partially functional, but the app/window lifecycle is not yet correct.

The failure is not a LaunchServices default-association failure. It is a window lifecycle failure in the document-open path.

## Boundary decision

Explicit Markdown document open is not approved yet.

The next task must repair or gate the extra-window lifecycle behavior before any default Markdown file association test, Finder double-click test, `lsregister` work, release packaging, notarization, signing policy or iCloud/document-container behavior.

## Next required narrow track

The next required narrow track is:

RISTA-WINDOW-001A – prevent extra untitled window when opening an explicit Markdown document

That task should be a narrow app/window lifecycle repair.

It should not change bundle metadata, packaging, LaunchServices registration, default file association, Finder behavior, iCloud behavior, preview rendering, WYSIWYG behavior or export behavior.

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

## Final classification

RISTA-DOCOPEN-001A is a useful failed boundary test.

The content-loading portion passed visually.

The window lifecycle portion failed visually.

The correct status is therefore:

FEIL 0 / AVVIK 1 / MERK 0 / Decision: Not ready
