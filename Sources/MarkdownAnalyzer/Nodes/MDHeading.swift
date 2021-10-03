//

import Foundation
public class MDHeading1: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h1>\(inlines.map{inline in inline.html}.joined())</h1>")
    }
}

public class MDHeading2: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h2>\(inlines.map{inline in inline.html}.joined())</h2>")
    }
}

public class MDHeading3: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h3>\(inlines.map{inline in inline.html}.joined())</h3>")
    }
}

public class MDHeading4: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h4>\(inlines.map{inline in inline.html}.joined())</h4>")
    }
}

public class MDHeading5: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h5>\(inlines.map{inline in inline.html}.joined())</h5>")
    }
}

public class MDHeading6: MDBlock{
    var inlines:[MDInline]
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        super.init(html: "<h6>\(inlines.map{inline in inline.html}.joined())</h6>")
    }
}
