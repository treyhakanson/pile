//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0, 0, 375, 675))
let page = XCPlayground.XCPlaygroundPage
page.currentPage.liveView = container

let card = UIView(frame: CGRectMake(0, 0, 300, 300))
card.backgroundColor = .whiteColor()
card.layer.cornerRadius = 8.0
card.layer.masksToBounds = true
card.center = container.center

class SuperOverlay: CAShapeLayer {
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        
        let flashDuration = 2.0
        let flashDelay = 1.5
        let largeHeight: CGFloat = 65.0
        let smallHeight: CGFloat = 15.0
        let buffer: CGFloat = 10.0
        let cardDiag = pythag(card.frame.width, card.frame.height)
        
        self.path = UIBezierPath(rect: CGRect(x: 0.0, y: 0.0, width: card.frame.width, height: card.frame.height)).CGPath
        self.fillColor = UIColor.clearColor().CGColor
        
        let flashMovement = CABasicAnimation(keyPath: "position")
        flashMovement.additive = true
        flashMovement.toValue =  NSValue(CGPoint: CGPoint(x: card.frame.width*2.0, y: -card.frame.height*2.0))
        flashMovement.repeatCount = Float.infinity
        flashMovement.beginTime = flashDelay
        flashMovement.duration = flashDuration
        
        let flashAnimation = CAAnimationGroup()
        flashAnimation.animations = [flashMovement/*, alphaAnimation*/]
        flashAnimation.duration = flashDuration + flashDelay
        flashAnimation.repeatCount = Float.infinity
        
        let rectangleLayerLarge = CAShapeLayer()
        rectangleLayerLarge.fillColor = UIColor(red: 252.0/255.0, green: 212.0/255.0, blue: 49.0/255.0, alpha: 0.25).CGColor
        let rectanglePathLarge = UIBezierPath(rect: CGRect(x: 0.0, y: cardDiag/2.0, width: cardDiag, height: largeHeight))
        rectanglePathLarge.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/4.0)))
        rectangleLayerLarge.path = rectanglePathLarge.CGPath
        
        let rectangleLayerSmall = CAShapeLayer()
        rectangleLayerSmall.fillColor = UIColor(red: 252.0/255.0, green: 212.0/255.0, blue: 49.0/255.0, alpha: 0.25).CGColor
        let rectanglePathSmall = UIBezierPath(rect: CGRect(x: 0.0, y: cardDiag/2.0 + largeHeight + buffer, width: pythag(card.frame.width, card.frame.height), height: smallHeight*2.0))
        rectanglePathSmall.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/4.0)))
        rectangleLayerSmall.path = rectanglePathSmall.CGPath
        
        let rectangleLayerBreaker = CAShapeLayer()
        rectangleLayerBreaker.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.35).CGColor
        let rectanglePathBreaker = UIBezierPath(rect: CGRect(x: 0.0, y: cardDiag/2.0 + buffer*1.5, width: cardDiag, height: smallHeight*1.5))
        rectanglePathBreaker.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI/4.0)))
        rectangleLayerBreaker.path = rectanglePathBreaker.CGPath
        
        let badgeHeight: CGFloat = 45.0
        let badgeWidth: CGFloat = 45.0
        let superBadge = CAShapeLayer()
        superBadge.fillColor = UIColor(red: 252.0/255.0, green: 212.0/255.0, blue: 49.0/255.0, alpha: 0.75).CGColor
        superBadge.strokeStart = 0.0
        superBadge.strokeEnd = 2.0*CGFloat(M_PI)
        superBadge.strokeColor = UIColor(red: 242.0/255.0, green: 202.0/255.0, blue: 39.0/255.0, alpha: 0.75).CGColor
        superBadge.lineWidth = 2.5
        let superBadgePath = UIBezierPath(ovalInRect: CGRect(x: buffer, y: card.frame.height - badgeHeight - buffer, width: badgeWidth, height: badgeHeight))
        superBadge.path = superBadgePath.CGPath
        
        let superText = CATextLayer()
        superText.frame = CGRectMake(buffer, card.frame.height - badgeHeight - buffer, badgeWidth, badgeHeight)
        superText.string = "S"
        superText.font = CTFontCreateWithName("Avenir", 0.0, nil)
        superText.fontSize = 0.75*badgeHeight
        superText.foregroundColor = UIColor.whiteColor().CGColor
        superText.wrapped = true
        superText.alignmentMode = kCAAlignmentCenter
        
        rectangleLayerLarge.addAnimation(flashAnimation, forKey: nil)
        rectangleLayerSmall.addAnimation(flashAnimation, forKey: nil)
        rectangleLayerBreaker.addAnimation(flashAnimation, forKey: nil)
        
        self.addSublayer(rectangleLayerLarge)
        self.addSublayer(rectangleLayerSmall)
        self.addSublayer(rectangleLayerBreaker)
        self.addSublayer(superBadge)
        superBadge.addSublayer(superText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func pythag(leg1: CGFloat,_ leg2: CGFloat) -> CGFloat {
        return sqrt(pow(leg1, 2.0) + pow(leg2, 2.0))
    }
    
}

let goldOverlay = SuperOverlay(layer: CAShapeLayer())

container.addSubview(card)
card.layer.addSublayer(goldOverlay)









