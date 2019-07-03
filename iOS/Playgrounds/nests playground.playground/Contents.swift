//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

let container = UIView(frame: CGRectMake(0.0, 0.0, 375.0, 675.0))
container.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = container

class BannerShape: CAShapeLayer {
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(layer: AnyObject, color: UIColor, hasShadow: Bool, shadowColor: UIColor?) {
        super.init(layer: layer)
        self.path = UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, layer.frame.width, layer.frame.height), byRoundingCorners: [.BottomRight, .TopRight], cornerRadii: CGSize(width: layer.frame.height/2.0, height: layer.frame.height/2.0)).CGPath
        self.fillColor = color.CGColor
        if hasShadow {
            let color = (shadowColor != nil) ? shadowColor! : UIColor.redColor().colorWithAlphaComponent(0.50)
            let shadow = HalfBannerShape(layer: layer, color: color)
            self.addSublayer(shadow)
        }
    }
    
    func addText(text: String, fontSize: CGFloat, width: CGFloat, height: CGFloat, offsetX: CGFloat, offsetY: CGFloat) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRectMake(offsetX, (offsetY - fontSize/2.0), width, height)
        textLayer.string = text
        textLayer.font = CTFontCreateWithName("Avenir", 0.0, nil)
        textLayer.fontSize = fontSize
        textLayer.foregroundColor = UIColor.blackColor().CGColor
        textLayer.contentsScale = UIScreen.mainScreen().scale
        textLayer.wrapped = true
        textLayer.alignmentMode = kCAAlignmentLeft
        self.addSublayer(textLayer)
        
    }
    
    func animateInRight(initialPos from: CGFloat, finalPos to: CGFloat) {
        let animation = CASpringAnimation()
        animation.duration = animation.settlingDuration
        animation.beginTime = CACurrentMediaTime()
        animation.fromValue = from
        animation.toValue = to
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        self.addAnimation(animation, forKey: "position.x")
    }
    
}

class CircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, color: UIColor, buttonImage: UIImage?, hasShadow: Bool, shadowColor: UIColor?) {
        super.init(frame: frame)
        
        let buttonBackgroundLayer = CAShapeLayer()
        buttonBackgroundLayer.path = UIBezierPath(ovalInRect: frame).CGPath
        buttonBackgroundLayer.fillColor = color.CGColor
        self.layer.addSublayer(buttonBackgroundLayer)
        
        if hasShadow {
            let shadow = CAShapeLayer()
            shadow.path = UIBezierPath(rect: frame).CGPath
            shadow.frame.origin.x += frame.width/2.0
            shadow.fillColor = (shadowColor != nil) ? shadowColor!.CGColor : UIColor.whiteColor().colorWithAlphaComponent(0.50).CGColor
            self.layer.addSublayer(shadow)
        }
        
    }
    
}

class HalfBannerShape: CAShapeLayer {
    override init(layer: AnyObject) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(layer: AnyObject, color: UIColor) {
        super.init(layer: layer)
        self.path = UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, layer.frame.width, layer.frame.height), byRoundingCorners: .BottomRight, cornerRadii: CGSize(width: layer.frame.height/2.0, height: layer.frame.height/2.0)).CGPath
        self.frame = CGRectMake(0.0, 0.0, layer.frame.width, layer.frame.height/2.0)
        self.fillColor = color.CGColor
        
    }
    
}

let bannerHeight: CGFloat = 50.0
let bannerWidthLarge: CGFloat = container.frame.width*0.75
let textBuffer: CGFloat = 20.0
let bannerColor = UIColor(netHex: 0xD5D5D5)

let layer = CAShapeLayer()
layer.frame = CGRectMake(-container.frame.width*0.25, 0.0, bannerWidthLarge, bannerHeight)
let banner = BannerShape(layer: layer, color: bannerColor, hasShadow: true, shadowColor: nil)
banner.addText("Comments: \t16", fontSize: 16.0, width: bannerWidthLarge, height: bannerHeight, offsetX: container.frame.width*0.25 + textBuffer, offsetY: bannerHeight/2.0)
container.layer.addSublayer(banner)
banner.animateInRight(initialPos: -bannerWidthLarge, finalPos: -container.frame.width*0.25)

let button = CircleButton(frame: CGRectMake(100.0, 100.0, 100.0, 100.0), color: .blueColor(), buttonImage: nil, hasShadow: true, shadowColor: nil)
container.addSubview(button)



let width: CGFloat = 200.0
let height: CGFloat = 85.0

let path = UIBezierPath()
path.moveToPoint(CGPoint(x: 0.0, y: -height))
path.addLineToPoint(CGPoint(x: width, y: -height))
path.addQuadCurveToPoint(CGPoint(x: width*1.0/2.5, y: 0.0), controlPoint: CGPoint(x: width*16.0/17.0, y: -height/20.0))
path.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
path.closePath()
path.fill()

let testShape = CAShapeLayer()
testShape.fillColor = UIColor.redColor().CGColor
testShape.position = CGPoint(x: 50.0, y: 250.0)
testShape.path = path.CGPath
container.layer.addSublayer(testShape)














