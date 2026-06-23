# Rísta — Generated app bundle verification repair: About copyright line break

This document records `RISTA-BUNDLE-001E-REPAIR001`.

The baseline commit before this repair was:

`3262fc0ac01673c8f2bf9647b62b0b591a33241b`

## Reason

The independent generated app bundle verification found a visual About-panel issue.

The generated app bundle metadata was technically valid, but the About panel displayed the Norwegian rights sentence on the same wrapped copyright paragraph.

The desired About-panel presentation is:

```text
Copyright © 2026 Tor-Ståle Hansen.
Alle rettigheter forbeholdes.
```

## Change

This repair updates the active Mac bundle metadata template:

- `metadata/apple/macos/RistaMacInfo.plist.template`

The `NSHumanReadableCopyright` value now contains an explicit newline between the copyright statement and the rights-reservation sentence.

## Boundary

This repair does not change:

- `Package.swift`
- `Sources`
- `Sources/RistaMac/Resources`
- `tools`

It does not introduce LaunchServices testing, file association behavior, iCloud configuration, Finder folder branding, entitlements, a manual Xcode project, a new app target, WYSIWYG behavior, or export behavior.

Generated `.app` and `.build` artifacts remain outside Git.

## Verification

The metadata template was validated as a plist before and after the change.

The local SwiftPM build succeeded.

The automated test suite was run and confirmed as 13 XCTest tests with 0 failures.

The committed app bundle build tool materialized a fresh generated app bundle:

- `.build/rista-macos-app/Rista.app`

The generated `Contents/Info.plist` was validated.

The generated `NSHumanReadableCopyright` value was verified to contain two lines.

The generated app bundle was code-sign verified.

No `com.apple` entitlements were present.

A manual visual verification confirmed that the About panel displays the copyright statement and Norwegian rights sentence on separate lines, without duplicated version/build or duplicated copyright/credits output.

## Result

The generated app bundle verification path remains valid after the About copyright presentation repair.

The recommended next task is to rerun the independent generated app bundle verification or proceed to a decision gate before LaunchServices/file-association, install-location, release packaging, or Finder/iCloud behavior.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
