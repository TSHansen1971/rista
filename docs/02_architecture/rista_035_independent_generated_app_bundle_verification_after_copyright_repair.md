# Rísta — Independent generated app bundle verification after copyright repair

This document records `RISTA-BUNDLE-001E-RERUN001`, an independent rerun of the generated Mac app bundle verification after `RISTA-BUNDLE-001E-REPAIR001`.

The baseline commit before this task was:

`d7d973acdc6f96102f77bbffc8dfbb5652ff3170`

## Scope

This task verifies the generated Mac app bundle path again after the About copyright presentation repair.

It does not modify source code.

It does not modify package configuration.

It does not modify metadata templates.

It does not modify build tools.

It does not commit generated `.app` bundles or `.build` artifacts.

It does not test LaunchServices file association behavior.

It does not introduce an entitlements file, iCloud configuration, Finder folder branding, WYSIWYG behavior, or export behavior.

## Verification

The repository was verified to be on the expected `RISTA-BUNDLE-001E-REPAIR001` baseline.

The repository was clean before verification.

The committed build tool `tools/build_macos_app_bundle.zsh` was used to materialize a fresh generated app bundle:

- `.build/rista-macos-app/Rista.app`

The generated app bundle contained:

- `Contents/MacOS/Rista`
- `Contents/Info.plist`
- `Contents/Resources/RistaAppIcon.icns`
- the SwiftPM `Rista_RistaMac` resource bundle

The generated `Contents/Info.plist` was validated and inspected.

The active bundle metadata included:

- bundle identifier: `no.tostha.rista`
- bundle name/display name: `Rísta`
- executable: `Rista`
- short version: `0.1`
- build: `1`
- icon file: `RistaAppIcon`
- development region: `en`
- human-readable copyright with an explicit line break

The copyright value was verified as:

```text
Copyright © 2026 Tor-Ståle Hansen.
Alle rettigheter forbeholdes.
```

The local build succeeded.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

The generated app bundle was code-sign verified.

No `com.apple` entitlements were present.

The generated `.app` artifact remained outside Git tracking.

A manual visual verification confirmed that the generated app starts cleanly, only one new Rísta document window is visible, the app icon is correct, the About panel has no duplicated version/build output, the About panel displays the copyright statement and Norwegian rights sentence on separate lines, Rísta-owned UI language remains correct, and editor/preview/edited-status behavior still works.

## Boundary

This task changes only this documentation file.

The following areas were verified unchanged:

- `Package.swift`
- `Sources`
- `metadata`
- `tools`

## Result

`RISTA-BUNDLE-001E-RERUN001` confirms the generated Mac app bundle path after the About copyright presentation repair.

The recommended next task is a decision gate before LaunchServices/file-association behavior, install-location behavior, release packaging, or iCloud/Finder branding work.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
