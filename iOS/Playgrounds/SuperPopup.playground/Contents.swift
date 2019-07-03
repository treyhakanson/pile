//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class SuperPopup: UIView {
    
    convenience init(isUpvote: Bool, parentFrame: CGRect) {
        let width = parentFrame.width * 0.85
        let height = width * 0.85
        let x = parentFrame.midX - width/2.0
        let y = parentFrame.midY - height/2.0
        self.init(frame: CGRectMake(x, y, width, height))
        
        self.backgroundColor = .whiteColor()
        self.layer.cornerRadius = 15.0
        
        let mainLabel = UILabel(frame: CGRectZero)
        let subLabel = UILabel(frame: CGRectZero)
        
        let nestButton = UIButton(frame: CGRectMake(x, height * 0.75 - height * 0.10, width * 0.80, height * 0.20))
        nestButton.layer.cornerRadius = nestButton.frame.height/2.0
        nestButton.setAttributedTitle(NSAttributedString(string: "Go to Nest", attributes: [
            NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.65)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
            ]), forState: .Normal)
        nestButton.backgroundColor = .redColor()
        self.addSubview(nestButton)
        let laterButton = UIButton(frame: CGRectMake(x, height * 0.75 - height * 0.10 + nestButton.frame.height/2.0 + 10.0, width * 0.80, height * 0.20))
        laterButton.setAttributedTitle(NSAttributedString(string: "maybe later", attributes: [
            NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.65*0.50)!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
            ]), forState: .Normal)
        self.addSubview(laterButton)
        
        var mainText = NSAttributedString()
        var subText = NSAttributedString()
        var color = UIColor()
        
        if isUpvote {
            mainText = NSAttributedString(string: "Show Some Love!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: nestButton.frame.height*0.65)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            subText = NSAttributedString(string: "You might even be able to help them out!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.65*0.75)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            color = UIColor(red: 162.0/255.0, green: 229.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        } else {
            mainText = NSAttributedString(string: "Not a Fan Huh?", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: nestButton.frame.height*0.65)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            subText = NSAttributedString(string: "Get in there and tell everyone why!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.65*0.75)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            color = UIColor(red: 1.0, green: 152.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        }
        
        mainLabel.attributedText = mainText
        mainLabel.sizeToFit()
        subLabel.attributedText = subText
        subLabel.sizeToFit()
        nestButton.backgroundColor = color
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

var screen = UIView(frame: CGRectMake(0.0, 0.0, 375.0, 675.0))
XCPlaygroundPage.currentPage.liveView = screen
let superPopup = SuperPopup(isUpvote: false, parentFrame: screen.frame)
screen.addSubview(superPopup)
