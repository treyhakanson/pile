//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let view = UIView(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))
view.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = view

let circleView = UIView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0))
circleView.backgroundColor = .lightGrayColor()
circleView.layer.cornerRadius = circleView.frame.height/2.0
circleView.center = view.center
circleView.clipsToBounds = true
view.addSubview(circleView)

let basicAnimation = CABasicAnimation(keyPath: "position.y")
basicAnimation.fromValue = 0.0
basicAnimation.toValue = -circleView.frame.height
basicAnimation.duration = 2.0
basicAnimation.removedOnCompletion = false
basicAnimation.fillMode = kCAFillModeForwards

let fillLayer = CAShapeLayer()
let path = UIBezierPath(rect: CGRectMake(0.0, circleView.frame.height, circleView.frame.width, circleView.frame.height))
fillLayer.path = path.CGPath
fillLayer.fillColor = UIColor.blueColor().CGColor
fillLayer.addAnimation(basicAnimation, forKey: nil)
circleView.layer.addSublayer(fillLayer)



