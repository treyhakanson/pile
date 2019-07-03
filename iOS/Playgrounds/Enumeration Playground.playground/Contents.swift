//: Playground - noun: a place where people can play

import UIKit

// Enumerations should start with a capital letter, since it defines a new type
enum Direction {
    case Forward
    case Backward
    case Left
    case Right
}

enum AnotherDirection {
    case Forward, Backward, Left, Right
}

let direction: Direction = .Left

switch direction {
case .Forward:
    print("Go Forward!")
case .Backward:
    print("Go Backward!")
case .Left:
    print("Go Left!")
case .Right:
    print("Go Right!")
}

// you can also assign "associated values" to an enumeration value
enum Color {
    case RGB(Int, Int, Int)
    case RGBA(Int, Int, Int, Float)
    case Name(String)
}

var red = Color.RGB(255, 0, 0)
switch red {
case let .RGB(red, green, blue):
    print("Red: \(red) Blue: \(blue) Green: \(green)")
case .RGBA:
    print("It was an RGBA Color")
case var .Name(name):
    name = "Green"
    print("The color can be changed! I picked \(name)")
}

// you can also assign "raw values" which store associated values
enum ASCIICharacterControl: Character {
    case Tab = "\t"
    case Newline = "\n"
    case Carriage = "\r"
}

// venus will be of value 2, earth of 3, etc.
enum Planet: Int { // if Int was changed to String and no value was given, it would assume the raw value to be the variable name
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// can initialize from a rawValue
Planet(rawValue: 3)

enum ImplicitRawValue: String {
    case Wow, Cool, Awesome, Neat
}

ImplicitRawValue.Wow.rawValue

// an "indirect" enumeration allows for instances of the enumeration to be associated values of a case, creating a 
// recursive structure. Indirect can precede "enum" and will be applied to each case that needs it automatically, or
// if can preced each case that actually requires it
indirect enum ArithmeticExpression {
    case Number(Int)
    case Sum(ArithmeticExpression, ArithmeticExpression)
    case Multiply(ArithmeticExpression, ArithmeticExpression)
}

func evaluateAritmetic(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .Number(num):
        return num
    case let .Sum(exp1, exp2):
        return evaluateAritmetic(exp1) + evaluateAritmetic(exp2)
    case let .Multiply(exp1, exp2):
        return evaluateAritmetic(exp1) * evaluateAritmetic(exp2)
    }
}

let four = ArithmeticExpression.Number(4)
let five = ArithmeticExpression.Number(5)
let two = ArithmeticExpression.Number(2)

let sum = ArithmeticExpression.Sum(four, five)
let product = ArithmeticExpression.Multiply(sum, two)

evaluateAritmetic(product)






















