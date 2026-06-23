# RISTA-005 – First Mac Surface Split

## Decision

Rísta has taken the first controlled technical step toward the selected Apple-platform target model.

The former starter app surface has been renamed from `RistaApp` to `RistaMac`.

## Reason

Rísta is no longer treated as a macOS-only app with possible mobile ports later. The documented product model is:

- `RistaCore` as shared core
- `RistaMac` as macOS 26+ app surface
- `RistaTouch` as future iPad/iPhone app surface

This step makes the existing Mac surface explicit without introducing the touch surface prematurely.

## Technical change

This step changed the starter structure from:

~~~text
Sources/RistaApp
~~~

to:

~~~text
Sources/RistaMac
~~~

The executable target reference in `Package.swift` was updated from `RistaApp` to `RistaMac`.

The app entry source file now lives at:

~~~text
Sources/RistaMac/RistaMacApp.swift
~~~

The app entry type was normalized to `RistaMacApplication`.

## Preserved boundaries

This step did not introduce:

- `RistaTouch`
- new Xcode project
- new Xcode workspace
- App Store configuration
- signing changes
- sandbox changes
- bundle identifier changes
- document type registration
- iCloud support
- export implementation
- new product behavior

## Verification

Baseline before change:

~~~text
HEAD: fc7093a9489452dbb14e471451b3e650f52b943a
~~~

After the split:

- local build succeeded
- local tests succeeded
- `RistaCore` tests remained unchanged
- no `Sources/RistaApp` directory remained
- `Sources/RistaMac` existed
- no `RistaApp` references remained in active code, Package.swift, tests or tools

## Next gate

The next gate should be:

RISTA-APPSTRUCT-001E – inspect RistaMac split and decide whether to introduce a placeholder RistaTouch target or defer touch implementation until editor strategy is defined.

The preferred next step is likely to define the touch editor strategy before adding a real `RistaTouch` target.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
