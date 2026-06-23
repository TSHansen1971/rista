import SwiftUI

struct EditorPreviewSplitView: View {
    @Binding var text: String

    var body: some View {
        HSplitView {
            VStack(alignment: .leading, spacing: 0) {
                PaneTitle(title: "Markdown", subtitle: "Ren tekst")
                MarkdownTextView(text: $text)
            }
            .frame(minWidth: 360)

            VStack(alignment: .leading, spacing: 0) {
                PaneTitle(title: "Forhåndsvisning", subtitle: "Formatert dokument")
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
