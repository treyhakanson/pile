//
//  ViewController.swift
//  Spinner Menu
//
//  Created by David Hakanson on 4/28/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

private extension Selector {
    static let showMenu = #selector(ViewController.showMenu(_:))
    
}

private extension UIColor {
    static let hatchliMain = UIColor(red: 160.0/255.0, green: 230.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    
}

class ViewController: UIViewController {
    var interestsMenu: CircleMenu = CircleMenu()
    var interestsButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarHeight: CGFloat = 50.0
        let buffer: CGFloat = 10.0
        
        self.interestsButton = UIButton(frame: CGRectMake(0.0, 0.0, 100.0, 50.0))
        self.interestsButton.setTitle("All", forState: .Normal)
        self.interestsButton.setTitleColor(.hatchliMain, forState: .Normal)
        self.interestsButton.addTarget(self, action: .showMenu, forControlEvents: .TouchUpInside)
        self.interestsButton.center.y = navBarHeight + buffer
        self.interestsButton.center.x = self.view.frame.width - self.interestsButton.frame.width
        self.view.addSubview(self.interestsButton)
        
        let menuItems = ["All", "Technology", "Food", "Sports", "Music", "Art", "Fashion", "Publishing", "Social", "Business", "Misc."]
        self.interestsMenu = CircleMenu(diameter: self.view.frame.width, color: .hatchliMain, menuItems: menuItems)
        self.interestsMenu.center.x = self.view.frame.width
        self.interestsMenu.center.y = navBarHeight
        self.view.addSubview(self.interestsMenu)
        self.view.sendSubviewToBack(self.interestsMenu)
        
        let velocityTestButton = UIButton(frame: CGRectMake(0.0, 0.0, 150.0, 30.0))
        velocityTestButton.setTitle("Print Velocity", forState: .Normal)
        velocityTestButton.setTitleColor(.hatchliMain, forState: .Normal)
        velocityTestButton.center = self.view.center
        velocityTestButton.addTarget(self, action: #selector(ViewController.printMaxSessionVelocity), forControlEvents: .TouchUpInside)
        self.view.addSubview(velocityTestButton)
        
    }
    
    func printMaxSessionVelocity() {
        print("----------------------------------------------------")
        print("Maximum Session Velocity: \(self.interestsMenu.maxSessionVelocity)")
        print("Minimum Session Velocity: \(self.interestsMenu.minSessionVelocity)")
        print("----------------------------------------------------\n")
        
    }
    
    func updateInterestsButton(sender: AnyObject) {
        let menu = self.interestsMenu
        self.interestsButton.setTitle(menu.menuItems[menu.currentInterest], forState: .Normal)
        
    }
    
    func showMenu(sender: AnyObject?) {
        self.interestsMenu.animateMenu()
        
        switch self.interestsMenu.menuState {
        case .Open:
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: [.CurveEaseOut], animations: {
                self.interestsButton.center.x += (self.interestsMenu.maxMenuDiameter/2.0)
            }, completion: nil)
        case .Closed:
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: [.CurveEaseOut], animations: {
                self.interestsButton.center.x -= (self.interestsMenu.maxMenuDiameter/2.0)
                }, completion: nil)
        }
        
    }

}

extension CircleMenu {
    enum State {
        case Open
        case Closed
    }
    
    enum SwipeDirection {
        case UpRight
        case UpLeft
        case DownRight
        case DownLeft
        case None
    }
    
    class MenuLabel: UILabel {
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
    
}

class CircleMenu: UIView {
    var maxSessionVelocity: CGFloat = 0.0 // TEMPORARY VARIABLE FOR TESTING
    var minSessionVelocity: CGFloat = 10000.0 // TEMPORARY VARIABLE FOR TESTING
    var spacingAngle: CGFloat = 0.0
    var menuItems: [String] = []
    var menuItemAngles: [CGFloat] = []
    var menuState: State = State.Closed
    var currentInterest: Int = 0
    
    let maxMenuDiameter: CGFloat
    
    override init(frame: CGRect) {
        self.maxMenuDiameter = frame.width
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    init(diameter: CGFloat, color: UIColor, menuItems: [String]) {
        let frame = CGRectMake(0.0, 0.0, diameter, diameter)
        self.maxMenuDiameter = frame.width
        self.menuItems = menuItems
        super.init(frame: frame)
        
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.height/2.0
        self.layer.masksToBounds = true
        self.transform = CGAffineTransformMakeScale(0.01, 0.01)
        self.hidden = true
        
        self.spacingAngle = CGFloat(2*M_PI)/CGFloat(menuItems.count)
        for i in 0..<menuItems.count {
            let angle: CGFloat = self.spacingAngle*CGFloat(i)
            self.menuItemAngles.append(angle)
            
            let label = MenuLabel(color: .whiteColor(), text: menuItems[i], angle: angle)
            
            let z: CGFloat = self.maxMenuDiameter/4.0 - label.frame.width/2.5
            let x: CGFloat = floor(z*cos(angle))
            let y: CGFloat = floor(z*sin(angle))
            
            label.layer.position = CGPointMake(self.maxMenuDiameter/2.0 - x, self.maxMenuDiameter/2.0 - y)
            self.addSubview(label)
            
        }
        
        for i in 0..<menuItems.count {
            print("item: \(menuItems[i]) --- angle: \(self.menuItemAngles[i]*180.0/CGFloat(M_PI))")
        }
        
        self.transform = CGAffineTransformMakeRotation(self.spacingAngle) // set rotation of the menu to be equal to the initial option
        
    }
    
    func animateMenu() {
        switch menuState {
        case .Open:
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: [.CurveEaseOut], animations: {
                self.transform = CGAffineTransformMakeScale(0.01, 0.01)
            }) { (finished: Bool) in
                self.menuState = .Closed
                self.hidden = true
            }
            break
        case .Closed:
            self.hidden = false
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: [.CurveEaseOut], animations: {
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (finished: Bool) in
                self.menuState = .Open
            }
            break
        }
    }
    
    func createMenuItems(menuItems: [String], textColor color: UIColor) {
        for menuItem in menuItems {
            let font = UIFont(name: "Avenir", size: 16.0)!
            let labelWidth: CGFloat = self.maxMenuDiameter/3.0
            let labelHeight: CGFloat = font.pointSize*2.0
            
            let menuLabel = UILabel(frame: CGRectMake(0.0, 0.0, labelWidth, labelHeight))
            menuLabel.attributedText = NSAttributedString(string: menuItem, attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : color.CGColor])
            menuLabel.sizeToFit()
            
        }
    }
    
    var start: CGPoint?
    var startTime: NSTimeInterval?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // touch has begun
        if touches.count > 1 {
            return // breaks if multi-touch gesture
        }
        
        if let touch: UITouch = touches.first {
            let location: CGPoint = touch.locationInView(self)
            self.start = location
            self.startTime = touch.timestamp
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // touch has ended
        
        guard let touch: UITouch = touches.first else { return /* no touches found */ }
        let location: CGPoint = touch.locationInView(self)
        
        let dx: CGFloat = location.x - self.start!.x
        let dy: CGFloat = location.y - self.start!.y
        let theta: CGFloat = atan(max(dx,dy)/min(dx, dy)) * 180.0/CGFloat(M_PI)
        
        let dt: CGFloat = CGFloat(touch.timestamp - self.startTime!)
        
        let magnitude: CGFloat = sqrt(pow(dx, 2.0) + pow(dy, 2.0))
        let velocity: CGFloat = magnitude/dt
        self.maxSessionVelocity = (velocity > self.maxSessionVelocity) ? velocity : self.maxSessionVelocity
        self.minSessionVelocity = (velocity < self.minSessionVelocity) ? velocity : self.minSessionVelocity
        
        var xIsRight: Bool = true // assume x is to the right
        var yIsDown: Bool = true // assume y is down
        
        if dx < 0 { // x is to left
            xIsRight = false
        }
        
        if dy < 0 { // y is up
            yIsDown = false
        }
        
        var swipeDirection: SwipeDirection = SwipeDirection.None
        if xIsRight && yIsDown {
            print("Right and Down\n-------------")
            swipeDirection = SwipeDirection.DownRight
        } else if xIsRight && !yIsDown {
            print("Right and Up\n-------------")
            swipeDirection = SwipeDirection.UpRight
        } else if !xIsRight && !yIsDown {
            print("Left and Up\n-------------")
            swipeDirection = SwipeDirection.UpLeft
        } else if !xIsRight && yIsDown {
            print("Left and Down\n-------------")
            swipeDirection = SwipeDirection.DownLeft
        }
        
        print("velocity: \(velocity)")
        print("dx = \(location.x) - \(self.start!.x) = \(dx)")
        print("dy = \(location.y) - \(self.start!.y) = \(dy)")
        print("theta = arcsine(\(dx/dy)) = \(theta)\n") // this is being a bit odd; ~0deg is registering at ~90deg (giving incorrect angle)
        
        let duration: NSTimeInterval = 1.0
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        var velocityTag: Int = 0
        if velocity < 300.0 { // if the velocity is below minimum threshold, only move over one menu item
            velocityTag = 1
        } else if velocity <= 1000.0 { // velocity is about average, move over 2
            velocityTag = 2
        } else { // velocity is above average, move over three
            velocityTag = 3
        }
        
        switch swipeDirection {
        case .DownRight, .DownLeft: // counterclockwise
            self.currentInterest -= velocityTag
            if self.currentInterest < 0 { self.currentInterest = self.menuItems.count - abs(self.currentInterest) }
            print("current interest (subtration): \(self.currentInterest)")
            
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.beginTime = CACurrentMediaTime()
            animation.duration = duration
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.toValue = menuItemAngles[currentInterest]
            
            self.layer.addAnimation(animation, forKey: nil)
            break
        case .UpRight, .UpLeft: // clockwise
            currentInterest += velocityTag
            if self.currentInterest > self.menuItems.count { self.currentInterest = self.currentInterest - self.menuItems.count }
            print("current interest (addition): \(self.currentInterest)")
            
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.beginTime = CACurrentMediaTime()
            animation.duration = duration
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.toValue = menuItemAngles[currentInterest]
            
            self.layer.addAnimation(animation, forKey: nil)
            break
        case .None:
            break // do nothing
        }
        
//        performSelector(#selector(ViewController.updateInterestsButton))
        print("current interest: \(menuItems[currentInterest])")
        
    }
    
}








