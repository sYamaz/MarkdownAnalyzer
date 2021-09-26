import XCTest
@testable import MarkdownAnalyzer

final class MarkdownAnalyzerInlinesTests: XCTestCase {

    func testBold() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("**bold**"))
        
        XCTAssertEqual(inlines.count, 1)
        XCTAssertEqual("bold", (inlines[0] as! MDBold).text)
    }
    
    func testItalic() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("*italic*"))
        
        XCTAssertEqual(inlines.count, 1)
        XCTAssertEqual("italic", (inlines[0] as! MDItalic).text)
    }
    
    func testStrikethrough() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("~~strikethrough~~"))
        
        XCTAssertEqual(inlines.count, 1)
        XCTAssertEqual("strikethrough", (inlines[0] as! MDStrikethrough).text)
    }
    
    func testInlineCode() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("`code`"))
        
        XCTAssertEqual(inlines.count, 1)
        XCTAssertEqual("code", (inlines[0] as! MDInlineCode).text)
    }
    
    func testLink() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("[name](source)"))
        
        XCTAssertEqual(inlines.count, 1)
        let data = inlines[0] as! MDLink
        XCTAssertEqual("name", data.name)
        XCTAssertEqual("source", data.source)
    }
    
    func testImage() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("![name](source)"))
        
        XCTAssertEqual(inlines.count, 1)
        let data = inlines[0] as! MDImage
        XCTAssertEqual("name", data.name)
        XCTAssertEqual("source", data.source)
    }
    
    func testText() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("text"))
        
        XCTAssertEqual(inlines.count, 1)
        XCTAssertEqual("text", (inlines[0] as! MDText).text)
    }
    
    func testCombinedInlines() throws{
        let parser = MarkdownAnalyzer()
        let inlines = parser.parseInlineData(String.SubSequence("text**bold***italic*~~strikethrogh~~text`code`[name](source)![name](source)text"))
        
        XCTAssertEqual(inlines.count, 9)
        XCTAssertEqual("text", (inlines[0] as! MDText).text)
        XCTAssertEqual("bold", (inlines[1] as! MDBold).text)
        XCTAssertEqual("italic", (inlines[2] as! MDItalic).text)
        XCTAssertEqual("strikethrogh", (inlines[3] as! MDStrikethrough).text)
        XCTAssertEqual("text", (inlines[4] as! MDText).text)
        XCTAssertEqual("code", (inlines[5] as! MDInlineCode).text)
        let link = (inlines[6] as! MDLink)
        XCTAssertEqual("name", link.name)
        XCTAssertEqual("source", link.source)
        let image = (inlines[7] as! MDImage)
        XCTAssertEqual("name", image.name)
        XCTAssertEqual("source", image.source)
        XCTAssertEqual("text", (inlines[8] as! MDText).text)
    }
}
