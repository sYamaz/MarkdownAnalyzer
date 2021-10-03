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

| markdown    | class name |  support|
|-------------|-------------|---------|
| `# h1`      | MDHeading1  | o|
| `## h2`     | MDHeading2  | o |
| `### h3`    | MDHeading3  | o |
| `#### h4`   | MDHeading4  | o |
| `##### h5`  | MDHeading5  | o |
| `###### h6` | MDHeading6  | o |
| `- item1`   | MDUnorderedList | x |
| `1. item1`  | MDOrderedList | x |
| `---`       | MDHorizontalRule | x |
| `> text`    | MDBlockQuote | x |
| ``` lang<br/>code<br/>``` | MDCodeBlock| o |
| else        | MDParagraph | o |

Following objects inherit `MDInlineDelegate` protocol

| markdown | class name| support|
|----------|------------|-------|
| `**strong**`| MDStrong | o |
| `*emphasis*`|MDEmphasis| o |
| `~~strikethrough| MDStrikethrogh| x |
| ``code`` | MDCodeSpan| o |
| `[name](source)` | MDLink| o |
|`![name](source)` | MDImage| o |
| else | MDText| o |
