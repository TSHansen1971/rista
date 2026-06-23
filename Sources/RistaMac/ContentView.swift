import RistaCore
import SwiftUI

struct ContentView: View {
    @Binding var document: RistaDocument

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()

            Divider()

            EditorPreviewSplitView(text: $document.text)
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
                Text("Merkespråk, ren tekst, ingen friksjon.")
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
