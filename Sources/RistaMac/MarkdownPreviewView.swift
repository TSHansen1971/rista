import RistaCore
import SwiftUI

struct MarkdownPreviewView: View {
    let markdown: String

    private var blocks: [MarkdownBlock] {
        MarkdownBlockParser.parse(markdown)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                if blocks.isEmpty {
                    Text(RistaL10n.string("preview.empty"))
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(blocks.enumerated()), id: \.offset) { _, block in
                        blockView(block)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .background(Color(nsColor: .textBackgroundColor))
    }

    @ViewBuilder
    private func blockView(_ block: MarkdownBlock) -> some View {
        switch block {
        case .heading(let level, let text):
            Text(inlineMarkdown(text))
                .font(headingFont(level: level))
                .fontWeight(.semibold)
                .textSelection(.enabled)

        case .paragraph(let text):
            Text(inlineMarkdown(text))
                .font(.body)
                .lineSpacing(4)
                .textSelection(.enabled)

        case .unorderedList(let items):
            VStack(alignment: .leading, spacing: 6) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("•")
                        Text(inlineMarkdown(item))
                            .textSelection(.enabled)
                    }
                }
            }

        case .orderedList(let items):
            VStack(alignment: .leading, spacing: 6) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(index + 1).")
                            .monospacedDigit()
                        Text(inlineMarkdown(item))
                            .textSelection(.enabled)
                    }
                }
            }

        case .quote(let text):
            HStack(alignment: .top, spacing: 12) {
                Rectangle()
                    .frame(width: 3)
                    .foregroundStyle(.secondary.opacity(0.35))
                Text(inlineMarkdown(text))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }

        case .code(let code):
            Text(code)
                .font(.system(.body, design: .monospaced))
                .textSelection(.enabled)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 8, style: .continuous))

        case .horizontalRule:
            Divider()
        }
    }

    private func headingFont(level: Int) -> Font {
        switch level {
        case 1: return .largeTitle
        case 2: return .title
        case 3: return .title2
        case 4: return .title3
        default: return .headline
        }
    }

    private func inlineMarkdown(_ text: String) -> AttributedString {
        (try? AttributedString(markdown: text)) ?? AttributedString(text)
    }
}
