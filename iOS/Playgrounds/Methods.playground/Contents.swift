//: Playground - noun: a place where people can play

import UIKit

// instance methods in structs can change instance values if marked mutating (classes don't need the mutating keyword)
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) { // mutating functions can only be called on variable instances
        x += deltaX
        y += deltaY
    }
}

// alternatively, mutating functions can even reinitialize self
struct AltPoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = AltPoint(x: x + deltaX, y: y + deltaY)
    }
}

// enumerations can have functions too
enum Brightness {
    case Off, Low, Normal, Max
    mutating func toggle() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .Normal
        case .Normal:
            self = .Max
        case .Max:
            self = .Off
        }
    }
}

var brightness = Brightness.Normal  // brightness is initialized to Normal
brightness.toggle() // changes to Max
brightness.toggle() // changes to Off

// static can be used to write methods pertaining the the type itself, not an instance
// the keyword class can be used in place of static in a class if subclasses should be allowed to overwrite the method
// using "self" within a type method refers to the type itself, not an instance
class Animal {
    class func noise() {
        print("Blerg.")
    }
}

class Human: Animal {
}

class Dog: Animal {
    override class func noise() {
        print("Woof!")
    }
}

Animal.noise() // prints "Blerg."
Human.noise() // prints "Blerg."
Dog.noise() // prints "Woof!"
















