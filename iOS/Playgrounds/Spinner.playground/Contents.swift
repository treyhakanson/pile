//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 600.0))
XCPShowView("container view", view: container)

//let spinnerContainerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
//let outerSpinnerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: spinnerContainerView.frame.width, height: spinnerContainerView.frame.height))
//let innerSpinnerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: spinnerContainerView.frame.width/2.0, height: spinnerContainerView.frame.height/2.0))
//
//let outerSpinnerLayer = CAShapeLayer()
//outerSpinnerLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: outerSpinnerView.frame.width, height: outerSpinnerView.frame.height)).CGPath
//outerSpinnerLayer.lineWidth = 10.0
//outerSpinnerLayer.strokeStart = 0.0
//outerSpinnerLayer.strokeEnd = 0.45
//outerSpinnerLayer.lineCap = kCALineCapRound
//outerSpinnerLayer.fillColor = UIColor.clearColor().CGColor
//outerSpinnerLayer.strokeColor = UIColor.redColor().CGColor
//
//let outerStrokeAnimation = CABasicAnimation()
//outerStrokeAnimation.duration = 0.75
//outerStrokeAnimation.fromValue = 0.0
//outerStrokeAnimation.toValue = 0.45
//outerStrokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//outerStrokeAnimation.fillMode = kCAFillModeForwards
//outerStrokeAnimation.removedOnCompletion = false
//outerStrokeAnimation.autoreverses = true
//outerStrokeAnimation.repeatCount = Float.infinity
//outerSpinnerLayer.addAnimation(outerStrokeAnimation, forKey: "strokeEnd")
//
//let outerRotationAnim = CABasicAnimation()
//outerRotationAnim.beginTime = CACurrentMediaTime()
//outerRotationAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//outerRotationAnim.fromValue = 0.0
//outerRotationAnim.toValue = CGFloat(2.0*M_PI)
//outerRotationAnim.duration = 1.0
//outerRotationAnim.autoreverses = true
//outerRotationAnim.fillMode = kCAFillModeForwards
//outerRotationAnim.removedOnCompletion = false
//outerRotationAnim.repeatCount = Float.infinity
//
//let innerSpinnerLayer = CAShapeLayer()
//innerSpinnerLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: innerSpinnerView.frame.width, height: innerSpinnerView.frame.height)).CGPath
//innerSpinnerLayer.lineWidth = 10.0
////innerSpinnerLayer.strokeStart = 0.0
//innerSpinnerLayer.strokeEnd = 0.0
//innerSpinnerLayer.lineCap = kCALineCapRound
//innerSpinnerLayer.fillColor = UIColor.clearColor().CGColor
//innerSpinnerLayer.strokeColor = UIColor.redColor().CGColor
//
//let innerStrokeAnimation = CABasicAnimation()
//innerStrokeAnimation.duration = 1.0
//innerStrokeAnimation.fromValue = 0.0
//innerStrokeAnimation.toValue = 0.45
//innerStrokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//innerStrokeAnimation.fillMode = kCAFillModeForwards
//innerStrokeAnimation.removedOnCompletion = false
//innerStrokeAnimation.autoreverses = true
//innerStrokeAnimation.repeatCount = Float.infinity
//innerSpinnerLayer.addAnimation(innerStrokeAnimation, forKey: "strokeEnd")
//
//let innerRotationAnimation = CABasicAnimation()
//innerRotationAnimation.beginTime = CACurrentMediaTime()
//innerRotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//innerRotationAnimation.fromValue = M_PI
//innerRotationAnimation.toValue = CGFloat(3.0*M_PI)
//innerRotationAnimation.duration = 0.75
//innerRotationAnimation.autoreverses = true
//innerRotationAnimation.fillMode = kCAFillModeForwards
//innerRotationAnimation.removedOnCompletion = false
//innerRotationAnimation.repeatCount = Float.infinity
//
//outerSpinnerView.center = spinnerContainerView.center
//innerSpinnerView.center = spinnerContainerView.center
//
//spinnerContainerView.addSubview(outerSpinnerView)
//spinnerContainerView.addSubview(innerSpinnerView)
//
//innerSpinnerView.layer.addSublayer(innerSpinnerLayer)
//innerSpinnerView.layer.addAnimation(innerRotationAnimation, forKey: "transform.rotation")
//
//outerSpinnerView.layer.addSublayer(outerSpinnerLayer)
//outerSpinnerView.layer.addAnimation(outerRotationAnim, forKey: "transform.rotation")
//
//spinnerContainerView.center = container.center
//container.addSubview(spinnerContainerView)
//
//outerSpinnerLayer.strokeColor = UIColor.yellowColor().CGColor
//

let greenMain = UIColor.greenColor()

//
//  SpinnerView.swift
//  hatch1.2
//
//  Created by David Hakanson on 4/16/16.
//  Copyright © 2016 Gain llc. All rights reserved.
//

import UIKit

class SpinnerView: UIView {
    
    let outerSpinnerLayer = CAShapeLayer()
    let innerSpinnerLayer = CAShapeLayer()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let outerSpinnerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height))
        let innerSpinnerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width/2.0, height: self.frame.height/2.0))
        
        outerSpinnerLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: outerSpinnerView.frame.width, height: outerSpinnerView.frame.height)).CGPath
        outerSpinnerLayer.lineWidth = 10.0
        outerSpinnerLayer.strokeEnd = 0.0
        outerSpinnerLayer.lineCap = kCALineCapRound
        outerSpinnerLayer.fillColor = UIColor.clearColor().CGColor
        outerSpinnerLayer.strokeColor = greenMain.CGColor
        
        let outerStrokeAnimation = CASpringAnimation()
        outerStrokeAnimation.duration = outerStrokeAnimation.settlingDuration
        outerStrokeAnimation.stiffness = 5.0
        outerStrokeAnimation.fromValue = 0.0
        outerStrokeAnimation.toValue = 0.70
        outerStrokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        outerStrokeAnimation.fillMode = kCAFillModeForwards
        outerStrokeAnimation.removedOnCompletion = false
        outerStrokeAnimation.autoreverses = true
        outerStrokeAnimation.repeatCount = Float.infinity
        outerSpinnerLayer.addAnimation(outerStrokeAnimation, forKey: "strokeEnd")
        
        let outerRotationAnim = CABasicAnimation()
        outerRotationAnim.beginTime = CACurrentMediaTime()
        outerRotationAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        outerRotationAnim.fromValue = 0.0
        outerRotationAnim.toValue = CGFloat(2.0*M_PI)
        outerRotationAnim.duration = 2.0
        outerRotationAnim.autoreverses = true
        outerRotationAnim.fillMode = kCAFillModeForwards
        outerRotationAnim.removedOnCompletion = false
        outerRotationAnim.repeatCount = Float.infinity
        
        innerSpinnerLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: innerSpinnerView.frame.width, height: innerSpinnerView.frame.height)).CGPath
        innerSpinnerLayer.lineWidth = 10.0
        innerSpinnerLayer.strokeEnd = 0.0
        innerSpinnerLayer.lineCap = kCALineCapRound
        innerSpinnerLayer.fillColor = UIColor.clearColor().CGColor
        innerSpinnerLayer.strokeColor = greenMain.CGColor
        
        let innerStrokeEndAnimation = CASpringAnimation()
        innerStrokeEndAnimation.duration = innerStrokeEndAnimation.settlingDuration
        innerStrokeEndAnimation.fromValue = 0.0
        innerStrokeEndAnimation.toValue = 0.55
        innerStrokeEndAnimation.fillMode = kCAFillModeForwards
        innerStrokeEndAnimation.removedOnCompletion = false
        innerStrokeEndAnimation.autoreverses = true
        innerStrokeEndAnimation.repeatCount = Float.infinity
        innerSpinnerLayer.addAnimation(innerStrokeEndAnimation, forKey: "strokeEnd")
        
        let innerRotationAnimation = CABasicAnimation()
        innerRotationAnimation.beginTime = CACurrentMediaTime()
        innerRotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        innerRotationAnimation.fromValue = M_PI
        innerRotationAnimation.toValue = CGFloat(3.0*M_PI)
        innerRotationAnimation.duration = 2.0
        innerRotationAnimation.autoreverses = true
        innerRotationAnimation.fillMode = kCAFillModeForwards
        innerRotationAnimation.removedOnCompletion = false
        innerRotationAnimation.repeatCount = Float.infinity
        
        outerSpinnerView.center = self.center
        innerSpinnerView.center = self.center
        
        self.addSubview(outerSpinnerView)
        self.addSubview(innerSpinnerView)
        
        innerSpinnerView.layer.addSublayer(innerSpinnerLayer)
        innerSpinnerView.layer.addAnimation(innerRotationAnimation, forKey: "transform.rotation")
        
        outerSpinnerView.layer.addSublayer(outerSpinnerLayer)
        outerSpinnerView.layer.addAnimation(outerRotationAnim, forKey: "transform.rotation")
        
    }
    
    func centerInView(viewToCenterIn v: UIView?) {
        guard let view: UIView = v else {
            guard let center = self.superview?.center else {
                print("no superview available, ensure spinner was added as a subview.")
                return
            }
            self.center = center
            return
        }
        self.center = view.center
    }
    
    func setSpinnerColor(color: UIColor) {
        self.innerSpinnerLayer.strokeColor = color.CGColor
        self.outerSpinnerLayer.strokeColor = color.CGColor
    }
    
    func setInnerSpinnerColor(color: UIColor) {
        self.innerSpinnerLayer.strokeColor = color.CGColor
    }
    
    func setOuterSpinnerColor(color: UIColor) {
        self.outerSpinnerLayer.strokeColor = color.CGColor
    }
    
    
    static func sizeAndPositionAppropriately(parentView: UIView) -> CGRect {
        let smallDimension = min(parentView.frame.width, parentView.frame.height)
        let spinnerDimension = smallDimension/4.0
//        let centerX = parentView.center.x
//        let centerY = parentView.center.y
//        return CGRectMake(centerX, centerY, spinnerDimension, spinnerDimension)
        return CGRectMake(0.0, 0.0, spinnerDimension, spinnerDimension)
    }
    
}

let spinner = SpinnerView(frame: SpinnerView.sizeAndPositionAppropriately(container))
spinner.centerInView(viewToCenterIn: container)
container.addSubview(spinner)
spinner.setSpinnerColor(UIColor.blueColor())
