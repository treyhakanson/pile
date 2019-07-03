//
//  HighScoreAlert.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit
import Parse

class HighScoreAlert: UIView, UITextFieldDelegate {

    // MARK: Properties
    let frameWidth: Int = 225
    let frameHeight: Int = 300
    let limitLength: Int = 12
    var typeIdentifier: Int = 0
    var finalImageView: UIImageView = UIImageView()
    var nameEntryField: UITextField = UITextField()
    var headerLabel: UILabel = UILabel()
    var subtextLabel: UILabel = UILabel()
    var positiveButton: UIButton = UIButton()
    var negativeButton: UIButton = UIButton()
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        updateView()
        
    }
    
    // MARK: Main Overrides
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: frameWidth, height: frameHeight)
        
    }
    
    override func layoutSubviews() {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "highscore_alert_bg.png")!)
        
        let frameCenterX: Int = Int(frame.size.width/2)
        let bufferY: Int = 5
        var currentPosY: Int = 10
        
        let imageSize = 75
        let imageFrame = CGRect(x: (frameCenterX - imageSize/2), y: currentPosY, width: imageSize, height: imageSize)
        currentPosY += (imageSize + bufferY)
        finalImageView.frame = imageFrame
        
        let headerWidth = 275
        let headerHeight = 25
        let headerFrame = CGRect(x: (frameCenterX - headerWidth/2), y: currentPosY, width: headerWidth, height: headerHeight)
        currentPosY += (headerHeight + bufferY)
        headerLabel.frame = headerFrame
        
        let subtextWidth = 275
        let subtextHeight = 100
        let subtextFrame = CGRect(x: (frameCenterX - subtextWidth/2), y: currentPosY, width: subtextWidth, height: subtextHeight)
        currentPosY += (subtextHeight + bufferY)
        subtextLabel.frame = subtextFrame
        
        if typeIdentifier == 2 {
            let nameEntryFieldWidth = 250
            let nameEntryFieldHeight = 30
            let nameEntryFieldFrame = CGRect(x: (frameCenterX - nameEntryFieldWidth/2), y: currentPosY, width: nameEntryFieldWidth, height: nameEntryFieldHeight)
            currentPosY += (nameEntryFieldHeight + bufferY)
            nameEntryField.frame = nameEntryFieldFrame
        }
        
        let buttonHeight = 45
        let buttonWidth = 225
        let positiveButtonFrame = CGRect(x: frameCenterX - buttonWidth/2, y: currentPosY, width: buttonWidth, height: buttonHeight)
        currentPosY += (buttonHeight + bufferY*2)
        let negativeButtonFrame = CGRect(x: frameCenterX - buttonWidth/2, y: currentPosY, width: buttonWidth, height: buttonHeight)
        positiveButton.frame = positiveButtonFrame
        negativeButton.frame = negativeButtonFrame
        
    }
    
    // MARK: Helper Functions
    func positiveButtonClicked(button: UIButton) {
        if typeIdentifier == 1 {
            UIView.animateWithDuration(0.75, animations: {
                self.center.x += 700
            })
        }else {
            if nameEntryField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                self.resignFirstResponder()
                let newHighScore: HighScore = HighScore(playerName: nameEntryField.text!, score: score)
                
                let newHighScorePFObject: PFObject = PFObject(className: "HighScore")
                newHighScorePFObject["playerName"] = newHighScore.getPlayerName()
                newHighScorePFObject["score"] = newHighScore.getScore()
                newHighScorePFObject.saveInBackground()
                
                UIView.animateWithDuration(0.75, animations: {
                    self.center.x += 700
                })
            }else {
                nameEntryField.attributedPlaceholder = NSAttributedString(string:"Enter Name Here",
                    attributes:[NSForegroundColorAttributeName: UIColor.redColor()])
            }
        }
    }
    
    func negativeButtonClicked(button: UIButton) {
        self.resignFirstResponder()
        UIView.animateWithDuration(0.75, animations: {
            self.center.x += 700
        })
    }
    
    func updateView() {
        let localBestImage: UIImage = UIImage(named: "local_best_icon.png")!
        let globalBestImage: UIImage = UIImage(named: "global_best_icon.png")!
        let okButtonPurpleImage: UIImage = UIImage(named: "ok_button_purple.png")!
        let cancelButtonPurpleImage: UIImage = UIImage(named: "cancel_button_purple.png")!
        let okButtonGoldImage: UIImage = UIImage(named: "ok_button_gold.png")!
        let cancelButtonGoldImage: UIImage = UIImage(named: "cancel_button_gold.png")!
        let purpleColor: UIColor = UIColor(red: 139.0/255.0, green: 27.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let goldColor: UIColor = UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 12.0/255.0, alpha: 1.0)
        
        switch typeIdentifier {
        case 1:
            finalImageView.image = localBestImage
            headerLabel.text = "Personal Best!"
            subtextLabel.text = "Congratulations, you beat your personal best!"
            
            nameEntryField.textColor = purpleColor
            nameEntryField.attributedPlaceholder = NSAttributedString(string:"Enter Name Here",
                attributes:[NSForegroundColorAttributeName: purpleColor])
            
            positiveButton.setImage(okButtonPurpleImage, forState:  UIControlState.Normal)
            negativeButton.setImage(cancelButtonPurpleImage, forState:  UIControlState.Normal)
            break
        case 2:
            finalImageView.image = globalBestImage
            headerLabel.text = "Global Best!"
            subtextLabel.text = "Wowzers you've made the world leaderboard! Please enter the name you'd like displayed below:"
            
            nameEntryField.textColor = goldColor
            nameEntryField.attributedPlaceholder = NSAttributedString(string:"Enter Name Here",
                attributes:[NSForegroundColorAttributeName: goldColor])
            
            positiveButton.setImage(okButtonGoldImage, forState:  UIControlState.Normal)
            negativeButton.setImage(cancelButtonGoldImage, forState:  UIControlState.Normal)
            break
        default:
            finalImageView.image = nil
            headerLabel.text = "Error"
            subtextLabel.text = nil
            
            positiveButton.setImage(nil, forState:  UIControlState.Normal)
            negativeButton.setImage(nil, forState:  UIControlState.Normal)
            break
        }
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.font = UIFont(name: "AlfaSlabOne-Regular", size: 25)
        headerLabel.textColor = UIColor.whiteColor()
        
        subtextLabel.textAlignment = NSTextAlignment.Center
        subtextLabel.numberOfLines = 0
        subtextLabel.font = UIFont(name: "AlfaSlabOne-Regular", size: 16)
        subtextLabel.textColor = UIColor.whiteColor()
        
        nameEntryField.placeholder = "Enter Name Here"
        nameEntryField.font = UIFont(name: "LuckiestGuy-Regular", size: 20)
        nameEntryField.textAlignment = NSTextAlignment.Center
        nameEntryField.returnKeyType = UIReturnKeyType.Done
        nameEntryField.delegate = self
        
        positiveButton.addTarget(self, action: "positiveButtonClicked:", forControlEvents: .TouchDown)
        
        negativeButton.addTarget(self, action: "negativeButtonClicked:", forControlEvents: .TouchDown)
        
        addSubview(finalImageView)
        if finalImageView.image == globalBestImage {
            addSubview(nameEntryField)
        }
        addSubview(headerLabel)
        addSubview(subtextLabel)
        addSubview(positiveButton)
        addSubview(negativeButton)
        
    }
    
    func updateTypeIdentifier(id: Int) {
        self.typeIdentifier = id
        updateView()
    }
    
    
    // MARK: UITextField
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= limitLength // Bool
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
