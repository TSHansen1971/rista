# RISTA-014 – Mac App Activation, Focus and Command Routing Diagnosis

## Decision

Rísta shall not continue with editor-state binding or another NSTextView-only repair before Mac app activation, keyboard focus and command routing have been clarified.

The failed RISTA-EDITOR-INPUT-001B repair attempt showed that the problem is broader than simple key handling inside NSTextView.

## Background

RISTA-EDITOR-INPUT-001A documented that the editor surface did not behave as a complete Mac text editor.

RISTA-EDITOR-INPUT-001B attempted a narrow NSTextView subclass repair, but manual visual verification was not accepted. The repair attempt was reverted and not committed.

## Manual observation from the failed repair attempt

During visual testing:

- the Rísta app window opened
- the editor and preview were visible
- mouse selection worked
- right-click context menu worked
- right-click text commands were visible
- preview updated after content was entered
- keyboard manipulation was not accepted
- keyboard input and command shortcuts were observed going to the Terminal window used to launch the app

This indicates that the defect is likely related to app activation, focus, responder chain, command routing or launch mode.

## Important distinction

Mouse and context-menu behavior working does not prove that the app owns keyboard focus.

The key failure is that the active keyboard target may remain Terminal even while the Rísta window is visible.

Therefore, another direct NSTextView.keyDown repair is not sufficient without first ensuring that the app is a properly activated foreground Mac app and that the editor becomes first responder.

## Source findings

The current app entry is:

~~~text
Sources/RistaMac/RistaMacApp.swift
~~~

The current editor bridge is:

~~~text
Sources/RistaMac/MarkdownTextView.swift
~~~

The current app uses SwiftUI DocumentGroup and currently declares SidebarCommands.

The editor bridge uses NSTextView through NSViewRepresentable.

## Launch-mode concern

Rísta is currently being launched during manual smoke testing with:

~~~text
swift run Rista
~~~

That launch mode is useful during early Swift Package development, but it may not represent a normal app bundle launch with normal foreground activation, menu bar ownership and command routing.

The next repair should explicitly distinguish:

- SwiftPM executable launch behavior
- Xcode Run behavior
- proper Mac app bundle launch behavior
- foreground app activation
- first responder ownership
- standard text command routing

## Required next repair

The next repair should be:

~~~text
RISTA-EDITOR-INPUT-001D – repair Mac app activation and standard editor command routing
~~~

That repair may modify:

~~~text
Sources/RistaMac/RistaMacApp.swift
Sources/RistaMac/MarkdownTextView.swift
~~~

It may add a small Mac-only app delegate or activation helper if needed, but must remain narrowly scoped to Mac app activation, focus and standard text editing command routing.

## Boundaries

This diagnosis does not introduce:

- product code changes
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

## Verification

Baseline:

~~~text
HEAD: 9d888e5ba7086d0941c3b7ab974b6a958170aec1
~~~

This diagnosis verified:

- local Git status was clean at start
- local build succeeded
- local tests succeeded
- no product files were changed
- the reverted RistaMarkdownNSTextView repair subclass was not present
- RistaTouch was not introduced

## Evidence location

Local diagnosis evidence was written to:

~~~text
/tmp/rista-editor-input-001c-simple-20260623-153344
~~~

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
