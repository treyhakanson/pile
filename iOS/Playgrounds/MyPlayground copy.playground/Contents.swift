//: Playground - noun: a place where people can play

import UIKit

var num:Int = 10
var str:String = String(num)
var doub:Double = Double(str)!

var myArray = [45, 23, 77]
myArray.removeAtIndex(1)
myArray.append(myArray[0] + myArray[1])

var myDict = ["water": 0.00, "salad": 7.25, "fries": 1.99]
print("The total cost of the items is: \(myDict["water"]! + myDict["salad"]! + myDict["fries"]!)")