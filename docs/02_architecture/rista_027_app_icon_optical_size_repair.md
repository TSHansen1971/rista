# Rísta — App icon optical size repair

This document records `RISTA-APPICON-002A`, a narrow visual repair of the Mac app icon's optical size.

The baseline commit before this task was:

`534a4306ed3c756e8468661c80cb168d8eefb98a`

## Scope

This task changes only app icon resources.

It does not change product source code, package configuration, bundle metadata templates, entitlements, iCloud configuration, Finder folder branding, document type registration, preview rendering, table rendering, WYSIWYG behavior, export behavior, or App Store configuration.

## Reason

After the bundle metadata preparation step, the current Rísta app icon was visually compared against other Dock icons.

The icon was judged to be optically too large/heavy relative to neighboring macOS app icons.

## Implementation

The existing 1024 px app icon source was used as the visual source.

The visible icon was optically inset by drawing the existing icon at scale `0.86` inside a transparent 1024 px canvas.

The following resources were regenerated from the adjusted 1024 px source:

- `Sources/RistaMac/Resources/AppIconSource/rista_app_icon_1024.png`
- `Sources/RistaMac/Resources/Assets.xcassets/AppIcon.appiconset`
- `Sources/RistaMac/Resources/RistaAppIcon.icns`

The icon motif, color direction, and Rísta rune symbol were preserved.

## Product-code boundary

This task does not change:

- `Package.swift`
- `Sources` outside `Sources/RistaMac/Resources`
- `metadata`

It does not introduce `RistaTouch`, a new manual Xcode project, a new app target, active bundle metadata, LaunchServices registration, entitlements, iCloud configuration, Finder folder branding, preview rendering repair, table rendering repair, WYSIWYG behavior, or export behavior.

## Verification

The adjusted source icon was verified as 1024 × 1024 px.

The app icon set and `.icns` file were regenerated.

The app was built successfully.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

A manual visual pass confirmed that the app starts, the Dock icon has a better optical size relative to other app icons, the About icon still appears correctly, and editor/preview/edited-status behavior still works.

## Result

`RISTA-APPICON-002A` repairs the Mac app icon's optical scale while preserving the existing app icon concept.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
