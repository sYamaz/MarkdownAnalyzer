//

import Foundation
public class MDEmphasis:MDInline{
    var text:String
    init(_ text:String){
        self.text = text
        super.init(html: "<em>\(text)</em>")
    }
}
