//: Playground - noun: a place where people can play

import UIKit

let parent = UIView(frame: CGRectMake(0.0, 0.0, 400.0, 700.0))
let view = UIView(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

let minimumThreshold: CGFloat = 0.5
var scale: CGFloat = 2.0

let newSize = view.frame.height * scale
let allowableSize = min(parent.frame.height, parent.frame.width)
let maximumScale: CGFloat = allowableSize/view.frame.height


if scale < minimumThreshold {
    print("size is too small")
    scale = minimumThreshold
}

if newSize > allowableSize {
    print("size is too large")
    scale = maximumScale
}