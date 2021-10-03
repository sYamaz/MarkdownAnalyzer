//

import Foundation
public class MDCodeSpan : MDInline{
    var text:String
    init(_ text:String){
        self.text = text
        super.init(html: "<code>\(text)</code>")
    }
}
