//

import Foundation
public class CodeBlockParser : BlockParserDelegate{

    public func parse(_ text: String, closure: (String) -> [MDInline]) -> (nextText: String, node: MDBlock?) {
        
        if(text.starts(with: "```")){
            var subText = text[text.index(text.startIndex, offsetBy: 3)...]
            var nextText = ""
            var lang = ""
            if let langRange = subText.range(of: "\n"){
                lang = String(subText[..<langRange.lowerBound])
                subText = subText[langRange.upperBound...]
            }
            if let close = subText.range(of: "\n```"){
                nextText = String(subText[close.upperBound...])
                subText = subText[..<close.lowerBound]
            }
            
            return (nextText, MDCodeBlock(lang: lang, text: String(subText)))
        }
        
        return (text, nil)
    }
}
