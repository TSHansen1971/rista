# RISTA-003 – Toolchain and Xcode Intelligence Policy

## Decision

Rísta shall use Xcode 27 beta as the active local development toolchain on the current macOS 27 developer beta host.

ChatGPT in Xcode may be enabled for explanation, navigation and review, but it shall be treated as read-only project assistance unless a later explicit project decision allows a broader mode.

## Reason

The current development machine runs macOS 27 developer beta, and the previous Xcode 26 toolchain is not usable for this local development environment.

Rísta also has a documented platform direction toward macOS 26 and newer, iPad and iPhone. Xcode 27 beta provides the current SDK surface needed for development on this host.

## Current observed toolchain

    xcode-select: /Applications/Xcode-beta.app/Contents/Developer
    xcodebuild: Xcode 27.0 Build version 27A5209h
    swift: Apple Swift version 6.4 (swiftlang-6.4.0.23.5 clang-2100.3.23.3)

## Current observed Xcode baseline

On 2026-06-23, Rísta was opened from /Users/tostha/prosjekter/rista/Package.swift.

The project was opened as an existing Swift Package, not as a new parallel Xcode project.

The first Xcode GUI build succeeded.

The first terminal build and test check also succeeded:

    ./tools/build_local.zsh
    ./tools/test_local.zsh

The test baseline executed 2 XCTest tests with 0 failures.

## Xcode Intelligence policy

The following is allowed:

- ChatGPT in Xcode for explanation
- ChatGPT in Xcode for code reading
- ChatGPT in Xcode for high-level review
- ChatGPT in Xcode for navigation and architectural discussion

The following is not allowed without a later explicit project decision:

- agentic file editing
- autonomous code generation directly into the repository
- external agent access to Xcode tools
- Model Context Protocol access for external agents
- Codex Agent, Claude Agent or Gemini Agent as project-writing agents
- build, test or Git operations initiated by an agent

## Practical rule

Prompts to ChatGPT in Xcode should include a constraint such as:

    Do not modify files.

or:

    Review only. Do not make code changes.

## Repository rule

Toolchain-dependent behavior shall be documented before product code is changed.

The project shall avoid accidental dependency on beta-only APIs unless such dependency is explicitly accepted in a separate implementation decision.

## Platform relation

This policy supports the current platform target policy:

- macOS 26 and newer
- iPad
- iPhone

## Non-goals for this policy step

This policy step does not introduce:

- product code changes
- Xcode project restructuring
- new app targets
- App Store configuration
- signing changes
- sandbox changes
- export implementation
- external agent write access

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
