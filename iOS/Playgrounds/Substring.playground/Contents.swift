//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
PlaygroundPage.current.liveView = view

var images: [UIImage?] = [nil, nil, nil] {
    didSet {
        if !(images.contains { $0 == nil }) {
            print("Loading Images")
            for (i, _) in images.enumerated() {
                print("Loading Image \(i)")
            }
        } else {
            print("Failed.")
        }
    }
}

images[0] = UIImage()
images[1] = UIImage()
images[2] = UIImage()


var json: [String: AnyObject?] = [:]
json["foo"] = "bar" as AnyObject
json["foo1"] = "bar1" as AnyObject
json["foo2"] = "bar2" as AnyObject
json["foo"] = nil   // setting key to nil removes it from the dictionary, which makes sense since trying to 
                    // read this key would get nil (or language equivalent) when trying to access this key

json // "foo" is not a key

let str = String(repeating: "#", count: 15)



protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

let gen = LinearCongruentialGenerator()
gen.random()
gen.random()














