//

import Foundation
public class MDText: MDInline{
    let text:String
    init(_ text:String){
        self.text = text
        super.init(html: text)
    }
}
