//

import Foundation
public protocol InlineParserDelegate{
    func parse(text:String) -> (nextText:String, node:MDInline?)
}
