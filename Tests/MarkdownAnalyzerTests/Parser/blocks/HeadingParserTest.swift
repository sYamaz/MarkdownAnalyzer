import XCTest
@testable import MarkdownAnalyzer

final class Heading1ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading1Parser()
        let result = parser.parse("# Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH1 = result.node as? MDHeading1
        XCTAssertNotNil(maybeH1)
        let h1 = maybeH1!
        XCTAssertEqual(h1.inlines.count, 1)
        let maybeText = h1.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}

final class Heading2ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading2Parser()
        let result = parser.parse("## Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH2 = result.node as? MDHeading2
        XCTAssertNotNil(maybeH2)
        let h2 = maybeH2!
        XCTAssertEqual(h2.inlines.count, 1)
        let maybeText = h2.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}

final class Heading3ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading3Parser()
        let result = parser.parse("### Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH3 = result.node as? MDHeading3
        XCTAssertNotNil(maybeH3)
        let h3 = maybeH3!
        XCTAssertEqual(h3.inlines.count, 1)
        let maybeText = h3.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}

final class Heading4ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading4Parser()
        let result = parser.parse("#### Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH4 = result.node as? MDHeading4
        XCTAssertNotNil(maybeH4)
        let h4 = maybeH4!
        XCTAssertEqual(h4.inlines.count, 1)
        let maybeText = h4.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}

final class Heading5ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading5Parser()
        let result = parser.parse("##### Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH5 = result.node as? MDHeading5
        XCTAssertNotNil(maybeH5)
        let h5 = maybeH5!
        XCTAssertEqual(h5.inlines.count, 1)
        let maybeText = h5.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}

final class Heading6ParserTest:XCTestCase{
    public func testParse() throws{
        let parser = Heading6Parser()
        let result = parser.parse("###### Heading", closure: {txt in [MDText(txt)]})

        XCTAssertEqual("", result.nextText)
        let maybeH6 = result.node as? MDHeading6
        XCTAssertNotNil(maybeH6)
        let h6 = maybeH6!
        XCTAssertEqual(h6.inlines.count, 1)
        let maybeText = h6.inlines[0] as? MDText
        XCTAssertNotNil(maybeText)
        let text = maybeText!
        XCTAssertEqual("Heading", text.text)
    }
}
