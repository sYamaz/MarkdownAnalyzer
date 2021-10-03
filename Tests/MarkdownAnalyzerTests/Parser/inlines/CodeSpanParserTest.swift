//
import XCTest
@testable import MarkdownAnalyzer


final class CodeSpanParserTest:XCTestCase{
    public func testParse() throws{
        let parser = CodeSpanParser()
        let result = parser.parse(text: "`code`aaa")
        
        XCTAssertEqual(result.nextText, "aaa")
        XCTAssertNotNil(result.node)
        XCTAssertEqual((result.node as! MDCodeSpan).text, "code")
    }
}
