//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0.0, 0.0, 600.0, 600.0))
container.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = container

let hatchliMain = UIColor(red: 160.0/255.0, green: 230.0/255.0, blue: 225.0/255.0, alpha: 1.0)

let circle = UIView(frame: CGRectMake(0.0, 0.0, 400.0, 400.0))
circle.backgroundColor = hatchliMain
circle.layer.cornerRadius = circle.frame.height/2.0
circle.center = container.center
container.addSubview(circle)

class TestLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor, text: String, angle: CGFloat) {
        let frame = CGRectMake(0.0, 0.0, 0.0, 0.0)
        super.init(frame: frame)
        self.attributedText = NSAttributedString(string: text, attributes: [NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: 24.0)!, NSForegroundColorAttributeName : color])
        self.sizeToFit()
        self.transform = CGAffineTransformMakeRotation(angle)
        self.layer.anchorPoint = CGPointMake(1.0, 0.5)
    }
    
}

let circleSize = 400.0

// dimensions are initially from origin of rect (upper left hand corner)
let menuItems: [String] = ["All", "Technology", "Food", "Sports", "Music", "Art", "Fashion", "Publishing", "Social", "Business", "Misc."]
let spacingAngle: CGFloat = CGFloat(2*M_PI)/CGFloat(menuItems.count)

for i in 0..<menuItems.count {
    let angle: CGFloat = spacingAngle*CGFloat(i)
    
    let label = TestLabel(color: .whiteColor(), text: menuItems[i], angle: angle)
    
    let z: CGFloat = circle.frame.height/4.0 - label.frame.width/2.5
    let x: CGFloat = floor(z*cos(angle))
    let y: CGFloat = floor(z*sin(angle))
    
    label.layer.position = CGPointMake(circle.frame.width/2.0 - x, circle.frame.height/2.0 - y)
    circle.addSubview(label)
    
}

let animation = CABasicAnimation(keyPath: "transform.rotation")
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
animation.beginTime = CACurrentMediaTime()
animation.duration = 10.0
animation.fromValue = CGFloat(0.0)
animation.toValue = CGFloat(2*M_PI)

//circle.layer.addAnimation(animation, forKey: nil)

















