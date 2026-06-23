# RISTA-001 – Architecture

## Technical foundation

The project shall evolve from a Swift Package-based starter into a multi-platform Apple app foundation:

- `RistaApp`: platform-specific app entry points and user interface adaptation for macOS 26+, iPad and iPhone
- `RistaCore`: document model, Markdown normalization and basic block parsing
- `RistaCoreTests`: unit tests for core behavior

## Editor choice

The Mac writing surface may use `NSTextView` bridged into SwiftUI. iPad and iPhone require a separate platform-appropriate editor strategy.

This is intentional. A serious Markdown editor normally needs stronger text editing control than a basic SwiftUI `TextEditor` can provide, especially for future work such as stable scrolling, selection behavior, syntax treatment, large documents and editor-specific affordances. The shared editor model must therefore be separated from platform-specific text view implementations.

## Preview choice

The first preview implementation is deliberately local and simple. It parses basic Markdown blocks and renders them through SwiftUI views.

This keeps the first MVP dependency-light, inspectable and easy to reason about.

## File model

The primary document model is an ordinary text file. Rísta should not require a proprietary project format, database layer or hidden document container for normal Markdown editing.

## Future architecture decisions

Future support for full CommonMark, tables, footnotes, math, diagrams, syntax highlighting or advanced export should be introduced through separate, explicit decisions.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
