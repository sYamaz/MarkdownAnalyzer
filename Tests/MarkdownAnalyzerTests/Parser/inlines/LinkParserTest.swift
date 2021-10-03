//
import XCTest
@testable import MarkdownAnalyzer


final class LinkParserTest:XCTestCase{
    public func testParse() throws{
        let parser = LinkParser()
        let result = parser.parse(text: "[name](source)aaa")
        
        XCTAssertEqual(result.nextText, "aaa")
        XCTAssertNotNil(result.node)
        XCTAssertEqual((result.node as! MDLink).name, "name")
        XCTAssertEqual((result.node as! MDLink).source, "source")
    }
}
