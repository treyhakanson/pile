# Mustache

## Overview

Template engine used is many different environments. Seems to be the only option available for perfect right now.

## Syntax

Mustache consists only of tags; it's logicless. Tags are constructed of double handlebars `{{}}`

use triple handlebars to unescape the output `{{{}}}`

comments are as follows `{{! Comment }}`

variables are simple `{{variable}}`

sections have a variety of uses. The main use is for things like iteration and checking if a value does of does not exist:

```html
{{! Opening tag }}
{{#users}}
    {{! 
        Will iterate over each user and
        add an h1 tag with Hello user.name
        as the text
    }}
    <h1>Hello {{name}}</h1>
{{! Closing tag }}
{{/users}}

{{! 
    Will check if person exists, then will
    execute the statement if not an iterator.
    can be used like an if statement.
}}
{{#person}}
    <h1>Hey there {{name}}</h1>
{{/person}}

{{!
    The opposite of the above, will check
    if the value does _not_ exist, or is empty
}}
{{^users}}
    <h1>There are no users.</h1>
{{/}}
```

lambas are callable objects that will be passed the text being wrapped and return the final result to be rendered. Tags will not be expanded in before being passed to the callabe; the callable should do that on its own:

mustache
```html
{{#wrapper}}
    {{name}} is here today.
{{/wrapper}}
```

corresponding values
```swift
let values: (String: Any) = [
    "name": "Trey",
    "wrapper": { () -> (String, (String) -> String) -> String
        return { text, render in
            return "<b>\(render(text))</b>"
        }
    }
]
```

final output
```html
<b>Trey is here today.</b>
```

partials are similar to `include`s in django; they inherit the existing context:

```html
{{> import-this }}
```

