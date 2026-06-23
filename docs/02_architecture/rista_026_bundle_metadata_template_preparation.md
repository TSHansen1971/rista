# Rísta — Bundle metadata template preparation

This document records `RISTA-BUNDLE-001B`, a narrow preparation step for future macOS app bundle and document type metadata.

The baseline commit before this task was:

`152166184986c058170daa4da3882183b55d9af1`

## Scope

This task adds a non-active macOS bundle metadata template.

It does not wire the template into the current SwiftPM build.

It does not create an Xcode project, app target, entitlement file, iCloud container, Finder folder branding surface, App Store configuration, or active LaunchServices registration.

## Added metadata template

This task adds:

- `metadata/apple/macos/RistaMacInfo.plist.template`

The file records intended future metadata for:

- bundle display name: `Rísta`
- bundle name: `Rísta`
- executable name: `Rista`
- bundle identifier: `no.tostha.rista`
- short version: `0.1`
- build version: `1`
- app icon file: `RistaAppIcon`
- document role: editor
- Markdown document type handling
- `.md` and `.markdown` file extensions
- Markdown MIME hints

The template imports `net.daringfireball.markdown` and treats Markdown as conforming to plain text.

## Non-active status

The template is intentionally not active.

It is not referenced by `Package.swift`.

It is not installed into a built `.app` bundle.

It is not LaunchServices-registered.

It is not an entitlement file.

It is not an iCloud configuration.

It is not a Finder folder branding configuration.

A later controlled implementation step must explicitly decide how this template becomes active metadata.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources`
- `Sources/RistaMac/Resources`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, WYSIWYG behavior, export behavior, App Store configuration, preview rendering repair, table rendering repair, iCloud configuration, or Finder folder branding.

## Verification

The template was validated with `/usr/bin/plutil -lint`.

The template was read with Python `plistlib`, and required keys were checked.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the current SwiftPM runtime baseline still starts and that app icon/About identity, editor input, preview updates, and edited/dirty status still work.

## Result

`RISTA-BUNDLE-001B` establishes a reviewed, versioned, non-active metadata template for the future macOS app bundle/document type step.

The recommended next task is a controlled decision or implementation step that decides whether and how to make this metadata active in an actual macOS app bundle.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
