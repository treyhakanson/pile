//: Playground - noun: a place where people can play

/* 
    Multi-line
    comment
*/

import UIKit

// Explicitly declaring variables is probably a good practice for readability
var str:String = "Hello, playground"

var age:Int = 20
print("I am \(age) old")

var num1:Int = 2
var num2:Int = 4
var num3:Int = num1 + num2
print("The sum of the numbers is \(num3)")

num1 = 1
num2 = 8
num3 = num1/num2
var num4:Double = 1.0/8.0

// Dictionaries
var myDictionary = ["key1": "value1" ,"key2": "value2"]
// or
var myStringDictionary: [String: String] = ["stringKey": "valueString"]
print(myDictionary["key1"]!)
myDictionary.count
myDictionary["keyToAdd"] = "valueToAdd"
myDictionary.updateValue("value1Alt", forKey: "key1")
print(myDictionary)
myDictionary.removeValueForKey("key1")
print(myDictionary)
myDictionary.isEmpty

var a = 3
var b = 3
var c = 5

if a == 3{
    print("a equals 3")
} else if b == 3{
    print("b equals 3")
} else{
    print("neither a nor b equals 3")
}

for var i=0; i < 4; i++ {
    print("The loop has run \(i) times")
}

var myArray = ["Apple", "Milk", "Meat", "Pie"]
for value in myArray {
    print("The value in the array is \(value)")
}

var ages: [String: Int] = ["Trey": 20, "Grant": 17, "Mckenna": 22]
for (key, value) in ages {
    print("\(key) is \(value) years old")
}

var j = 0
while j < 4 {
    print("\(j)")
    j++
}

j = 0
repeat {
    print("\(j)")
    j++
}while j < 4















