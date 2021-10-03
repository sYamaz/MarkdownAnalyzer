//

import Foundation
public class MDCodeBlock : MDBlock{
    var lang:String
    var text:String
    
    init(lang:String, text:String){
        self.lang = lang
        self.text = text
        super.init(html: "<pre><code class=\"language-\(lang)\">\(text)</code></pre>")
    }
    
    init(_ text:String){
        self.lang = ""
        self.text = text
        super.init(html: "<pre><code>\(text)</code></pre>")
    }
}
