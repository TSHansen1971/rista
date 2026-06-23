# RISTA-RUN-001A-REPAIR005 – First local dev app executable launch with clean saved-window-state

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-RUN-001A-REPAIR005 is closed with:

FEIL 0 / AVVIK 0 / MERK 2 / Decision: Ready with note

## Purpose

This document records the first accepted controlled launch verification of the user-local Rísta development app placement after RISTA-INSTALL-001A.

The verification deliberately used the app bundle executable directly:

`/Users/tostha/Applications/Rista-dev/Rista.app/Contents/MacOS/Rista`

It did not use Finder, `open`, LaunchServices registration, `lsregister`, file association testing, DMG, PKG, notarization, signing-policy work or iCloud/document-container configuration.

## Baseline

The expected repository baseline was:

`b92968983e2df33c5a0c8e072fbf09bf0ba29717`

The local repository and `origin/main` matched the expected baseline before the verification.

## Repair background

The first RUN-001A attempt was visually rejected because the desktop showed a double app/window startup state. That attempt was not accepted as green.

RISTA-RUN-001A-REPAIR001 stopped due to a script-side PATH handling defect.

RISTA-RUN-001A-REPAIR002 stopped due to a script-side zsh issue: the readonly shell parameter `status` was used as a local variable in the helper function.

RISTA-RUN-001A-REPAIR003 stopped due to an overbroad forbidden-surface grep that searched historical architecture documentation and interpreted negative or deferred iCloud mentions as active implementation signals.

RISTA-RUN-001A-REPAIR004 was visually rejected because multiple windows were still visible after launch, consistent with saved-window-state or window restoration behavior rather than multiple process launch.

RISTA-RUN-001A-REPAIR005 established a clean macOS saved-window-state surface for this verification and launched the installed development app directly through the executable with `-ApplePersistenceIgnoreState YES`.

## Verified app placement

The verified app was:

`/Users/tostha/Applications/Rista-dev/Rista.app`

The executable was:

`/Users/tostha/Applications/Rista-dev/Rista.app/Contents/MacOS/Rista`

The app bundle metadata was verified before launch:

- `CFBundleIdentifier`: `no.tostha.rista`
- `CFBundleName`: `Rísta`
- `CFBundleExecutable`: `Rista`
- `CFBundlePackageType`: `APPL`

The app bundle was verified with `codesign --verify --deep --strict`.

No entitlements were observed on the installed development app.

## Saved-window-state control

For this verification, relevant macOS saved-window-state directories for the Rísta bundle identity were backed up to the run directory if present and then removed before launch.

Saved-window-state removed: `0`

This was a user-local runtime-state cleanup for the launch verification. It was not a product source change, metadata change, tool change, package change, signing change or app-bundle change.

## Launch method

The app was launched directly via:

`/Users/tostha/Applications/Rista-dev/Rista.app/Contents/MacOS/Rista -ApplePersistenceIgnoreState YES`

The following were explicitly not used:

- Finder
- `open`
- `lsregister`
- file association test
- Markdown document open test
- DMG
- PKG
- notarization
- signing-policy workflow
- iCloud/document-container configuration

## Process and socket verification

The repair run established a clean preflight with no existing `Rista` process.

After direct executable launch, exactly one `Rista` process was observed.

The launched process had zero IP sockets after startup.

The app was stopped after visual verification, and no `Rista` process remained after cleanup.

## Manual visual verification

The user accepted the run with the marker:

`RISTA_RUN001A_REPAIR005_VISUAL_OK`

The accepted visual condition was:

- exactly one Rísta development app/window from this run
- no double app/window startup
- no document opened through Finder or `open`
- no file association path exercised

## Boundary decision

The local development app can be launched directly from its installed user-local development placement when launched from a clean saved-window-state surface.

This does not yet approve Finder launch, LaunchServices behavior, file association behavior, release packaging, notarization, signing policy or iCloud/document-container behavior.

## Product observation

The previous visual double-window observations should not be ignored. They suggest that Rísta may need an explicit future decision about default window restoration behavior, single-window development launch behavior or document-window lifecycle before broader Finder/open launch testing.

That future decision should be handled as a separate narrow task if the behavior recurs under normal app launch.

## Next allowed narrow track

The next efficient narrow track is a decision gate for controlled Finder/open launch of the already placed development app, still without Markdown file association testing.

That next step should decide whether `open /Users/tostha/Applications/Rista-dev/Rista.app` is allowed as an app-launch verification only, with explicit prohibition against opening `.md` files or invoking `lsregister`.

## Negative confirmations

This repair did not introduce:

- product code changes
- metadata-template changes
- build-tool changes
- source changes
- resource changes
- new app target
- new Xcode project/workspace
- Finder launch approval
- `open` launch approval
- `lsregister`
- Markdown file association test
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

## Notes

MERK 1: `.swiftpm/xcode/package.xcworkspace` remains treated as local SwiftPM package tooling, not as a manually introduced app workspace.

MERK 2: The accepted verification required saved-window-state cleanup and `-ApplePersistenceIgnoreState YES`. This is acceptable for direct executable development verification, but normal Finder/open launch behavior is not yet approved.
