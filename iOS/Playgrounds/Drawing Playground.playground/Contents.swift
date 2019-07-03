//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = .white
XCPlaygroundPage.currentPage.liveView = containerView

//let size = 75.0
//let color = UIColor.blackColor()

//let canvasSize = CGSize(width: size, height: size)
//UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
//let context = UIGraphicsGetCurrentContext()
//let halfCircleRect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
//
//CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
//CGContextAddArc(context, halfCircleRect.midX, halfCircleRect.midY, halfCircleRect.width / 2, -90 * CGFloat(M_PI)/180, 90 * CGFloat(M_PI)/180, 0)
//CGContextClosePath(context)
//CGContextDrawPath(context, .Fill)
//
//let halfCircleImage = UIGraphicsGetImageFromCurrentImageContext()
//UIGraphicsEndImageContext()

//let canvasSize = CGSize(width: size, height: size)
//UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
//let context = UIGraphicsGetCurrentContext()
//let halfCircleRect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
//
//CGContextSetFillColorWithColor(context, color.CGColor)
//CGContextAddArc(context, halfCircleRect.midX, halfCircleRect.midY, halfCircleRect.width / 2, -90 * CGFloat(M_PI)/180, 90 * CGFloat(M_PI)/180, 0)
//CGContextClosePath(context)
//CGContextDrawPath(context, .Fill)
//
//let halfCircleImage = UIGraphicsGetImageFromCurrentImageContext()
//UIGraphicsEndImageContext()

let emailTextField = UITextField()
emailTextField.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 50.0)
emailTextField.placeholder = "Email\r"
emailTextField.textColor = .black
emailTextField.font = UIFont(name: "Avenir-Book", size: 16.0)
emailTextField.returnKeyType = .next
let underlineLayer = CAShapeLayer()
let underlinePath = UIBezierPath()
underlinePath.move(to: CGPoint.zero)
underlinePath.addLine(to: CGPoint(x: emailTextField.frame.width, y: 0.0))
underlineLayer.path = underlinePath.cgPath
underlineLayer.borderColor = UIColor.red.cgColor
underlineLayer.borderWidth = 100.0
emailTextField.layer.addSublayer(underlineLayer)
emailTextField.layer.masksToBounds = false
containerView.addSubview(emailTextField)

let text = "\r\rfghjdsf"
let whitespaceSet = NSCharacterSet.whitespacesAndNewlines
text.trimmingCharacters(in: whitespaceSet)







