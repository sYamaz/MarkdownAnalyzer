import XCTest
@testable import MarkdownAnalyzer

final class MarkdownAnalyzerBlockTests: XCTestCase {
    func testHeading1() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("# Heading1")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading1", ((tree.blocks[0] as! MDHeading1).inlines[0] as! MDText).text)
    }
    
    func testHeading2() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("## Heading2")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading2", ((tree.blocks[0] as! MDHeading2).inlines[0] as! MDText).text)
    }
    
    func testHeading3() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("### Heading3")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading3", ((tree.blocks[0] as! MDHeading3).inlines[0] as! MDText).text)
    }
    
    func testHeading4() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("#### Heading4")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading4", ((tree.blocks[0] as! MDHeading4).inlines[0] as! MDText).text)
    }
    
    func testHeading5() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("##### Heading5")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading5", ((tree.blocks[0] as! MDHeading5).inlines[0] as! MDText).text)
    }
    
    func testHeading6() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("###### Heading6")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertEqual("Heading6", ((tree.blocks[0] as! MDHeading6).inlines[0] as! MDText).text)
    }
    
    func testHorizontalRule() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("---\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDHorizontalRule)
    }
    
    func testParagraph() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("text")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDParagraph)
    }
    
    func testUnorderedList() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("- item1\n- item2\n- item3\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDUnorderedList)
    }
    
    func testOrderedList() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("1. item1\n2. item2\n3. item3\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDOrderedList)
    }
    
    func testBlockQuote() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("> text\n> text2\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDBlockQuote)
    }
    
    func testCodeBlock() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("``` csharp\nvar a = b + c;\n```\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDCodeBlock)
    }
    
    func testTable() throws{
        let parser = MarkdownAnalyzer()
        let tree = parser.parse("| A | B |\n|---|---|\n| C | D |\n\n")
        
        XCTAssertEqual(tree.blocks.count, 1)
        XCTAssertNotNil(tree.blocks[0] as? MDTable)
    }
    
    func testSampleText() throws{
        let parser = MarkdownAnalyzer()
        let sampleTxt = "# Sample\n\n*サンプル*用の**Markdown**テキストです。\n\n## 使い方\n\n```swift\nlet analyzer = MarkdownAnalyzer()\nlet tree = analyzer.parse(\"Markdown本文\")\n```\n\n"
        
        let tree = parser.parse(sampleTxt)
        for block in tree.blocks {
            print(block)
        }
    }
}
