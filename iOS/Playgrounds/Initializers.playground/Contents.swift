//: Playground - noun: a place where people can play

import UIKit

// constants can be set in initializers
struct SomeStruct {
    let value: Int
    init(value: Int) {
        self.value = value
    }
}


// can call other initializers from an initializer
struct Oval {
    var origin = CGPoint()
    var size = CGSize()
    
    init() {  }
    
    init(origin: CGPoint, size: CGSize) {
        self.origin = origin
        self.size = size
    }
    
    init(center: CGPoint, size: CGSize) {
        let originX = center.x - size.width/2.0
        let originY = center.y - size.height/2.0
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }

}

// Swift initializers follow a "two phase" process, and the compiler performs 4 checks
// Check 1:
//      - 

class Vehicle {
    var numberOfWheels: Int = 0
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}


class Rectangle {
    var height: Int
    var width: Int
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
    }
    
    convenience init() {
        self.init(height: 0, width: 0)
    }
    
}

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unamed]")
    }
    
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
}

let ingredient = RecipeIngredient()
ingredient.quantity
ingredient.name


















