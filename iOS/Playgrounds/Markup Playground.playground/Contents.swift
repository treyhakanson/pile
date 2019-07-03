import UIKit
import PlaygroundSupport

/*
 General Notes on markup:
 
 Markup can be used to not only describe functions and such, but to add 
 information to the quick help menu of the bit in question
    
 Some of the markup is more useful in playgrounds, mainly the single line
 markup comments (are cool when a playground is rendered in document mode,
 but don't really do anything in a project)
 
*/



/**
 
 This is a multiline markup comment
 
*/



//: this is a single line markup comment



/**
 
 # First Level Header
 ## Second Level Header
 ### Third Level Header
 
 Also First Level
 ================
 
 Also Second Level
 -----------------
 
 The description of the function will encompass any text in this
 block that does not use on of the specificed keywards and a colon
 
 anything with backquotes will look like `code`
 backquotes can also escape characters like `#`
 
 *italics*
 **bold**
 
 _also italics_
 __also bold__
 
 *can even **nest** span elements*
 
 /// this
 /// will appear
 /// all on one line
 
 * This will render in the
 - Quick Help Menu as
 + A bulleted list
 * asterisk, plus, or hyphen can be used, and changing
 * symbol will immediately create a new list
 
 * can also
    * nest
        * lists
 
 1. This renders as an ordered list
 1. This will
    show as only
    one item in
    the list
 1. The numbers increment automatically, so you can always
    just use 1; other numbers (2, 3) can be used for clarity
    if desired
 
 
 1. leaving two success blanks lines will create a new list
 
 
 47. Can also change the starting number
 
 
 1. Lists can be nested
    1. Like this
        func example() {
        }
    1. And can contain nested code due to beginning with a keyword and the indentation
        being at least 4 spaces or a tab in from the previous line
        ````
        for _ in 0...5 {
        }
        ````
    1. But 4 backquotes encompassing the code block also works
 1. Like shown above
 
 here's a [link](https://google.ocm)
 
 there are 3 different ways to make a horizontal line
 
 1. hyphen (at least 3)
 ---
 
 2. asterisk (at least 3)
 ***
 
 3. underscore (at least 3)
 ___
 
 - important: flags information that needs to be read
 - returns: describes what is returned by the function
 - parameters:
    - param1: description of param
    - param2: description of param
 - throws: some error
 
 - author: Trey Hakanson
 - version: 0.1
 
*/

func affectedByMarkup(param1: Any, param2: Any) throws -> Any {
    return "Cool"
}

//: here's a clickable [link](https://google.com)
//: can link to an asset too ![A Really Neat Asset](logo.png)
//: can even embed an mp4 ![A Cool Video](damn.mp4)


// here's an example of some actually markup

/**
 
 ## Squared Array Function
 
 takes in an array and returns an array where each of the elements
 are squared.
 
 for future revisions
 ---
 * make the function **generic**
     * through an error for **non-numeric** types
 * allow variadic input
 
 - important: This function does *not* manipulate the original array. 
    see `squareArray` instead.
 - parameters:
    - arr: an array of type `Int`
 - returns: an array of type `Int`
 
 - author: Trey Hakanson
 - version: 0.1
 
 */

func squaredArray(arr: [Int]) -> [Int] {
    return arr.map { $0^2 }
}







