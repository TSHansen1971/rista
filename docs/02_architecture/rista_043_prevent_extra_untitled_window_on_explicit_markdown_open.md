# RISTA-WINDOW-001A – Prevent extra Untitled window when opening explicit Markdown document

Initial publication: 2026-06-23
Last modified: 2026-06-23

## Status

RISTA-WINDOW-001A is closed with:

FEIL 0 / AVVIK 0 / MERK 1 / Decision: Ready with note

## Purpose

This task repairs the app/window lifecycle issue recorded by RISTA-DOCOPEN-001A.

The prior boundary test showed that Rísta could load an explicitly opened Markdown document, but also created an additional empty `Untitled` window behind the document window.

## Baseline

The expected repository baseline was:

`c9a287843fd30e5069805908605b14f97d937407`

The local repository and `origin/main` matched the expected baseline before the repair.

## Scope

The only product file changed was:

`Sources/RistaMac/RistaMacApp.swift`

No bundle metadata, package configuration, resources, build tools, release packaging, signing policy, entitlements or iCloud configuration were changed.

## Root cause classification

The inspected lifecycle surface showed that Rísta uses SwiftUI `DocumentGroup(newDocument:)` and an `NSApplicationDelegate` that activated all windows after launch.

When an explicit Markdown document was opened, a real document window appeared, but an extra empty `Untitled` window was also visible.

The repair treats this as a document-window lifecycle issue, not as a default LaunchServices association issue.

## Repair

The application delegate now schedules a small window lifecycle normalization after launch.

The normalization keeps normal app launch behavior intact, but closes redundant visible, unedited `Untitled` windows when at least one non-untitled visible document window exists.

This preserves the ordinary empty new-document window when Rísta is launched without an opened document.

## Verification

The repair run verified:

- repository baseline matched the expected HEAD
- `origin/main` matched the expected HEAD
- only `Sources/RistaMac/RistaMacApp.swift` changed before documentation
- local build passed
- local tests passed
- generated app bundle materialized successfully
- generated `Info.plist` was valid
- generated bundle identity remained `no.tostha.rista`
- generated app had no entitlements
- updated app was installed to `/Users/tostha/Applications/Rista-dev/Rista.app`
- installed app passed codesign verification
- installed app had no entitlements
- explicit Markdown document open used `/usr/bin/open -F -a` with the installed app bundle
- no default file association path was used
- `lsregister` was not used
- exactly one `Rista` process was observed
- zero IP sockets were observed after document open
- manual visual verification passed

## Test document

The controlled test document was created outside the repository:

`/tmp/rista-window-001a-prevent-extra-untitled-window-20260623-234513/rista_window_001a_test.md`

SHA-256:

`6e3ff8e3c3e0c7841d2957c46be6762c73628d5a7caaedf82e39b74a4dace6c5`

Size in bytes:

`147`

The visible title was:

`Rísta WINDOW 001A`

## Manual visual verification

The user accepted the run with the marker:

`RISTA_WINDOW001A_VISUAL_OK`

The accepted visual condition was:

- the explicit Markdown test file opened
- the document text was visible in editor and preview
- no extra empty `Untitled` window was visible behind the document window

## Boundary decision

Explicit Markdown document open with Rísta as the explicitly selected app is now approved for the user-local development app placement.

This still does not approve:

- default Markdown file association
- Finder double-click behavior
- `open <file.md>` without explicitly selecting Rísta
- `lsregister`
- release packaging
- notarization
- signing policy
- iCloud/document-container behavior

## Negative confirmations

This repair did not introduce:

- Package.swift changes
- metadata-template changes
- resource changes
- build-tool changes
- new app target
- new Xcode project/workspace
- `lsregister`
- default Markdown file association test
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

## Note

MERK 1: The repair deliberately uses a conservative lifecycle normalization in the macOS app delegate. Normal Finder/default association behavior remains a separate boundary.
