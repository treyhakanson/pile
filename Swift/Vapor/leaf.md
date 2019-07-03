# Leaf

## Overview

Leaf is a simple templating language

## Basics

Leaf tags are made up of 4 elements:

- Token: # is the Token
- Name: A string that identifies the tag
- Parameter List: () May accept 0 or more arguments
- Body (optional): {} Must be separated from the Parameter List by a space

`#` cannot be escaped; us `#()` or `#raw() {}` to output a `#` character into a document

tags can be chained; this means that if the previous tag fails, it will still be given a chance to run. Tags are chained using `##`:

```html
#if(hasFriends) ##embed("getFriends")
```

Leaf comments are specified with `///`

## Built-in Tags

`#()` effectively escapes the `#` character

`#raw() {}` unescaped output:

```html
#raw() { <a href="#link">Link</a> }
```

`#(varName)` to output a variable

`#equal(lhs, rhs) {}` to check for equality

`#loop(array, "index") {}` to loop over an object

`#index(object, index: Int|String) {}` to retrieve an index

if else control flow:

```html
#if(bool) {
  some text
} ##if(bool) {
  some other text
} ##else() {
  some default text
}
```

importing, exporting, extending, etc (omit the `.leaf` extension):

```html
/// base.leaf
<!DOCTYPE html>
#import("html")

/// html.leaf
#extend("base")

#export("html") { <html>#embed("body")</html> }

/// body.leaf
<body></body>
```

## Creating Custom Tags

```swift
class Index: BasicTag {
  let name = "index"

  func run(arguments: [Argument]) throws -> Node? {
    guard
      arguments.count == 2,
      let array = arguments[0].value?.nodeArray,
      let index = arguments[1].value?.int,
      index < array.count
    else { return nil }
        return array[index]
    }
}
```

```swift
if let leaf = drop.view as? LeafRenderer {
    leaf.stem.register(Index())
}
```