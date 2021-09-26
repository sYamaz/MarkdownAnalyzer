//

import Foundation
import SwiftUI

protocol MDNodeDelegate{}

protocol MDBlockDelegate : MDNodeDelegate{}

protocol MDInlineDelegate : MDNodeDelegate{}

public class MarkdownAnalyzer
{
    func parse(_ text: String) -> MDSyntaxTree{
        var blocks = [MDBlockDelegate]()
        // blockに分割する
        var ind = text.startIndex
        while(ind != text.endIndex){
            var nextInd = text.index(after: ind)
            if(text[ind...].starts(with: "# ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline1(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                } else{
                    blocks.append(parseHeadline1(blockSpan))
                    break
                }
            }
            else if(text[ind...].starts(with: "## ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline2(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                } else{
                    blocks.append(parseHeadline2(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "### ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline3(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseHeadline3(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "#### ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline4(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseHeadline4(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "##### ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline5(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseHeadline5(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "###### ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseHeadline6(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseHeadline6(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "---\n\n")){
                if let r = text[ind...].range(of: "---\n\n"){
                    blocks.append(parseHorizontalRule("---\n\n"))
                    nextInd = r.upperBound
                }
            }
            else if(text[ind...].starts(with: "===\n\n")){
                if let r = text[ind...].range(of: "===\n\n"){
                    blocks.append(parseHorizontalRule("===\n\n"))
                    nextInd = r.upperBound
                }
            }
            else if(text[ind...].starts(with: "```")){
                if let start = text[ind...].range(of: "```"){
                    if let end = text[start.upperBound...].range(of: "```\n\n"){
                        
                        blocks.append(parseCodeBlock(text[ind..<end.upperBound]))
                        nextInd = end.upperBound
                    }
                    else{
                        break;
                    }
                }
            }
            else if(text[ind...].starts(with: "- ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseUnorderedList(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseUnorderedList(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "* ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseUnorderedList(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseUnorderedList(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "+ ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseUnorderedList(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseUnorderedList(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "1. ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseOrderedList(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseOrderedList(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "> ")){
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseBlockQuote(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseBlockQuote(blockSpan))
                    break;
                }
            }
            else if(text[ind...].starts(with: "|")){
                //table or paragragh
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "|\n\n"){
                    
                    blocks.append(parseTable(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseParagragh(blockSpan))
                    break
                }
            }
            else{ // paragragh
                let blockSpan = text[ind...]
                if let r = blockSpan.range(of: "\n\n"){
                    blocks.append(parseParagragh(blockSpan[..<r.lowerBound]))
                    nextInd = r.upperBound
                }else{
                    blocks.append(parseParagragh(blockSpan))
                    break;
                }
            }
            
            ind = nextInd
        }
        
        let ret = MDSyntaxTree(blocks: blocks)
        return ret
    }
    
    private func parseHeadline1(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(1)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        return MDHeading1(inlines: inlines)
    }
    
    private func parseHeadline2(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(2)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        return MDHeading2(inlines: inlines)
    }
    
    private func parseHeadline3(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(3)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        
        return MDHeading3(inlines: inlines)
    }
    
    private func parseHeadline4(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(4)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        return MDHeading4(inlines: inlines)
    }
    
    private func parseHeadline5(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(5)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        return MDHeading5(inlines: inlines)
    }
    
    private func parseHeadline6(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(6)
        let subString = data.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let inlines = parseInlineData(String.SubSequence(subString))
        return MDHeading6(inlines: inlines)
    }
    
    private func parseParagragh(_ text:String.SubSequence) -> MDBlockDelegate{
        let inlines = parseInlineData(text)
        return MDParagraph(inlines: inlines)
    }
    
    
    private func parseUnorderedList(_ text:String.SubSequence) -> MDBlockDelegate{
        var items:[MDUnorderedListItem] = [MDUnorderedListItem]()
        var span = text[text.startIndex...]
        while(true){
            if let endofLine = span.range(of: "\n"){
                let line = span[span.startIndex..<endofLine.lowerBound]
                var lineTxt = String(line)
                lineTxt.removeFirst(2)
                if(lineTxt.count > 0){
                    let inlines = parseInlineData(String.SubSequence(lineTxt))
                    items.append(MDUnorderedListItem(inlines: inlines, children: [MDUnorderedListItem]()))
                }
                span = span[endofLine.upperBound...]
            } else {
                break
            }
        }
        
        return MDUnorderedList(items: items)
    }
    
    private func parseOrderedList(_ text:String.SubSequence) -> MDBlockDelegate{
        var items:[MDOrderedListItem] = [MDOrderedListItem]()
        var span = text[text.startIndex...]
        while(true){
            if let endofLine = span.range(of: "\n"){
                let line = span[span.startIndex..<endofLine.lowerBound]
                var lineTxt = String(line)
                lineTxt.removeFirst(2)
                if(lineTxt.count > 0){
                    let inlines = parseInlineData(String.SubSequence(lineTxt))
                    items.append(MDOrderedListItem(inlines: inlines, children: [MDOrderedListItem]()))
                }
                span = span[endofLine.upperBound...]
            } else {
                break
            }
        }
        
        return MDOrderedList(items: items)
    }
    
    private func parseCodeBlock(_ text:String.SubSequence) -> MDBlockDelegate{
        var data = text
        data.removeFirst(3)
        let id = data.range(of: "\n")!
        
        let langName = data[..<id.lowerBound]
        
        let content = data[id.upperBound...]
        var contentText = content.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
        contentText.removeLast(3)
        
        return MDCodeBlock(lang: String(langName), multilineText: String(contentText))
    }
    
    private func parseBlockQuote(_ text:String.SubSequence) -> MDBlockDelegate{
        return MDBlockQuote(multilineText: String(text))
    }
    
    private func parseTable(_ text: String.SubSequence) -> MDBlockDelegate{
        let lines = text.split(separator: "\n")
        if(lines.count < 3){
            return parseParagragh(text)
        }
        
        let headlineRow = lines[0]
        let headlineCellTexts = headlineRow.split(separator: "|")
        let headlineCells = headlineCellTexts.map{txt in MDTableCell(inlines: parseInlineData(txt))}
        
        let configRow = lines[1]
        let configTexts  = configRow.split(separator: "|")
        let configs:[MDTableColConfig] = configTexts.map{c in
            if(c[c.startIndex] == ":"){
                return MDTableColConfig.leading
            }
            else if(c[c.index(before: c.endIndex)] == ":"){
                return MDTableColConfig.trailing
            }
            else{
                return MDTableColConfig.center
            }
        }
        
        let dataRows:[MDTableRow] = lines[2...].map{line in
            return MDTableRow(cells: line.split(separator: "|").map{c in
                let inlines = parseInlineData(c)
                return MDTableCell(inlines: inlines)
            })
        }
        
        return MDTable(headline: MDTableHeader(cells: headlineCells), colconfigs: MDTableColConfigs(colconfigs: configs), rows: dataRows)
    }
    
    private func parseHorizontalRule(_ text:String.SubSequence) -> MDHorizontalRule{
        return MDHorizontalRule(data: String(text))
    }
    
    
    internal func parseInlineData(_ text:String.SubSequence) -> [MDInlineDelegate]{
        var ind = text.startIndex
        var ret = [MDInlineDelegate]()
        var txtBuffer = [Character]()
        while(ind != text.endIndex){
            let nextInd = text.index(after: ind)
            let span = text[ind...]
            if(span.starts(with: "**")){
                if let start = span.range(of: "**"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "**"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseBold(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "__")){
                
                if let start = span.range(of: "__"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "__"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseBold(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "*")){
                if let start = span.range(of: "*"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "*"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseItalic(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "_")){
                if let start = span.range(of: "_"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "_"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseItalic(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "~~")){
                if let start = span.range(of: "~~"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "~~"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseStrikethrough(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "`")){
                if let start = span.range(of: "`"){
                    let subSpan = span[start.upperBound...]
                    if let end = subSpan.range(of: "`"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseInlineCode(subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "[")){
                if let nameStart = span.range(of: "]("){
                    var display = span[..<nameStart.lowerBound]
                    display = display[display.index(after: display.startIndex)...]
                    let subSpan = span[nameStart.upperBound...]
                    if let end = subSpan.range(of: ")"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseLink(display, subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else if(span.starts(with: "![")){
                if let nameStart = span.range(of: "]("){
                    var display = span[..<nameStart.lowerBound]
                    display = display[display.index(after: display.startIndex)...]
                    display = display[display.index(after: display.startIndex)...]
                    let subSpan = span[nameStart.upperBound...]
                    if let end = subSpan.range(of: ")"){
                        if(txtBuffer.count != 0){
                            ret.append(parseText(txtBuffer))
                            txtBuffer.removeAll()
                        }
                        ret.append(parseImage(display, subSpan[..<end.lowerBound]))
                        ind = end.upperBound
                        continue
                    }
                }
            }
            else{
                txtBuffer.append(text[ind])
            }
            
            ind = nextInd
        }
        if(txtBuffer.count != 0){
            ret.append(parseText(txtBuffer))
        }
        return ret
    }
    
    private func parseBold(_ text:String.SubSequence) -> MDBold{
        return MDBold(text:String(text))
    }
    
    private func parseInlineCode(_ text: String.SubSequence) -> MDInlineCode{
        return MDInlineCode(text: String(text))
    }
    
    private func parseItalic(_ text:String.SubSequence) -> MDItalic{
        return MDItalic(text: String(text))
    }
    
    private func parseStrikethrough(_ text:String.SubSequence) -> MDStrikethrough{
        return MDStrikethrough(text: String(text))
    }
    
    private func parseLink(_ name: String.SubSequence, _ address:String.SubSequence) -> MDLink{
        return MDLink(name: String(name), source: String(address))
    }
    
    private func parseImage(_ name:String.SubSequence, _ address: String.SubSequence) -> MDImage{
        return MDImage(name:String(name), source: String(address))
    }
    
    private func parseText(_ text:[Character]) -> MDText{
        let txt = String(text)
        return MDText(text: txt)
    }
}

struct MDSyntaxTree{
    var blocks:[MDBlockDelegate]
}

struct MDBold: MDInlineDelegate{
    var text:String
}

struct MDStrikethrough: MDInlineDelegate{
    var text:String
}

struct MDItalic:MDInlineDelegate{
    var text:String
}

struct MDLink: MDInlineDelegate{
    var name:String
    var source:String
}

struct MDImage: MDInlineDelegate{
    var name:String
    var source:String
}

struct MDInlineCode : MDInlineDelegate{
    var text:String
}

struct MDText: MDInlineDelegate{
    var text:String
}

struct MDHeading1: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDHeading2: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDHeading3: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDHeading4: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDHeading5: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDHeading6: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDParagraph: MDBlockDelegate{
    var inlines:[MDInlineDelegate]
}

struct MDUnorderedList: MDBlockDelegate{
    var items:[MDUnorderedListItem]
}

struct MDUnorderedListItem
{
    var inlines:[MDInlineDelegate]
    var children:[MDUnorderedListItem]
}

struct MDOrderedList: MDBlockDelegate{
    var items:[MDOrderedListItem]
}

struct MDOrderedListItem
{
    var inlines:[MDInlineDelegate]
    var children:[MDOrderedListItem]
}

struct MDCodeBlock : MDBlockDelegate{
    var lang:String
    var multilineText:String
}

struct MDHorizontalRule: MDBlockDelegate{
    
    var data:String
}

struct MDBlockQuote: MDBlockDelegate{
    
    var multilineText:String
}

struct MDTable: MDBlockDelegate{
    var headline:MDTableHeader
    var colconfigs:MDTableColConfigs
    var rows:[MDTableRow]
}

struct MDTableHeader{
    var cells:[MDTableCell]
}

struct MDTableCell{
    var inlines:[MDInlineDelegate]
}

struct MDTableColConfigs{
    var colconfigs:[MDTableColConfig]
}

enum MDTableColConfig{
    case leading
    case trailing
    case center
}

struct MDTableRow{
    var cells:[MDTableCell]
}
