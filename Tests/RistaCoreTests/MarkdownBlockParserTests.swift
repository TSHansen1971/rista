import RistaCore
import XCTest

final class MarkdownBlockParserTests: XCTestCase {
    func testParsesBasicBlocks() {
        let markdown = """
        # Tittel

        Et avsnitt.

        - ett
        - to

        > sitat

        ---
        """

        let blocks = MarkdownBlockParser.parse(markdown)

        XCTAssertEqual(
            blocks,
            [
                .heading(level: 1, text: "Tittel"),
                .paragraph("Et avsnitt."),
                .unorderedList(["ett", "to"]),
                .quote("sitat"),
                .horizontalRule
            ]
        )
    }
}
