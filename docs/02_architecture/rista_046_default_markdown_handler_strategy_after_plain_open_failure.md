# RISTA-LAUNCHSERVICES-001D – Default Markdown handler strategy after plain open failure

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-LAUNCHSERVICES-001D is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This decision gate defines Rísta's strategy after the first controlled default Markdown association observation failed.

RISTA-LAUNCHSERVICES-001C observed that:

`/usr/bin/open <temporary Markdown file>`

failed with LaunchServices error `-10669`.

That failure occurred without using `-a`, without using `-b`, without using Finder UI, without using `lsregister`, and without modifying the user's default Markdown handler.

## Baseline

The expected repository baseline was:

`e4019b5532652ffbe3c8192eba9c3010d83cd989`

The local repository and `origin/main` matched the expected baseline before this decision gate.

## Established prior results

The following prior boundaries are accepted:

1. User-local development app placement is verified.
2. Direct executable launch is verified.
3. Controlled app-bundle launch through `/usr/bin/open -F <Rista.app>` is verified.
4. Explicit Markdown document open through `/usr/bin/open -F -a <Rista.app> <file.md>` is verified after the window lifecycle repair.
5. Bundle-identifier targeted Markdown document open through `/usr/bin/open -F -b no.tostha.rista <file.md>` is verified.
6. Plain default-handler open through `/usr/bin/open <file.md>` is not ready.

## Decision

Rísta will not attempt to force, rewrite or self-register default Markdown handler behavior at this stage.

Default Markdown association remains user-controlled and packaging-dependent.

The current project will treat plain `open <file.md>` failure as a LaunchServices/default-handler boundary, not as a regression in explicit document opening.

Rísta may continue development using explicit app-bundle or bundle-identifier document-open flows.

## Strategy

The strategy is:

1. Preserve the verified explicit document-open paths.
2. Do not use `lsregister` in the project workflow.
3. Do not modify the user's default Markdown handler automatically.
4. Do not claim default `.md` association support until release/install packaging is defined.
5. Treat Finder double-click and plain `open <file.md>` as later release-packaging or user-choice behavior, not as an immediate product repair.
6. Prefer release/install packaging boundary work before further default association claims.

## Not selected

The following alternatives are explicitly not selected in this gate:

- automatically registering Rísta as the default Markdown handler
- adding `lsregister` to the workflow
- forcing LaunchServices database refresh
- changing the user's default editor
- treating error `-10669` as a product-source failure
- adding entitlements
- adding iCloud/document-container behavior
- adding DMG/PKG/notarization/signing-policy work in this task
- broad Finder double-click testing

## Next allowed narrow track

The next efficient narrow track is:

RISTA-PACKAGING-001B – decision gate for development-release packaging strategy after verified app placement and explicit document open

That gate should decide whether the next step is:

1. a developer-only zip/archive of the existing generated app,
2. a documented manual install/update procedure for the user-local development app,
3. a future DMG/PKG/notarization path,
4. or continued deferral of release packaging until more app behavior is complete.

RISTA-PACKAGING-001B must not create a DMG, PKG, notarization workflow, signing-policy, entitlements file or iCloud/document-container configuration unless a later implementation task explicitly allows it.

## Default handler policy

The project default handler policy is:

Rísta should support Markdown document opening when explicitly selected, but should not seize default Markdown ownership.

The user's default editor must remain under user control.

If a future release wants to make Rísta a common Markdown handler, that must be done through normal macOS app packaging and user consent, not through hidden registration scripts.

## Verification in this gate

This decision gate verified:

- local repository baseline
- `origin/main` baseline
- clean Git status
- presence of the relevant prior LaunchServices/window lifecycle documents
- absence of active forbidden implementation signals in `Package.swift`, `Sources`, `Resources`, `metadata`, and `tools`
- local build
- local tests

No app was launched in this gate.

No document was opened in this gate.

## Negative confirmations

This decision gate did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
- app launch
- document open
- Finder UI test
- `lsregister`
- default-handler modification
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

## Note

MERK 1: `.swiftpm/xcode/package.xcworkspace` remains treated as local SwiftPM package tooling, not as a manually introduced app workspace.
