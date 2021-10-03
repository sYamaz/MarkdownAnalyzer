//

import Foundation
public class MDUnorderedList: MDBlock{
    var items:[MDUnorderedListItem]
    
    init(_ items:[MDUnorderedListItem]){
        self.items = items
        super.init(html: "<ul>\n\(items.map{item in item.html}.joined(separator: "\n"))\n</ul>\n")
    }
}

public class MDUnorderedListItem
{
    var inlines:[MDInline]
    var children:[MDUnorderedListItem]
    let html:String
    
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        self.children = [MDUnorderedListItem]()
        self.html = "<li>\(inlines.map{inline in inline.html}.joined())</li>"
    }
    
    init(_ inlines:[MDInline], children:[MDUnorderedListItem]){
        self.inlines = inlines
        self.children = children
        self.html = "<li>\(inlines.map{inline in inline.html}.joined())\n<ul>\n\(children.map{c in c.html}.joined(separator: "\n"))\n</ul>\n</li>"
    }
}

public class MDOrderedList: MDBlock{
    var items:[MDOrderedListItem]
    
    init(_ items:[MDOrderedListItem]){
        self.items = items
        super.init(html: "<ol>\n\(items.map{item in item.html}.joined(separator: "\n"))\n</ol>\n")
    }
}

public class MDOrderedListItem
{
    var inlines:[MDInline]
    var children:[MDOrderedListItem]
    let html:String
    
    init(_ inlines:[MDInline]){
        self.inlines = inlines
        self.children = [MDOrderedListItem]()
        self.html = "<li>\(inlines.map{inline in inline.html}.joined())</li>"
    }
    
    init(_ inlines:[MDInline], children:[MDOrderedListItem]){
        self.inlines = inlines
        self.children = children
        self.html = "<li>\(inlines.map{inline in inline.html}.joined())\n<ol>\n\(children.map{c in c.html}.joined(separator: "\n"))\n</ol>\n</li>"
    }
}
