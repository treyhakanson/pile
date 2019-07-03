//: Playground - noun: a place where people can play

import UIKit

// subclasses will inherit all the way back to the base class (the first class)
class Animal {
    var desctiprion: String {
        return "I am alive!"
    }
    func noise() {
        print(desctiprion)
    }
}

class Dog: Animal {
    var hasFur = true
}

class Corgie: Dog {
    var isLarge = false
}

let corgie = Corgie()
corgie.desctiprion
corgie.hasFur
corgie.isLarge

// an overriden method can call the super in its body (super.someMethod())
// properties can be accessed in getters and setters (super.someValue)
// subscripts can also be accessed in the implmentation (super[value])
class Seal: Animal {
    override var desctiprion: String {
        // read-only properties can be overridden as read-write, but read-write properties cannot be made read only
        return super.desctiprion + "Bark Bark!"
    }
    
    override func noise() {
        super.noise()
        print("Arf!")
    }
}

var seal = Seal()
seal.noise()

// property observers can also be added to properties, as long as they are not constants or read-only
class SomeClass {
    var value: String = "Hello"
}

class AnotherClass: SomeClass {
    override var value: String {
        didSet {
            // could also update another value here, which is potentially useful
            print("Value was changed from \"\(oldValue)\" to \"\(value)\"")
        }
    }
}

var example = AnotherClass()
example.value = "How's it going?"


// the final keyboard prevents classes, variables, functions, etc from being overwritten
final class Example {
    final let cannotOverride = "Haha!"
}








