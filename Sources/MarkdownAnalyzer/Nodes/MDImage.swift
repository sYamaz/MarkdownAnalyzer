//

import Foundation
public class MDImage: MDInline{
    var name:String
    var source:String
    init(name:String, source:String){
        self.name = name
        self.source = source
        super.init(html: "<img src=\"\(source)\" alt=\"\(name)\"")
    }
}
