# RISTA-LAUNCHSERVICES-001A – Markdown file association metadata contract

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Purpose

This document closes a narrow decision gate for the Markdown file association metadata already present in the generated macOS app bundle metadata surface.

The purpose is not to perform LaunchServices registration, not to test Finder behaviour, and not to introduce release or install packaging. The purpose is to decide whether the existing `Info.plist` document-type and UTI metadata should be treated as an intentional MVP metadata contract for Rísta.

## Baseline

The gate started from the green baseline after `RISTA-BUNDLE-001F-REPAIR001`:

```text
2b81a41be1f229518623f0ffffdbbcee39554685
```

That baseline had already established that active LaunchServices, release packaging, install-location behaviour, Finder branding and iCloud/document-container behaviour should not be combined in one broad implementation step.

## Passive metadata observed

The macOS metadata template and the regenerated app bundle both contain an existing Markdown document metadata contract:

```text
CFBundleDocumentTypes
LSHandlerRank
LSItemContentTypes
UTImportedTypeDeclarations
net.daringfireball.markdown
public.plain-text
md
markdown
text/markdown
text/x-markdown
```

The generated `Info.plist` was verified at:

```text
/Users/tostha/prosjekter/rista/.build/rista-macos-app/Rista.app/Contents/Info.plist
```

The generated values were verified as:

```text
CFBundleIdentifier: no.tostha.rista
CFBundleName:       Rísta
CFBundleExecutable: Rista
CFBundleTypeName:   Markdown Document
CFBundleTypeRole:   Editor
LSHandlerRank:      Owner
LSItemContentTypes: net.daringfireball.markdown / public.plain-text
UTTypeIdentifier:   net.daringfireball.markdown
Extensions:         md / markdown
MIME types:         text/markdown / text/x-markdown
```

## Decision

Rísta shall keep the existing Markdown document-type and UTI metadata as a passive MVP metadata contract for the generated macOS app bundle.

This decision does not mean that Rísta has completed user-facing file association behaviour. It only means that the metadata currently emitted into the generated `.app` is accepted as intentional, bounded and documented.

The next implementation work shall not expand this into a broad LaunchServices, Finder, packaging and iCloud track. Active user-facing file association behaviour shall wait until the release/install packaging boundary is explicitly defined.

## Allowed next step

The next efficient step is:

```text
RISTA-PACKAGING-001A – decision gate for local install and release packaging boundary
```

That gate should decide how a locally generated `.app` may be installed, moved, signed, packaged or otherwise prepared for user-facing LaunchServices behaviour.

## Deferred work

The following remain deferred and require explicit later gates:

- `lsregister` or any active LaunchServices registration.
- Finder or `open` based file association testing.
- Setting Rísta as a default app for Markdown files.
- DMG creation.
- PKG creation.
- Notarization.
- Stapling.
- Signing policy beyond the existing ad-hoc verification build.
- Entitlements files.
- iCloud or document-container configuration.
- Finder folder branding.
- Document browser implementation.
- iPad or iPhone implementation.
- Export, WYSIWYG, preview repair or table rendering repair.

## Risk lock

Before active file association testing is allowed, the project must decide:

1. whether Rísta is tested from `.build/rista-macos-app/Rista.app`, from `/Applications`, or from another local install location;
2. whether ad-hoc signing remains sufficient for local verification;
3. whether a release bundle, DMG, PKG or notarized app is in scope;
4. whether user-facing file association tests are allowed before a release packaging policy exists;
5. how to avoid polluting the developer machine's LaunchServices database during early experiments.

## Negative confirmation

This gate introduced no product patch, no `Package.swift` change, no `Sources` change, no `Resources` change, no metadata-template change, no tool change, no build-tool change, no `lsregister`, no Finder or `open` file association test, no install-location behaviour, no release packaging, no DMG, no PKG, no notarization, no stapling, no signing-policy change, no entitlements file, no iCloud container configuration, no Finder folder branding, no document browser implementation, no RistaTouch, no new app target, no preview/rendering repair, no table-rendering repair, no WYSIWYG and no export feature.

## Status

```text
FEIL 0 / AVVIK 0 / MERK 0 / Beslutning Klar
```
