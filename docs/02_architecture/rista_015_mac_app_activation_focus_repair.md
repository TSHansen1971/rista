# RISTA-015 - Mac App Activation and Editor Focus Repair

## Decision

Rista repaired the first Mac app activation and editor focus issue.

The repair is limited to Mac app activation, standard text command registration and editor first responder focus.

## Reason

Earlier visual testing showed that the Rista window could be visible and mouse/context-menu actions could work, while keyboard input and command shortcuts still went to the Terminal window used to launch the app.

That meant the issue was broader than simple NSTextView key handling.

## Technical change

This step changed:

~~~text
Sources/RistaMac/RistaMacApp.swift
Sources/RistaMac/MarkdownTextView.swift
~~~

RistaMacApp now uses a small Mac-only application delegate to set regular activation policy, activate the current running application, bring app windows forward, preserve SwiftUI DocumentGroup behavior, and register standard text editing and formatting commands.

MarkdownTextView now uses a small NSTextView subclass only for first responder ownership.

It does not override keyDown, performKeyEquivalent, insertText or insertNewline.

## Repair002 adjustment

Repair002 removes the deprecated activateIgnoringOtherApps activation option and uses activateAllWindows only.

The build is required to be warning-free before commit.

## Preserved behavior

The repair preserves normal NSTextView text input rather than replacing it.

The editor still uses NSTextView through NSViewRepresentable.

The preview flow remains unchanged.

Known Markdown rendering limitations, such as incomplete table rendering, are outside this repair scope.

## Verification

Baseline before repair:

~~~text
HEAD: b533c6115e0e5464ed68f1dfe8c4be2aa00621a0
~~~

After the repair:

- local build succeeded without warnings
- local tests succeeded
- manual visual verification succeeded
- Rista could receive keyboard input as the active app
- regular text input worked
- Spacebar worked
- Enter/line break worked
- Command+A worked
- Command+C worked
- Command+V worked
- Command+X worked
- delete/backspace worked
- right-click paste still worked
- preview still updated

## Boundaries

This repair did not introduce:

- Package.swift changes
- RistaCore changes
- RistaMacEditorModel changes
- editor-state binding changes
- RistaTouch
- file moves
- new Xcode project
- new Xcode workspace
- new app targets
- document model changes
- preview model changes
- export implementation
- WYSIWYG behavior
- App Store configuration

## Evidence location

Local repair evidence was written to:

~~~text
/tmp/rista-editor-input-001d-repair002-finish-20260623-164123
~~~

## Next gate

The next gate should be:

~~~text
RISTA-EDITOR-INPUT-001E - baseline after Mac app activation and editor focus repair
~~~

After that baseline is green, Rista may return to the editor-state binding track.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
