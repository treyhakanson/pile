//: Playground - noun: a place where people can play

import UIKit

func numberOfLinesForString(string: String, size: CGSize, font: UIFont) -> Int {
    let textStorage = NSTextStorage(string: string, attributes: [NSFontAttributeName: font])
    
    let textContainer = NSTextContainer(size: size)
    textContainer.lineBreakMode = .ByWordWrapping
    textContainer.maximumNumberOfLines = 0
    textContainer.lineFragmentPadding = 0
    
    let layoutManager = NSLayoutManager()
    layoutManager.textStorage = textStorage
    layoutManager.addTextContainer(textContainer)
    
    var numberOfLines = 0
    var index = 0
    var lineRange : NSRange = NSMakeRange(0, 0)
    
    for (; index < layoutManager.numberOfGlyphs; numberOfLines += 1) {
        layoutManager.lineFragmentRectForGlyphAtIndex(index, effectiveRange: &lineRange)
        index = NSMaxRange(lineRange)
    }
    
    return numberOfLines
}

func numberOfLinesForStringAlt(string: String, size: CGSize, font: UIFont) -> Int {
    let textStorage = NSTextStorage(string: string, attributes: [NSFontAttributeName: font])
    
    let textContainer = NSTextContainer(size: size)
    textContainer.lineBreakMode = .ByWordWrapping
    textContainer.maximumNumberOfLines = 0
    textContainer.lineFragmentPadding = 0
    
    let layoutManager = NSLayoutManager()
    layoutManager.textStorage = textStorage
    layoutManager.addTextContainer(textContainer)
    
    var numberOfLines = 0
    var index = 0
    var lineRange : NSRange = NSMakeRange(0, 0)
    
    while(index < layoutManager.numberOfGlyphs) {
        layoutManager.lineFragmentRectForGlyphAtIndex(index, effectiveRange: &lineRange)
        index = NSMaxRange(lineRange)
        numberOfLines += 1
    }
    
    return numberOfLines
}

let size = CGSize(width: 100.0, height: 25.0)
print(numberOfLinesForString("some text yo", size: size, font: UIFont(name: "Avenir", size: 16.0)!))
print(numberOfLinesForStringAlt("some text yo", size: size, font: UIFont(name: "Avenir", size: 16.0)!))



















