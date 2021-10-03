//

import Foundation
public class BlockParser{
    var parsers:[BlockParserDelegate] = [BlockParserDelegate]()
    
    internal func parseBlockData(_ text:String, inlineParser:InlineParser) -> [MDBlock]{
        var ret = [MDBlock]()
        var remainText = text
        var textBuffer = ""
        while(remainText.count > 0){
            for parser in parsers {
                let result = parser.parse(text, closure: inlineParser.parseInlineData(_:))
                remainText = result.nextText
                if let node = result.node{
                    ret.append(MDParagraph(inlineParser.parseInlineData(textBuffer)))
                    textBuffer = ""
                    ret.append(node)
                    break
                }
            }
            textBuffer.append(remainText.first!)
            remainText = String(remainText[remainText.index(after: remainText.startIndex)...])
        }
        if(remainText.count != 0){
            ret.append(MDParagraph(inlineParser.parseInlineData(textBuffer)))
        }
        return ret
    }
}
