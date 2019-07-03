import UIKit

// Functions as Variables
func addTwoNumbers(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let anotherFunction = addTwoNumbers

let sum1 = addTwoNumbers(1, 3)
let sum2 = anotherFunction(1, 3)

// Functions as Arguments
func calculateAndPrint(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("The Result is: \(function(a, b))")
}

calculateAndPrint(addTwoNumbers, 1, 2)


// Functions as Return Types
func addAndPrint(a: Int, _ b: Int) {
    print("Sum is: \(a + b)")
}

func subtractAndPrint(a: Int, _ b: Int) {
    print("Difference is: \(a - b)")
}

func printResult(_ shouldAdd: Bool) -> (Int, Int) -> Void {
    return (shouldAdd) ? addAndPrint : subtractAndPrint
}

let printFunc = printResult(false)
printFunc(19, 15)

func pickAFunction(functionId id: Int) -> (Int, Int) -> Int? {
    switch id {
    case 0:
        func addNumbers(a: Int, _ b: Int) -> Int { return a + b }
        return addNumbers
    case 1:
        func subtractNumbers(a: Int, _ b: Int) -> Int { return a - b }
        return subtractNumbers
    default:
        func printNumbers(a: Int, _ b: Int) -> Int? { print("The Numbers are:\n\t\(a)\n\t\(b)"); return nil }
        return printNumbers
    }
}

let myFunction = pickAFunction(functionId: 10)
myFunction(10, 21)

// What the actual fuck
func megaFunction(anotherFunction: (function1: (Int, Int) -> Int, function2: (Int, Int) -> Int) -> (function1: (Int, Int) -> Int, function2: (Int, Int) -> Int) -> Int) {
    
}













