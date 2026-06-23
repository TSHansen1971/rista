import RistaCore
import SwiftUI

@MainActor
struct ContentView: View {
    @Binding var document: RistaDocument
    @State private var editorModel: RistaMacEditorModel
    @State private var editorRevision: Int = 0

    init(document: Binding<RistaDocument>) {
        self._document = document
        self._editorModel = State(
            initialValue: RistaMacEditorModel(markdownText: document.wrappedValue.text)
        )
    }

    private var editorText: Binding<String> {
        Binding(
            get: {
                editorModel.text
            },
            set: { newText in
                let changed = editorModel.replaceText(with: newText)

                if changed || document.text != newText {
                    document.text = newText
                    editorRevision = editorModel.revision
                }
            }
        )
    }

    var body: some View {
        let _ = editorRevision

        VStack(spacing: 0) {
            HeaderView()

            Divider()

            EditorPreviewSplitView(text: editorText)
                .onChange(of: document.text) { _, newText in
                    guard editorModel.text != newText else {
                        return
                    }

                    editorModel.replaceSession(markdownText: newText)
                    editorRevision = editorModel.revision
                }
        }
        .frame(minWidth: 900, minHeight: 560)
    }
}

private struct HeaderView: View {
    var body: some View {
        HStack(spacing: 12) {
            Text("ᚼ")
                .font(.system(size: 24, weight: .medium, design: .serif))

            VStack(alignment: .leading, spacing: 2) {
                Text("Rísta")
                    .font(.headline)
                Text(RistaL10n.string("app.subtitle"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(.bar)
    }
}
