//: Playground - noun: a place where people can play

import UIKit

if let font = UIFont(name: "Helvetica", size: 16) {
    let fontAttributes = [NSFontAttributeName: font]
    let myText = "Hello there, my name is trey hakanson"
    let size = (myText as NSString).sizeWithAttributes(fontAttributes)
    
    size.width
    size.height
    
    let labelWidth: CGFloat = 259.0
    let labelLines: CGFloat = CGFloat(ceil(Float(size.width/labelWidth)))
    let height =  CGFloat(labelLines*size.height)
    
}