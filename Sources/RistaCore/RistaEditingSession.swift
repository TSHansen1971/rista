public enum RistaRenderInvalidationReason: Equatable, Sendable {
    case textChanged
    case documentLoaded
    case manual
}

public struct RistaEditingSession: Equatable, Sendable {
    public private(set) var originalText: String
    public private(set) var text: String
    public private(set) var revision: Int
    public private(set) var renderInvalidationRevision: Int
    public private(set) var lastRenderInvalidationReason: RistaRenderInvalidationReason?

    public var isDirty: Bool {
        text != originalText
    }

    public init(markdownText: String = "") {
        let normalizedText = MarkdownUtilities.normalizedLineEndings(markdownText)

        self.originalText = normalizedText
        self.text = normalizedText
        self.revision = 0
        self.renderInvalidationRevision = 0
        self.lastRenderInvalidationReason = nil
    }

    @discardableResult
    public mutating func replaceText(
        with newText: String,
        invalidationReason: RistaRenderInvalidationReason = .textChanged
    ) -> Bool {
        let normalizedText = MarkdownUtilities.normalizedLineEndings(newText)

        guard normalizedText != text else {
            return false
        }

        text = normalizedText
        revision += 1
        markRenderInvalid(invalidationReason)

        return true
    }

    public mutating func markClean() {
        originalText = text
    }

    public mutating func markRenderInvalid(
        _ reason: RistaRenderInvalidationReason = .manual
    ) {
        renderInvalidationRevision = revision
        lastRenderInvalidationReason = reason
    }
}
