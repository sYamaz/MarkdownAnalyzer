# MarkdownAnalyzer

Analyze markdown text data and convert to object tree

## Usage

```swift
let parser = MarkdownAnalyzer()
let sampleText = "# H1\n\nThis is sample text"
let objectTree = parser.parse(sampleText)
```

`objectTree` is `MDSyntaxTree` type.

## Objects

All objects inherit `MDNodeDelegate` protocol.

Following objects inherit `MDBlockDelegate` protocol. 

| markdown    | struct name | 
|-------------|-------------|
| `# h1`      | MDHeading1  |
| `## h2`     | MDHeading2  |
| `### h3`    | MDHeading3  |
| `#### h4`   | MDHeading4  |
| `##### h5`  | MDHeading5  |
| `###### h6` | MDHeading6  |
| `- item1`   | MDUnorderedList |
| `1. item1`  | MDOrderedList |
| `---`       | MDHorizontalRule |
| `> text`    | MDBlockQuote |
| ``` lang<br/>code<br/>``` | MDCodeBlock|
| else        | MDParagraph |

Following objects inherit `MDInlineDelegate` protocol

| markdown | struct name|
|----------|------------|
| `**bold**`| MDBold |
| `*italic*`|MDItalic|
| `~~strikethrough| MDStrikethrogh|
| ``code`` | MDInlineCode|
| `[name](source)` | MDLink|
|`![name](source)` | MDImage|
| else | MDText|
