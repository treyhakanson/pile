//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRectMake(0, 0, 375, 675))
container.backgroundColor = .whiteColor()
XCPShowView("container", view: container)

let viewWidth = container.frame.width
let actualViewHeight = viewWidth*2.0
let visibleViewHeight = 0.75*viewWidth

let overlayView = UIView(frame: CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
overlayView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15)
//let utgr = UITapGestureRecognizer(target: container, action: .cancelNewThread)
//overlayView.addGestureRecognizer(utgr)

let newThreadView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: viewWidth, height: visibleViewHeight))
newThreadView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)

let headerLabel = UILabel(frame: CGRectMake(0, 0, newThreadView.frame.width, newThreadView.frame.height))
headerLabel.attributedText = NSAttributedString(string: "New Thread", attributes: [NSFontAttributeName : UIFont(name: "Avenir", size: 22.0)!])
headerLabel.textColor = .lightGrayColor()
headerLabel.textAlignment = .Center
headerLabel.sizeToFit()
headerLabel.center.x += (newThreadView.frame.width/2 - headerLabel.bounds.width/2)
newThreadView.addSubview(headerLabel)

let margin: CGFloat = 10.0
let titleView = UITextView(frame: CGRectMake(0, 0, newThreadView.frame.width - 2*margin, 20.0))
titleView.layer.cornerRadius

container.addSubview(overlayView)
container.addSubview(newThreadView)