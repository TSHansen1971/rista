# Rísta — Active bundle metadata gate

This document records `RISTA-BUNDLE-001C`, a gate before activating Mac app bundle metadata.

The baseline commit before this task was:

`682aac54e1fadcf0c2b414a4cb76dbd7edafde8f`

## Scope

This is a gate only.

It does not activate `Info.plist`.

It does not register LaunchServices document types.

It does not introduce entitlements, iCloud containers, Finder folder branding, file association behavior, App Store configuration, a manual Xcode project, or a new app target.

## Current prepared ground

The following prerequisites are in place:

- app icon resources are present and optically repaired
- About/app information is visually acceptable
- a non-active Mac bundle metadata template exists
- Markdown document-type metadata has been drafted in the template
- English and Norwegian Bokmål localization resources exist
- controlled localization switching has been verified
- the current SwiftPM app still builds and tests successfully

## Metadata template

The current non-active template is:

`metadata/apple/macos/RistaMacInfo.plist.template`

The template declares:

- app display/name: `Rísta`
- bundle identifier: `no.tostha.rista`
- development region: `en`
- short version: `0.1`
- build: `1`
- icon file: `RistaAppIcon`
- Markdown document type as editor
- `.md` and `.markdown` extensions
- Markdown MIME types
- imported UTI declaration for `net.daringfireball.markdown`

## Active metadata remains intentionally absent

This gate confirms that active app bundle metadata is still not wired into the product.

There is no committed active `Info.plist`.

There is no committed entitlements file.

There is no active iCloud container configuration.

There is no active Finder folder branding.

There is no active file association implementation.

## Recommended next task

The next product task should be a narrowly controlled active bundle metadata implementation.

That task should decide the least invasive way to materialize an actual `.app` bundle metadata surface from the existing template without introducing iCloud, entitlements, Finder branding, App Store configuration, or broad project restructuring.

The next task should likely be:

`RISTA-BUNDLE-001D — first active Mac bundle metadata implementation`

It should include:

- a specific activation mechanism
- no iCloud container
- no entitlements
- no Finder folder branding
- no file association behavior beyond what can be verified safely
- build/test verification
- visual About/app identity verification
- explicit rollback behavior if active metadata changes runtime identity unexpectedly

## Product-code boundary

This task changes only this documentation file.

It does not change:

- `Package.swift`
- `Sources`
- `Sources/RistaMac/Resources`
- `metadata`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, active bundle metadata, LaunchServices registration, entitlements, iCloud configuration, Finder folder branding, preview rendering repair, table rendering repair, WYSIWYG behavior, or export behavior.

## Verification

The metadata template was validated as a plist.

The expected template keys and Markdown document metadata were inspected.

The app icon, localization, `DocumentGroup`, `FileDocument`, and `.md` document anchors were inspected.

The absence of active `Info.plist`, entitlements, and iCloud configuration was confirmed.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the app starts and the current runtime baseline remains intact.

Product files were verified unchanged after build, tests, and visual check.

## Result

`RISTA-BUNDLE-001C` confirms that Rísta is ready for a narrowly controlled active bundle metadata implementation step, but does not activate it.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
