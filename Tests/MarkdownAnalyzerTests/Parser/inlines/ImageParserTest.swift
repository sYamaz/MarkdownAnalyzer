//
import XCTest
@testable import MarkdownAnalyzer


final class ImageParserTest:XCTestCase{
    public func testParse() throws{
        let parser = ImageParser()
        let result = parser.parse(text: "![name](source)aaa")
        
        XCTAssertEqual(result.nextText, "aaa")
        XCTAssertNotNil(result.node)
        XCTAssertEqual((result.node as! MDImage).name, "name")
        XCTAssertEqual((result.node as! MDImage).source, "source")
    }
}
