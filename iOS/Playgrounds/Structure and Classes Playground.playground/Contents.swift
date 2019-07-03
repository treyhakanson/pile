//: Playground - noun: a place where people can play

import UIKit

// ##############################################################################################################################
// Classes and Structures Classes and Structures Classes and Structures Classes and Structures Classes and Structures
// ##############################################################################################################################

// structures are passed by value, classes are passed by reference

// === and !== check the reference of a class

struct SomeStructure {
    var title = ""
    var tagline = ""
}

class SomeClass {
    var someStructure = SomeStructure()
    var description = ""
}

let struct1 = SomeStructure(title: "Structure 1", tagline: "Tagline 1")
var struct2 = struct1
struct2.title = "Structure 2"

// changing the title of struct 2 does not effect struct one, since it is a *copy* of it by value, not reference
print("The title of struct1 is: \(struct1.title)")
print("The title of struct2 is: \(struct2.title)")

let obj1 = SomeClass()
obj1.someStructure = struct1
obj1.description = "A class description"
var obj2 = obj1

// will give true because the objects are identical, by reference
print((obj1 === obj2) ? "The Objects are the Same." : "The Objects are Different")

// changing the description of obj2 also changes that of obj1 since they have the same reference
obj2.description = "A new description"
print("obj1 description: \(obj1.description)")

//As a general guideline, consider creating a structure when one or more of these conditions apply:
//
//  1.) The structure’s primary purpose is to encapsulate a few relatively simple data values.
//  2.) It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
//  3.) Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
//  4.) The structure does not need to inherit properties or behavior from another existing type.

// ##############################################################################################################################
// Properties Properties Properties Properties Properties Properties Properties Properties Properties Properties Properties
// ##############################################################################################################################

// if a property is able to be computed solely from other properties, it can use a custom getter and setter instead of setting
// a value initially.
// get/set are called when the dot operator is used:
// circle.center (get)
// circle.center = newCenter (set)

struct Circle {
    var radius: CGFloat
    var origin: CGPoint
    var center: CGPoint {
        get {
            let centerX = origin.x + radius
            let centerY = origin.y + radius
            return CGPoint(x: centerX, y: centerY)
        }
        set(newCenter) { // if a name for the new value isn't specified, "newValue" will be assumed
            origin.x = newCenter.x - radius
            origin.y = newCenter.y - radius
        }
    }
}

var circle = Circle(radius: 100.0, origin: CGPoint(x: 50.0, y: 50.0))
circle.center // get
circle.center = CGPoint(x: 100.0, y: 100.0) // set
circle.center // get

// read only properties have only a getter; this syntax can be simplified by now specifying get
struct SomeStruct {
    var height: Int
    var width: Int
    var depth: Int
    var volume: Int {
        return height*width*depth // read only
    }
}

// property observers cann be added to any variable (as long as it hasn't been declared lazy)
// willSet -> called BEFORE the value is stored -> gives a parameter "newValue"
// didSet -> called AFTER the value is stored -> gives a parameter "oldValue"
class AClass {
    var someValue: Int = 100 {
        willSet { // could specify a name for this value
            print("Changing value to \(newValue)")
        } didSet {
            print("Value difference \(someValue - oldValue)")
        }
    }
}

let tmp = AClass()
tmp.someValue = 200

// global constants are always computed as if they had the "lazy" parameter
// stored type properties are also computed lazily, but also didn't need to be marked "lazy"
// the "static" keyword specifies type properties
// computed stored type properties can also be declared static, using a getter

enum Enumeration {
    static var storedValue: Int = 10 // statics can be edited; all that means is that they pertain to the CLASS not an INSTANCE
    static var computedValue: Int {
        return storedValue*20
    }
}

// What is this syntax?
class BigClass {
    class var overwritable: Int {
        return 200
    }
}
BigClass.overwritable

Enumeration.storedValue = 300 // changing the static class variable
Enumeration.storedValue

// here's an example of how computed properties and static properties can be used in unison
struct ParkingGarageTicket {
    static let maxTicketCost = 25
    static var maxClientTicket = 0 // assumes that even if a client leaves that's still the max ticket
    static var numberOfClients = 0
    static var totalRevenue = 0
    var inGarage: Bool = false {
        didSet {
            let factor = (inGarage ? 1 : -1)
            ParkingGarageTicket.numberOfClients += factor
            ParkingGarageTicket.totalRevenue += (factor*clientTicket)
        }
    }
    var clientTicket: Int = 0 {
        didSet {
            inGarage = true
            if clientTicket > ParkingGarageTicket.maxTicketCost {
                clientTicket = ParkingGarageTicket.maxTicketCost
            }
            if clientTicket > ParkingGarageTicket.maxClientTicket {
                ParkingGarageTicket.maxClientTicket = clientTicket
            }
        }
    }
}


var ticket1 = ParkingGarageTicket()
ticket1.clientTicket = 10
print("ticket 1 cost: \(ticket1.clientTicket)")

var ticket2 = ParkingGarageTicket()
ticket2.clientTicket = 18
print("ticket 2 cost: \(ticket2.clientTicket)")

var ticket3 = ParkingGarageTicket()
ticket3.clientTicket = 30
print("ticket 3 cost: \(ticket3.clientTicket)")

print("number of clients: \(ParkingGarageTicket.numberOfClients)")
print("total revenue: \(ParkingGarageTicket.totalRevenue)")
print("max client ticket: \(ParkingGarageTicket.maxClientTicket)")

ticket2.inGarage = false
print("number of clients: \(ParkingGarageTicket.numberOfClients)")
print("total revenue: \(ParkingGarageTicket.totalRevenue)")
print("max client ticket: \(ParkingGarageTicket.maxClientTicket)")























