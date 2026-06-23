# Rísta 038 – Local install and release packaging boundary decision gate

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Scope

This document closes RISTA-PACKAGING-001A.

The purpose of this gate is to define the boundary before any active local install behavior, release packaging, Finder-based file-association verification, LaunchServices registration test, DMG creation, PKG creation, notarization, stapling, signing-policy work, entitlement work, iCloud document-container configuration, or document-browser behavior is introduced.

This is a documentation and verification gate only.

## Baseline

The expected starting baseline was:

`d97d5c8d28ed02db6e477c81d89eb1ba0d6d870d`

The final baseline before this document is committed was verified on local `main` and `origin/main`.

The immediately preceding bundle and LaunchServices-related documentation is:

- `docs/02_architecture/rista_036_decision_gate_before_launchservices_file_association_or_release_packaging.md`
- `docs/02_architecture/rista_037_markdown_file_association_metadata_contract.md`

## Verified surfaces

The following surfaces were verified as present:

- `metadata/apple/macos/RistaMacInfo.plist.template`
- `tools/build_macos_app_bundle.zsh`
- `tools/build_local.zsh`
- `tools/test_local.zsh`

The existing Markdown document-type and UTI metadata remain a passive bundle metadata contract. This gate does not alter that contract.

## Build and test verification

Local build was executed through:

`tools/build_local.zsh`

Local tests were executed through:

`tools/test_local.zsh`

The generated macOS app bundle was materialized for verification through:

`tools/build_macos_app_bundle.zsh`

The generated app bundle path was:

`.build/rista-macos-app/Rista.app`

The generated `Info.plist` was validated.

The generated app identity was observed as:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundleShortVersionString`: `0.1`

No entitlements were observed on the generated app during this gate.

## Boundary decision

Rísta shall not move directly from passive Markdown file-association metadata to active Finder or LaunchServices behavior without first defining the install and packaging boundary.

The next effective track is therefore:

`RISTA-PACKAGING-001B – minimal local app placement/install behavior decision or implementation gate`

That next gate may decide whether Rísta should first support a narrow, local, developer-controlled app placement flow, for example copying or placing the generated app bundle into a controlled local location for manual visual inspection.

This gate does not approve release packaging.

## Explicitly deferred tracks

The following tracks remain deferred:

- active `lsregister`
- Finder/open file-association test
- double-click Markdown file opening behavior
- default editor registration
- DMG creation
- PKG creation
- notarization
- stapling
- distribution signing policy
- entitlements file
- iCloud document container configuration
- document browser behavior
- Finder folder branding
- App Store packaging
- TestFlight or iOS/iPadOS packaging
- RistaTouch
- WYSIWYG
- export features
- rendering repair
- table rendering repair

## Risk notes

The main technical risk is that passive `Info.plist` document metadata may not represent real user-visible file-association behavior until the app bundle is placed in a location and state where LaunchServices can observe it.

A second risk is that testing file association too early may create noisy local LaunchServices state that is hard to distinguish from intentional product behavior.

A third risk is that release packaging decisions may introduce signing, entitlement, notarization, install-location and file-association assumptions too early unless each track is explicitly gated.

## Decision

Decision: Klar med merknad.

Rísta is ready for a narrow local install/app-placement boundary gate.

Rísta is not yet approved for release packaging, notarization, DMG/PKG creation, active LaunchServices registration, Finder/open file-association testing, iCloud document-container behavior, or iOS/iPadOS packaging.

## Negative confirmations

This gate introduced no product patch.

This gate introduced no change to `Package.swift`.

This gate introduced no change to `Sources`.

This gate introduced no change to `Resources`.

This gate introduced no change to `metadata`.

This gate introduced no change to `tools`.

This gate introduced no new build tool.

This gate introduced no app target.

This gate introduced no Xcode project or manually maintained workspace.

This gate introduced no LaunchServices registration.

This gate introduced no `lsregister` invocation.

This gate introduced no Finder/open file-association test.

This gate introduced no install-location behavior.

This gate introduced no release package.

This gate introduced no DMG.

This gate introduced no PKG.

This gate introduced no notarization.

This gate introduced no stapling.

This gate introduced no signing policy.

This gate introduced no entitlements file.

This gate introduced no iCloud document container configuration.

This gate introduced no Finder branding.

This gate introduced no document browser.

This gate introduced no RistaTouch.

This gate introduced no iPad or iPhone implementation.

This gate introduced no preview/rendering repair.

This gate introduced no table rendering repair.

This gate introduced no WYSIWYG behavior.

This gate introduced no export feature.
