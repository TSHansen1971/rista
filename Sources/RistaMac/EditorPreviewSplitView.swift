import SwiftUI

struct EditorPreviewSplitView: View {
    @Binding var text: String

    var body: some View {
        HSplitView {
            VStack(alignment: .leading, spacing: 0) {
                PaneTitle(title: RistaL10n.string("pane.markdown.title"), subtitle: RistaL10n.string("pane.markdown.subtitle"))
                MarkdownTextView(text: $text)
            }
            .frame(minWidth: 360)

            VStack(alignment: .leading, spacing: 0) {
                PaneTitle(title: RistaL10n.string("pane.preview.title"), subtitle: RistaL10n.string("pane.preview.subtitle"))
                MarkdownPreviewView(markdown: text)
            }
            .frame(minWidth: 360)
        }
    }
}

private struct PaneTitle: View {
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.regularMaterial)
    }
}
