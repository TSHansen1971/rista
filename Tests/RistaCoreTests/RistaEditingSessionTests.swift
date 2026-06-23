import Foundation
import RistaCore
import XCTest

final class RistaEditingSessionTests: XCTestCase {
    func testInitializesWithNormalizedMarkdownText() {
        let session = RistaEditingSession(markdownText: "A\r\nB\rC")

        XCTAssertEqual(session.text, "A\nB\nC")
        XCTAssertEqual(session.originalText, "A\nB\nC")
        XCTAssertEqual(session.revision, 0)
        XCTAssertEqual(session.renderInvalidationRevision, 0)
        XCTAssertNil(session.lastRenderInvalidationReason)
        XCTAssertFalse(session.isDirty)
    }

    func testTextUpdateMarksSessionDirtyAndInvalidatesRender() {
        var session = RistaEditingSession(markdownText: "# Title\n")

        let changed = session.replaceText(with: "# Title\n\nBody\n")

        XCTAssertTrue(changed)
        XCTAssertEqual(session.text, "# Title\n\nBody\n")
        XCTAssertEqual(session.originalText, "# Title\n")
        XCTAssertEqual(session.revision, 1)
        XCTAssertEqual(session.renderInvalidationRevision, 1)
        XCTAssertEqual(session.lastRenderInvalidationReason, .textChanged)
        XCTAssertTrue(session.isDirty)
    }

    func testEquivalentNormalizedTextDoesNotAdvanceRevision() {
        var session = RistaEditingSession(markdownText: "A\nB\n")

        let changed = session.replaceText(with: "A\r\nB\n")

        XCTAssertFalse(changed)
        XCTAssertEqual(session.text, "A\nB\n")
        XCTAssertEqual(session.revision, 0)
        XCTAssertEqual(session.renderInvalidationRevision, 0)
        XCTAssertNil(session.lastRenderInvalidationReason)
        XCTAssertFalse(session.isDirty)
    }

    func testMarkCleanResetsDirtyStateWithoutChangingText() {
        var session = RistaEditingSession(markdownText: "A\n")

        session.replaceText(with: "A\nB\n")
        XCTAssertTrue(session.isDirty)

        session.markClean()

        XCTAssertEqual(session.text, "A\nB\n")
        XCTAssertEqual(session.originalText, "A\nB\n")
        XCTAssertEqual(session.revision, 1)
        XCTAssertFalse(session.isDirty)
    }

    func testManualRenderInvalidationDoesNotRequireTextChange() {
        var session = RistaEditingSession(markdownText: "A\n")

        session.markRenderInvalid(.manual)

        XCTAssertEqual(session.revision, 0)
        XCTAssertEqual(session.renderInvalidationRevision, 0)
        XCTAssertEqual(session.lastRenderInvalidationReason, .manual)
        XCTAssertFalse(session.isDirty)
    }

    func testEditingSessionSourceDoesNotImportPlatformUIFrameworks() throws {
        let testFile = URL(fileURLWithPath: #filePath)
        let repositoryRoot = testFile
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()

        let sourceFile = repositoryRoot
            .appendingPathComponent("Sources")
            .appendingPathComponent("RistaCore")
            .appendingPathComponent("RistaEditingSession.swift")

        let source = try String(contentsOf: sourceFile, encoding: .utf8)

        XCTAssertFalse(source.contains("import SwiftUI"))
        XCTAssertFalse(source.contains("import AppKit"))
        XCTAssertFalse(source.contains("import UIKit"))
    }
}
