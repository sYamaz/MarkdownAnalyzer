//

import Foundation
public class InlineParser
{
    var parsers:[InlineParserDelegate] = [InlineParserDelegate]()
    
    internal func parseInlineData(_ text:String) -> [MDInline]{
        var ret = [MDInline]()
        var textBuffer = ""
        var remainText = text
        while(remainText.count > 0){
            for parser in parsers {
                let result = parser.parse(text: remainText)
                remainText = result.nextText
                if let node = result.node {
                    ret.append(MDText(textBuffer))
                    textBuffer = ""
                    ret.append(node)
                    break
                }
            }
            textBuffer.append(remainText.first!)
            remainText = String(remainText[remainText.index(after: remainText.startIndex)...])
        }
        if(remainText.count != 0){
            ret.append(MDText(textBuffer))
        }
        return ret
    }
    
}


