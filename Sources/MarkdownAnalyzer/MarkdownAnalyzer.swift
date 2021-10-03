//

import Foundation
import SwiftUI

public class MDNode{
    let html:String
    init(html:String){
        self.html = html
    }
}

public class MDBlock : MDNode{}

public class MDInline : MDNode{}

public class MarkdownAnalyzer
{
    let inlineParser:InlineParser
    let blockParser:BlockParser
    public init(){
        self.inlineParser = InlineParser()
        self.blockParser = BlockParser()
        inlineParser.parsers.append(StrongParser())
        inlineParser.parsers.append(EmphasisParser())
        inlineParser.parsers.append(CodeSpanParser())
        // link
        // image
        
        blockParser.parsers.append(Heading6Parser())
        blockParser.parsers.append(Heading5Parser())
        blockParser.parsers.append(Heading4Parser())
        blockParser.parsers.append(Heading3Parser())
        blockParser.parsers.append(Heading2Parser())
        blockParser.parsers.append(Heading1Parser())
        // unordered-list
        // ordered-list
        // blockquote
        // codeblock
    }
    
    public func addCustomInlineParser(_ parser:InlineParserDelegate) -> Void{
        self.inlineParser.parsers.append(parser)
    }
    
    public func addCustomBlockParser(_ parser:BlockParserDelegate) -> Void{
        self.blockParser.parsers.append(parser)
    }
    
    private func parseInlineData(_ text:String.SubSequence) -> [MDInline]{
        return self.inlineParser.parseInlineData(String(text))
    }
    
    private func parseBlockData(_ text:String) -> [MDBlock]{
        return self.blockParser.parseBlockData(text, inlineParser: inlineParser)
    }
    
    func parse(_ text: String) -> MDSyntaxTree{
        let blocks = parseBlockData(text)
                
        let ret = MDSyntaxTree(blocks: blocks)
        return ret
    }
}

public struct MDSyntaxTree{
    var blocks:[MDBlock]
}
