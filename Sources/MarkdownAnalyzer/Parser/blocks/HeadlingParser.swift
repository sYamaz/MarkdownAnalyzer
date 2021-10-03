//

import Foundation

public class Heading1Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "# "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading1(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class Heading2Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "## "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading2(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class Heading3Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "### "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading3(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class Heading4Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "#### "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading4(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class Heading5Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "##### "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading5(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class Heading6Parser: BasicHeadingParser, BlockParserDelegate{
    let startWith = "###### "
    
    init(){
        super.init(startWith: startWith)
    }
    
    public func parse(_ text: String, closure:(String)->[MDInline]) -> (nextText: String, node: MDBlock?) {
        let result = parseCore(text, closure: closure)
        
        if let inlines = result.inlines{
            return (result.nextText, MDHeading6(inlines))
        }else{
            return (result.nextText, nil)
        }
    }
}

public class BasicHeadingParser{
    private let startWith:String
    
    fileprivate init(startWith:String){
        self.startWith = startWith
    }
    
    fileprivate func parseCore(_ text:String, closure:(String)->[MDInline]) -> (nextText:String, inlines:[MDInline]?){
        if(text.starts(with: startWith)){
            let subStartIndex = text.index(text.startIndex, offsetBy: startWith.count)
            let subText = text[subStartIndex...]
            
            var endIndex = text.endIndex
            var nextStartIndex = text.endIndex
            if let end = subText.range(of: "\n"){
                endIndex = end.lowerBound
                nextStartIndex = end.upperBound
            }
            
            let content = subText[..<endIndex]
            let inlines = closure(String(content))
            
            return (String(subText[nextStartIndex...]), inlines)
        }
        
        return (text, nil)
    }
}
