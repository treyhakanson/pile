//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let view = UIView(frame: CGRectMake(0.0, 0.0, 200.0, 500.0))
XCPlaygroundPage.currentPage.liveView = view

struct SpacerColors {
    let colors: [UIColor] = [.redColor(), .blueColor(), .yellowColor(), .blackColor(), .greenColor(), .darkGrayColor(), .purpleColor()]
    subscript(index: Int) -> UIColor {
        get {
            let i = index % 7 // there will only be 8 options, don't want to go out of bounds
            return colors[i]
        }
        
    }
    
}

let spacerColors = SpacerColors()
view.backgroundColor = spacerColors[8]