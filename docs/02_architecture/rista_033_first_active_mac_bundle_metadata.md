# Rísta — First active Mac bundle metadata implementation

This document records `RISTA-BUNDLE-001D`, the first active Mac app bundle metadata implementation.

The baseline commit before this task was:

`7f9d283b323650443b7cc96dee9a6a106d32c336`

## Scope

This task introduces a narrow build tool that materializes a local `.app` bundle from the existing SwiftPM build output.

It does not introduce a manual Xcode project, entitlements, iCloud containers, Finder folder branding, LaunchServices file association testing, WYSIWYG behavior, export behavior, or generated app artifacts in Git.

## Implementation

This task adds:

- `tools/build_macos_app_bundle.zsh`

The tool builds the SwiftPM executable product and materializes:

- `.build/rista-macos-app/Rista.app`

The generated app bundle contains:

- `Contents/MacOS/Rista`
- `Contents/Info.plist`
- `Contents/Resources/RistaAppIcon.icns`
- the SwiftPM `Rista_RistaMac.resources` resource bundle

The active `Contents/Info.plist` is copied from:

- `metadata/apple/macos/RistaMacInfo.plist.template`

## About metadata deduplication

When running as a generated `.app`, AppKit reads version/build/copyright metadata from `Contents/Info.plist`.

The previous About implementation also supplied manual version and credits options. That produced duplicate About output.

This task wraps the existing About options in `RistaMacApp.swift` so that:

- real `.app` runs remove manual version/credits About options and use active bundle metadata
- SwiftPM development runs keep the existing manual fallback values

## Active metadata

The generated app bundle has active metadata values including:

- bundle identifier: `no.tostha.rista`
- bundle name/display name: `Rísta`
- executable: `Rista`
- short version: `0.1`
- build: `1`
- icon file: `RistaAppIcon`
- development region: `en`
- human-readable copyright

`CFBundleVersion = 1` is verified from the generated active `Contents/Info.plist`.

## Boundary

This task changes only:

- `tools/build_macos_app_bundle.zsh`
- `Sources/RistaMac/RistaMacApp.swift`
- this documentation file

It does not change:

- `Package.swift`
- `Sources/RistaCore`
- `Sources/RistaMac/Resources`
- `metadata`

## Verification

The metadata template was validated as a plist.

The local SwiftPM build succeeded.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

The app bundle build tool materialized `.build/rista-macos-app/Rista.app`.

The generated `Contents/Info.plist` was validated and inspected.

The generated app bundle was ad-hoc signed without an entitlements file.

The generated app bundle was launched directly from `Contents/MacOS/Rista` with `-ApplePersistenceIgnoreState YES`.

A manual visual pass confirmed that the generated app starts cleanly with one Rísta process, app icon/About identity remains correct, About no longer shows duplicated version/build or duplicated copyright/credits, Rísta-owned UI language is still correct, and editor/preview/edited-status behavior still works.

Product files were verified unchanged outside the allowed files after build, tests, app bundle materialization, and visual check.

## Result

`RISTA-BUNDLE-001D` introduces the first active Mac app bundle metadata surface for Rísta through a controlled generated `.app` bundle.

The recommended next task is a narrow independent verification of the generated app bundle behavior.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
