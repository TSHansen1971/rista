import RistaCore
import XCTest

final class RistaEditingSessionBehaviorTests: XCTestCase {
    func testMultipleTextUpdatesAdvanceRevisionButKeepOriginalUntilClean() {
        var session = RistaEditingSession(markdownText: "A\n")

        XCTAssertTrue(session.replaceText(with: "A\nB\n"))
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)
        XCTAssertEqual(session.originalText, "A\n")
        XCTAssertTrue(session.isDirty)

        XCTAssertTrue(session.replaceText(with: "A\nB\nC\n"))
        XCTAssertEqual(session.revision, 2)
        XCTAssertEqual(session.renderInvalidationRevision, 2)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)
        XCTAssertEqual(session.originalText, "A\n")
        XCTAssertTrue(session.isDirty)

        session.markClean()

        XCTAssertEqual(session.text, "A\nB\nC\n")
        XCTAssertEqual(session.originalText, "A\nB\nC\n")
        XCTAssertEqual(session.revision, 2)
        XCTAssertEqual(session.renderInvalidationRevision, 2)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)
        XCTAssertFalse(session.isDirty)
    }

    func testDocumentLoadedInvalidationReasonCanBeUsedForReplacement() {
        var session = RistaEditingSession(markdownText: "")

        let changed = session.replaceText(
            with: "# Imported\n\nBody\n",
            invalidationReason: .documentLoaded
        )

        XCTAssertTrue(changed)
        XCTAssertEqual(session.text, "# Imported\n\nBody\n")
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .documentLoaded)
        XCTAssertTrue(session.isDirty)
    }

    func testManualInvalidationAfterEditDoesNotAdvanceRevision() {
        var session = RistaEditingSession(markdownText: "A\n")

        XCTAssertTrue(session.replaceText(with: "B\n"))
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)

        session.markRenderInvalid(.manual)

        XCTAssertEqual(session.text, "B\n")
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .manual)
        XCTAssertTrue(session.isDirty)
    }

    func testRepeatedEquivalentReplacementAfterEditDoesNotAdvanceRevision() {
        var session = RistaEditingSession(markdownText: "A\n")

        XCTAssertTrue(session.replaceText(with: "A\nB\n"))
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)

        let changed = session.replaceText(with: "A\r\nB\r\n")

        XCTAssertFalse(changed)
        XCTAssertEqual(session.text, "A\nB\n")
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)
        XCTAssertTrue(session.isDirty)
    }

    func testMarkCleanAfterMultipleEditsPreservesRevisionHistory() {
        var session = RistaEditingSession(markdownText: "Start\n")

        XCTAssertTrue(session.replaceText(with: "First\n"))
        XCTAssertTrue(session.replaceText(with: "Second\n"))
        XCTAssertTrue(session.replaceText(with: "Third\n"))

        XCTAssertEqual(session.revision, 3)
        XCTAssertTrue(session.isDirty)

        session.markClean()

        XCTAssertEqual(session.text, "Third\n")
        XCTAssertEqual(session.originalText, "Third\n")
        XCTAssertEqual(session.revision, 3)
        XCTAssertFalse(session.isDirty)

        XCTAssertTrue(session.replaceText(with: "Fourth\n"))
        XCTAssertEqual(session.revision, 4)
        XCTAssertEqual(session.originalText, "Third\n")
        XCTAssertTrue(session.isDirty)
    }
}
