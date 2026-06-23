import RistaCore

@MainActor
final class RistaMacEditorModel {
    private var editingSession: RistaEditingSession

    var text: String {
        editingSession.text
    }

    var isDirty: Bool {
        editingSession.isDirty
    }

    var revision: Int {
        editingSession.revision
    }

    var renderInvalidationRevision: Int {
        editingSession.renderInvalidationRevision
    }

    var lastRenderInvalidationReason: RistaRenderInvalidationReason? {
        editingSession.lastRenderInvalidationReason
    }

    init(markdownText: String = "") {
        self.editingSession = RistaEditingSession(markdownText: markdownText)
    }

    @discardableResult
    func replaceText(
        with newText: String,
        invalidationReason: RistaRenderInvalidationReason = .textChanged
    ) -> Bool {
        editingSession.replaceText(
            with: newText,
            invalidationReason: invalidationReason
        )
    }

    func markClean() {
        editingSession.markClean()
    }

    func markRenderInvalid(
        _ reason: RistaRenderInvalidationReason = .manual
    ) {
        editingSession.markRenderInvalid(reason)
    }

    func replaceSession(markdownText: String) {
        editingSession = RistaEditingSession(markdownText: markdownText)
    }
}
