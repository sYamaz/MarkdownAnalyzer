//

import Foundation
public class MDLink: MDInline{
    var name:String
    var source:String
    init(name:String, source:String){
        self.name = name
        self.source = source
        super.init(html: "<a href=\"\(source)\">\(name)</a>")
    }
}
