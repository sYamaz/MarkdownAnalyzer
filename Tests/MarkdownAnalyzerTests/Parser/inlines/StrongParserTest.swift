//
import XCTest
@testable import MarkdownAnalyzer


final class StrongParserTest:XCTestCase{
    public func testParse() throws{
        let parser = StrongParser()
        let result = parser.parse(text: "**bold**aaa")
        
        XCTAssertEqual(result.nextText, "aaa")
        XCTAssertNotNil(result.node)
        XCTAssertEqual((result.node as! MDStrong).text, "bold")
    }
}

