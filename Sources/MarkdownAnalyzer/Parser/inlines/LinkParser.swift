//

import Foundation
public class LinkParser:InlineParserDelegate{
    public func parse(text: String) -> (nextText: String, node: MDInline?) {
        if(text.starts(with: "[")){
            let subtext = text[text.index(after: text.startIndex)...]
            if let nameRange = subtext.range(of: "]("){
                let name = String(subtext[..<nameRange.lowerBound])
                
                let linktext = subtext[nameRange.upperBound...]
                if let linkRange = linktext.range(of: ")"){
                    let link = String(linktext[..<linkRange.lowerBound])
                    
                    let remain = linktext[linkRange.upperBound...]
                    return(String(remain), MDLink(name: name, source: link))
                }
            }
        }
        return(text, nil)
    }
}

