
import UIKit

/// **************************************************************************
/**
 
 # typealias
 
 typealiases are useful when when dealing with complex types. The allow
 for custom definitions of types to cut down on typing and mistakes
 
*/

typealias customType = (Double, Double) -> Int

func doublesToInt(myFunction: customType) {
    // myFunction is of type (Double, Double) -> Int
}
/// **************************************************************************




/// **************************************************************************
/**
 
 # String
 
 The String class has an subscript that can be used with indexes
 
*/

let str = "Hello World"
let firstChar = str[str.startIndex]
/// **************************************************************************




/// **************************************************************************
/**
 
 # Array
 
 Arrays have a first and last property to access the first and last elements
 in an array
 
*/

let arr = ["Hello", "World", "!"]
let firstEl = arr.first
let lastEl = arr.last
/// **************************************************************************




/// **************************************************************************
/**
 # Set
 
 sets are unordered collections of hashable values
 
 useful operators (shown as non-mutating [in-place] (formerly)):
    - symmetricDifference [formSymmetricDifference] (exculsiveOr)
        returns only value that are NOT shared
    - intersection (intersect) [formIntersection]
        returns only values that ARE shared
    - subtracting [subtract]
        removes shared values
    - union [formUnion]
        combines the sets
 
*/

var people: Set<String> = ["Trey", "Dan", "Ian", "Greg", "Eileen", "Rhea", "Jack", "Brad"]
var friends: Set<String> = ["Brad", "Eileen", "Jack", "Sam", "Craig"]

people.symmetricDifference(friends)
people.intersection(friends)
people.subtracting(friends)
people.union(friends)

/// **************************************************************************




/// **************************************************************************
/**
 
 # Dictionarys
 
 Nothing really new here, but there are some operators to keep in mind:
    - dict.keys (array of keys)
    - dict.values (array of values)
    - for (key, value) in dict
 
*/

/// **************************************************************************




/// **************************************************************************
/**
 
 # Switch Cases
 
 Switch cases have insane horsepower in swift due to incredibly robust pattern
 matching
 
*/

let word = "crispy"
switch word {
case "apple"..."asymetric":
    print("Case 1")
case "banana"..."breaker":
    print("Case 2")
case "call"..."czar":
    print("Case 3")
default:
    print("No Match.")
}

let lat = 43.09278, lon = -83.58934
switch (lat, lon) {
case let (lat, lon) where lat > 0.0 && lon < 0.0:
    print("Case 1")
default:
    print("Case 2")
}
/// **************************************************************************




/// **************************************************************************
/**
    OptionSet (formerly OptionSetType)
 
    Not totally sure what these are, hopefully this gets expanded upon
 
*/

struct WaveformOptions: OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static let Pulse    = WaveformOptions(rawValue: 1)
    static let Square   = WaveformOptions(rawValue: 2)
    static let Sine     = WaveformOptions(rawValue: 4)
    static let Triangle = WaveformOptions(rawValue: 8)
    
}

let options: WaveformOptions = [.Pulse, .Square, .Sine]
print(options)
/// **************************************************************************




/// **************************************************************************
/**
 
 if-case and for-case-in
 
 Brings the pattern matching of the switch statement to other control flow
 operators; good for matching one specific case and iterating/executing
 
 */

//if case Enum.Case(let a) = b {
//    print("\(a)")
//}

//for case let Enum.Case(a, b, c) in arr where b < 10 {
//    // code
//}
/// **************************************************************************




/**
 extensions can implement protocols (Swift considers itself a Protocol Oriented Language, not an Object Oriented Language technically)
*/

protocol Randomize {
    func shuffle<T>(_: T)
}

extension Collection where Self.Iterator.Element: Comparable {
    func shuffle<T>(_: T) {
        // do something
    }
}











