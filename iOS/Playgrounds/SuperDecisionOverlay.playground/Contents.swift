//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class SuperDesicionOverlay: UIView {
    
    convenience init(frame: CGRect, isUp: Bool) {
        self.init(frame: frame)
        
        let dimen = frame.width/2.0
        self.frame = CGRectMake(0.0, 0.0, dimen, frame.height)
        
        if isUp {
            self.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.50)
            self.frame.origin.x = frame.width - dimen
        } else {
            self.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.50)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

let screen = UIView(frame: CGRectMake(0.0, 0.0, 375.0, 675.0))
screen.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = screen

let upOverlay = SuperDesicionOverlay(frame: screen.frame, isUp: true)
let downOverlay = SuperDesicionOverlay(frame: screen.frame, isUp: false)
let orButton = UIView(frame: CGRectMake(0.0, 0.0, screen.frame.width/3.0, screen.frame.width/3.0))
orButton.layer.cornerRadius = orButton.frame.height/2.0
orButton.backgroundColor = .lightGrayColor()
orButton.center = screen.center

screen.addSubview(downOverlay)
screen.addSubview(upOverlay)
screen.addSubview(orButton)

















