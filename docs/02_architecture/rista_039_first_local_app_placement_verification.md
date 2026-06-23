# Rísta 039 — First Local App Placement Verification

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Decision status

RISTA-INSTALL-001A is closed as:

FEIL 0 / AVVIK 0 / MERK 1 / Beslutning Klar med merknad

This document records the first controlled local app placement verification for Rísta.

The verification is intentionally narrow. It does not create a release package, does not install a system-wide application, does not register LaunchServices, and does not test Markdown file association through Finder or `open`.

## Baseline

The controlled baseline was:

`575fdbfadf9f8448426fa7f714a52dac6d354300`

The branch was `main`.

The expected remote was:

`git@github.com:TSHansen1971/rista.git`

The preceding gates were already closed:

- Rísta 036 — decision gate before LaunchServices/file association or release packaging
- Rísta 037 — Markdown file association metadata contract
- Rísta 038 — local install and release packaging boundary

## Scope

This verification was limited to:

- confirming clean repository state
- confirming local HEAD and `origin/main`
- building and testing the project
- materializing the generated macOS app bundle
- verifying the generated `Info.plist`
- copying the generated app bundle into a controlled user-local development placement
- verifying the copied app bundle
- documenting the result

## Local placement

The controlled user-local app placement was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

This path is a development placement only.

It is not treated as:

- a release install location
- a system-wide `/Applications` install
- a signed release artifact
- a notarized app
- a DMG
- a PKG
- a LaunchServices registration step

## Observed app identity

The generated and copied app bundle kept the expected identity:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`
- `CFBundleShortVersionString`: `0.1`

The copied app bundle was verified with `codesign --verify --deep --strict`.

No entitlements were observed on the generated or copied app bundle.

## Explicitly not performed

The following actions were not performed:

- no product patch
- no metadata change
- no tool change
- no build-tool change
- no `Package.swift` change
- no `Sources` change
- no `Resources` change
- no new app target
- no new Xcode project
- no new workspace
- no `lsregister`
- no `open` test
- no Finder file association test
- no Markdown document open test
- no DMG
- no PKG
- no notarization
- no stapling
- no Developer ID signing policy
- no entitlements file
- no sandbox policy change
- no iCloud container configuration
- no document browser implementation
- no iPad or iPhone implementation
- no RistaTouch implementation

## Decision

The first controlled user-local app placement is accepted as a development-only verification step.

The next efficient track may be one of:

1. a narrow launch verification of the locally placed development app, without Markdown file association testing
2. a decision gate for release artifact strategy, still without creating DMG/PKG/notarization
3. a controlled LaunchServices registration/test gate, but only after explicitly deciding whether that should be tested against the generated app or the user-local placed app

The preferred next track is a narrow launch verification of the locally placed development app before any file association test.

## Risk lock

The following risks remain locked:

- LaunchServices may behave differently for generated app bundles, user-local placements, and release-installed apps.
- Finder file association should not be tested until the intended app placement has been chosen.
- Release packaging should not be introduced as a side effect of local development placement.
- Signing, notarization, sandboxing and entitlements must remain separate decision tracks.

## MERK

MERK 1, if present, concerns `.swiftpm/xcode/package.xcworkspace`.

This is treated as local SwiftPM package tooling, not as a manually introduced app workspace.
