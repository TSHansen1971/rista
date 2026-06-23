# RISTA-LAUNCHSERVICES-001C – First controlled default Markdown association observation

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-LAUNCHSERVICES-001C is closed as not ready with:

FEIL 0 / AVVIK 1 / MERK 0 / Decision: Not ready

## Purpose

This document records the first controlled observation of the current default Markdown file association behavior on this development host.

The verification opened a temporary Markdown file with:

`/usr/bin/open <temporary Markdown file>`

This was a plain default-handler observation.

It did not use `-a`, did not use `-b`, did not use Finder UI, did not use `lsregister`, and did not change the user's default Markdown handler.

## Baseline

The expected repository baseline was:

`c0e42b05aeeb8ee9f1e4f4ffff7a0e9c4e984aa1`

The local repository and `origin/main` matched the expected baseline before the verification.

## Preconditions

RISTA-WINDOW-001A had repaired the extra empty `Untitled` window during explicit Markdown document open.

RISTA-LAUNCHSERVICES-001B had verified bundle-id targeted Markdown document open.

RISTA-LAUNCHSERVICES-001C therefore observed the next boundary: current host default Markdown handler behavior.

## Test document

The temporary test document was created outside the repository:

`/tmp/rista-launchservices-001c-default-markdown-association-observation-20260623-235052/rista_launchservices_001c_default_test.md`

SHA-256:

`168f9eba9eafbb2b782b829ca5edb8e94aa669c34fdce9b738f3495769e587e2`

Size in bytes:

`211`

The test content was:

```markdown
# Rísta LAUNCHSERVICES 001C

Dette er en default-association observasjonstest.

Hvis Rísta er gjeldende default handler for Markdown på denne maskinen, åpnes denne filen i Rísta uten ekstra Untitled-vindu.
```

## Command used

The document was opened with:

`/usr/bin/open /tmp/rista-launchservices-001c-default-markdown-association-observation-20260623-235052/rista_launchservices_001c_default_test.md`

The following were explicitly not used:

- `-a`
- `-b`
- Finder UI launch
- `lsregister`
- default-handler modification
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

## Observed failure

The command failed before Rísta was started.

The observed LaunchServices error was:

`_LSOpenURLsWithCompletionHandler() failed with error -10669`

No default-handler modification was attempted.

No `lsregister` command was run.

No Finder UI test was run.

## Deviation

AVVIK 1:

Plain `open <file.md>` failed with LaunchServices error `-10669` for the controlled temporary Markdown file.

This means current default Markdown association behavior is not approved.

This is not a regression in the explicit document-open path. The explicit app-bundle and bundle-id targeted document-open paths have already been verified.

## Boundary decision

Default Markdown file association is not ready.

Rísta must not proceed to broad Finder double-click or release-level default association claims before a separate decision gate defines whether and how default handler association should be requested, observed, repaired or left to the user.

## Next required narrow track

The next required track is:

RISTA-LAUNCHSERVICES-001D – decision gate for default Markdown handler strategy after plain open failure

That gate should decide whether Rísta should:

1. keep default handler behavior user-controlled and document this as expected,
2. introduce a development-only instruction for manually choosing Rísta as default editor,
3. later support release packaging that makes default association possible without force,
4. continue without default association testing until signing/release packaging is defined.

That next gate must not introduce `lsregister`, Finder double-click behavior, DMG, PKG, notarization, signing-policy, entitlements or iCloud/document-container configuration.

## Negative confirmations

This verification did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
- `lsregister`
- default-handler modification
- Finder double-click test
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

## Final classification

RISTA-LAUNCHSERVICES-001C is a useful failed boundary observation.

The correct status is:

FEIL 0 / AVVIK 1 / MERK 0 / Decision: Not ready
