import UIKit

var names = ["Trey", "Ian", "Greg", "Dan", "Nugeen"]

// all closure syntax variations
func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let standardSort = names.sorted { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

// func is a type of close, so can feed backwards in as the argument
let funcSort = names.sorted(by: backwards)

// can also write a closure on the spot
let explicitSort = names.sorted { (s1: String, s2: String) -> Bool in return s1 > s2 }

// since names is of type string, the closure must take 2 string arguments so the types can be inferred
let implicitSort = names.sorted { s1, s2 in return s1 > s2 }

// the return keyword can be ommitted for a single expression closure (it's implicit that a value must be returned in this case)
let superImplicitSort = names.sorted {s1, s2 in s1 > s2}

// $0, $1, $2, ... $n are shorthand and can be used to reference the closure arguments implicitly
let ultraImplicitSort = names.sorted { $0 > $1 }

// don't even need to include the shorthand notations here because '>' takes a left hand and a right hand argument,
// and it is assumed that the first argument will be compared to the second in this case
let wtfSort = names.sorted(by: >)

// Summary of closure variations
let standard = names.sorted{ (s1: String, s2: String) -> Bool in
    return s1 > s2
}

let compact = names.sorted(by: >)

// trailing closures
names.sort() {
    $0 > $1
}

names.sort {
    $0 > $1
}

// map example
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10 // key here is that 10 is an integer, so this division rounds down
    }
    return output
}

// closures maintain variables even after context ceases to exist
let testNumber = 0

func makeIncrementer(numberToIncrement number: Int) -> () -> Int {
    var number = number
    
    func incrementer() -> Int {
        number += 1
        return number
    }
    
    return incrementer
    
}

let incrementer = makeIncrementer(numberToIncrement: testNumber)
incrementer()
incrementer()
incrementer()
incrementer()

print(names.remove(at: 0))


func wrapper() -> (String, (String) -> String) -> String {
    return { text, render in
        return "<b>\(render(text))</b>"
    }
}


let obj: [String: Any] = [
    "name": "Trey",
    "wrapper": wrapper
]

let fromObj = (obj["wrapper"] as! () -> (String, (String) -> String) -> String)()
























