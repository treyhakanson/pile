//
//  SuperPopup.swift
//  SuperPopup
//
//  Created by David Hakanson on 5/29/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class SuperPopup: UIView {
    
    var nestButton = UIButton()
    
    convenience init(isUpvote: Bool, parentFrame: CGRect) {
        self.init(frame: parentFrame)
        
        let width = parentFrame.width * 0.85
        let height = width * 0.85
        let x = parentFrame.midX - width/2.0
        let y = parentFrame.midY - height/2.0
        
        let popupView = UIView(frame: CGRectMake(x, y, width, height))
        popupView.backgroundColor = .whiteColor()
        popupView.layer.cornerRadius = 15.0
        
        nestButton = UIButton(frame: CGRectMake(x, height * 0.70 - height * 0.10, width * 0.80, height * 0.20))
        nestButton.layer.cornerRadius = nestButton.frame.height/2.0
        nestButton.setAttributedTitle(NSAttributedString(string: "Go to Nest", attributes: [
            NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.55)!,
            NSForegroundColorAttributeName : UIColor.whiteColor()
            ]), forState: .Normal)
        nestButton.backgroundColor = .redColor()
        let laterButton = UIButton(frame: CGRectMake(x, height * 0.75 - height * 0.10 + nestButton.frame.height/2.0 + 10.0, width * 0.80, height * 0.20))
        laterButton.setAttributedTitle(NSAttributedString(string: "maybe later", attributes: [
            NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.55*0.50)!,
            NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
            ]), forState: .Normal)
        laterButton.addTarget(self, action: #selector(self.removeFromSuperview), forControlEvents: .TouchUpInside)
        
        let mainLabel = UILabel(frame: CGRectMake(popupView.frame.width/2.0 - width/2.0*0.9, 10.0, width*0.90, nestButton.frame.height*0.65 * 1.5))
        mainLabel.numberOfLines = 0
        mainLabel.textAlignment = .Center
        let subLabel = UILabel(frame: CGRectMake(popupView.frame.width/2.0 - width/2.0*0.975, mainLabel.frame.height + 10.0, width*0.975, nestButton.frame.height*0.65 * 1.5 * 0.75 * 2.0))
        subLabel.numberOfLines = 0
        subLabel.textAlignment = .Center
        
        let tingImageView = UIImageView(frame: CGRectMake(popupView.frame.midX - popupView.frame.width/3.5, popupView.frame.minY - popupView.frame.width/2.25, popupView.frame.width/1.25, popupView.frame.width/1.25))
        tingImageView.contentMode = .ScaleAspectFit
        
        var mainText = NSAttributedString()
        var subText = NSAttributedString()
        var tingImage = UIImage()
        var color = UIColor()
        
        if isUpvote {
            mainText = NSAttributedString(string: "Show Some Love!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: nestButton.frame.height*0.55)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            subText = NSAttributedString(string: "You might even be able to help them out!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.55*0.75)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            tingImage = UIImage(named: "super_up_ting.png")!
            color = UIColor(red: 162.0/255.0, green: 229.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        } else {
            mainText = NSAttributedString(string: "Not a Fan Huh?", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: nestButton.frame.height*0.55)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            subText = NSAttributedString(string: "Get in there and tell everyone why!", attributes: [
                NSFontAttributeName : UIFont(name: "Avenir-Medium", size: nestButton.frame.height*0.55*0.75)!,
                NSForegroundColorAttributeName : UIColor.blackColor().colorWithAlphaComponent(0.85)
                ])
            tingImage = UIImage(named: "super_down_ting.png")!
            color = UIColor(red: 1.0, green: 152.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        }
        
        mainLabel.attributedText = mainText
        subLabel.attributedText = subText
        tingImageView.image = tingImage
        nestButton.backgroundColor = color
        
        self.backgroundColor = color.colorWithAlphaComponent(0.60)
        popupView.addSubview(mainLabel)
        popupView.addSubview(subLabel)
        popupView.addSubview(nestButton)
        popupView.addSubview(laterButton)
        self.addSubview(tingImageView)
        self.addSubview(popupView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
