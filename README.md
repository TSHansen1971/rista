# ᚼ Rísta

Rísta is an Apple Silicon-native macOS Markdown editor starter: write in plain text, see the document rendered live, and keep your work as ordinary open `.md` files.

The project is built around one principle: minimal distance between thought and text. Markdown is not treated as a toolbar-driven formatting layer, but as a direct writing method where small marks create visible structure.

This repository is a clean-room local development foundation. It does not copy code, icons, text, screenshots, layout details or other assets from Markdown Pro. It preserves only the general and widely used workflow pattern: keyboard-driven Markdown editing with side-by-side live preview.

## Product position

Apple Silicon-native macOS Markdown editor: plain text, live preview, PDF/HTML export.

## MVP contract

The first version is intentionally narrow:

- open, edit and save ordinary `.md` and plain text files
- editor on the left, live preview on the right
- basic Markdown rendering for headings, paragraphs, emphasis, lists, block quotes, code blocks and horizontal rules
- local document ownership
- no account
- no database
- no cloud sync
- no AI layer
- no proprietary document format

## Local development

Open the package directly in Xcode:

```zsh
cd ~/prosjekter/rista
open Package.swift
```

Build and test from Terminal:

```zsh
./tools/build_local.zsh
./tools/test_local.zsh
```

Run locally:

```zsh
./tools/run_local.zsh
```

## Repository language policy

Repository-facing and internationally reusable material should be written in English.

Old Norse or Norse-derived terms are used only where they are part of the name, brand concept or linguistic explanation. Norwegian is used only where it is intentionally part of product, documentation or cultural context.

## Legal note

Documentation and written repository pages are marked with a CC BY-NC-ND 4.0 footer. Source code licensing is not finalized by this footer.

---

© Tor-Ståle Hansen, https://github.com/TSHansen1971/rista

CC BY-NC-ND 4.0

Initial publication: 2026-06-23

Last modified: 2026-06-23
