//: Playground - noun: a place where people can play

import UIKit

var strs: [Int] = [1, 2, 3, 4, 5]

var huh = strs.map { $0 }
var hm = strs
strs.popLast()

print(strs)
print(hm)
print(huh)