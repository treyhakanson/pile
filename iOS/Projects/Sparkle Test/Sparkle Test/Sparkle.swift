//
//  SparkleImage.swift
//  Sparkle Test
//
//  Created by David Hakanson on 4/14/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class Sparkle {
    
    var image:UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    init() {
        self.image = UIImage(named: "twinkle_image.png")!
    }
    
    func mutateSparkleImage(newColor color: UIColor?, newScale scale: CGFloat?, newAlpha alpha: CGFloat?) {
        if let newColor: UIColor = color { self.changeImageColor(newColor: newColor) }
        if let newScale: CGFloat = scale { self.changeImageScale(newScale: newScale) }
        if let newAlpha: CGFloat = alpha { self.changeImageAlpha(newAlpha: newAlpha) }
    }
    
    func changeImageColor(newColor color: UIColor) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, false, self.image.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0.0, self.image.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        
        let rect = CGRectMake(0.0, 0.0, self.image.size.width, self.image.size.height)
        CGContextClipToMask(context, rect, self.image.CGImage)
        CGContextFillRect(context, rect)
        
        self.image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
    }
    
    func changeImageScale(newScale scale: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, false, scale)
        self.image.drawInRect(CGRect(origin: CGPointZero, size: self.image.size))
        
        self.image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
    }
    
    func changeImageAlpha(newAlpha alpha: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, false, self.image.scale)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetAlpha(context, alpha)
        self.image.drawInRect(CGRect(origin: CGPointZero, size: self.image.size))
        
        self.image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
    }
    
}
