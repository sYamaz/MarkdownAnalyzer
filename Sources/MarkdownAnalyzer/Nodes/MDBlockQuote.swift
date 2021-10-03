//

import Foundation
public class MDBlockQuote: MDBlock{
    var block:MDBlock
    init(_ block:MDBlock){
        self.block = block
        super.init(html: "<blockquote>\n\(block.html)\n</blockquote>")
    }
}
