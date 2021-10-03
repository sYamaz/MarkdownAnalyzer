//

import Foundation
public class EmphasisParser : InlineParserDelegate{

    public func parse(text: String) -> (nextText: String, node: MDInline?) {
        if(text.starts(with: "*")){
            // scan
            let subStartIndex = text.index(text.startIndex, offsetBy: 1)
            let subText = text[subStartIndex...]
            if let end = subText.range(of: "*"){
                // text between ** and **
                let content = subText[..<end.lowerBound]
                
                return (String(subText[end.upperBound...]), MDEmphasis(String(content)))
            }
        }
        
        return (text, nil)
    }
}
