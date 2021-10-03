//
import XCTest
@testable import MarkdownAnalyzer


final class EmphasisParserTest:XCTestCase{
    public func testParse() throws{
        let parser = EmphasisParser()
        let result = parser.parse(text: "*emp*aaa")
        
        XCTAssertEqual(result.nextText, "aaa")
        XCTAssertNotNil(result.node)
        XCTAssertEqual((result.node as! MDEmphasis).text, "emp")
    }
}
