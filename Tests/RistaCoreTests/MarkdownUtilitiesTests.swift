import RistaCore
import XCTest

final class MarkdownUtilitiesTests: XCTestCase {
    func testNormalizesLineEndings() {
        XCTAssertEqual(
            MarkdownUtilities.normalizedLineEndings("a\r\nb\rc"),
            "a\nb\nc"
        )
    }
}
