//

import Foundation
public class MDStrong: MDInline{
    var text:String
    init(_ text:String){
        self.text = text
        super.init(html: "<strong>\(text)</strong>")
    }
}
