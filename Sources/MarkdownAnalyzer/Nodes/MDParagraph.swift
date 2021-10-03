//

import Foundation
public class MDParagraph: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<p>\(inlines.map{inline in inline.html}.joined())</p>")
    }
}
