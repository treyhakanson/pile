//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Container {
    var height: Int
    var width: Int
    var depth: Int
    var volume: Int {
        get {
            return width*depth*height
        }
    }
}

var cont = Container(height: 100, width: 100, depth: 100)
cont.volume
cont.height = 3000
cont.volume