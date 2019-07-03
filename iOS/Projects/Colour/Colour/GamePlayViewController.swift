//
//  GamePlayViewController.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit
import iAd

// MARK: Global Variables

class GamePlayViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var upperAdBanner: ADBannerView!
    var correctAnswer: Int = 0
    var killTouch = false
    var timeLeft: Int = 3
    var timer: NSTimer = NSTimer()
    var timeInterval = 0.5
    let animationLength: CGFloat = 0.5
    let stopLength = 0.5
    let colors: [UIColor] = [
        UIColor(red: CGFloat(238.0/255.0), green: CGFloat(41.0/255.0), blue: CGFloat(40.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(244.0/255.0), green: CGFloat(116.0/255.0), blue: CGFloat(34.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(249.0/255.0), green: CGFloat(237.0/255.0), blue: CGFloat(44.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(117.0/255.0), green: CGFloat(192.0/255.0), blue: CGFloat(67.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(70.0/255.0), green: CGFloat(93.0/255.0), blue: CGFloat(170.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(142.0/255.0), green: CGFloat(70.0/255.0), blue: CGFloat(155.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(220.0/255.0), green: CGFloat(93.0/255.0), blue: CGFloat(162.0/255.0), alpha: CGFloat(1.0))
    ]
    let colorNames: [String] = [
        "Red",
        "Orange",
        "Yellow",
        "Green",
        "Blue",
        "Purple",
        "Pink"
    ]
    
    // MARK: Actions
    @IBAction func choiceSelected(sender: UIButton) {
        if !killTouch {
            if sender.backgroundColor! == colors[correctAnswer] {
                timer.invalidate()
                timeLeft = 3
                timeLabel.text = String(timeLeft)
                
                if score < 5 {
                    timeInterval = 0.5
                }else if score < 10 {
                    timeInterval = 0.40
                }else if score < 15 {
                    timeInterval = 0.35
                }else if score < 20 {
                    timeInterval = 0.30
                }else if score < 30 {
                    timeInterval = 0.25
                }else {
                    timeInterval = 0.225
                }
                
                timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
                
                score++
                scoreLabel.text = String(score)
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.scoreLabel.center = CGPointMake(self.scoreLabel.center.x, self.scoreLabel.center.y - 35)
                })
                
                formatColorNameLabel()
                formatChoices()
                
            }else{
                timer.invalidate()
                colorNameLabel.text = "Whoops!"
                colorNameLabel.textColor = UIColor.blackColor()
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("toGameOverScreen"), userInfo: nil, repeats: false)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        
        score = 0
        
        formatColorNameLabel()
        formatChoices()
        
        scoreLabel.text = String(score)
        timeLabel.text = String(timeLeft)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        view.bringSubviewToFront(scoreLabel)
    }
    
    // MARK: Helper Function
    func formatColorNameLabel() {
        let randomIndex1: Int = Int(arc4random_uniform(UInt32(colors.count)))
        let randomIndex2: Int = Int(arc4random_uniform(UInt32(colors.count)))
        
        self.correctAnswer = randomIndex2
        
        self.colorNameLabel.textColor = colors[randomIndex1]
        self.colorNameLabel.text = colorNames[correctAnswer]
        
    }
    
    func formatChoices() {
        
        var tempColors: [UIColor] = self.colors
        var finalColors: [UIColor] = []
        finalColors.append(tempColors[self.correctAnswer])
        tempColors.removeAtIndex(self.correctAnswer)
       
        var randomColorIndex: Int = Int(arc4random_uniform(UInt32(tempColors.count)))
        
        for _ in 0..<3 {
            finalColors.append(tempColors[randomColorIndex])
            tempColors.removeAtIndex(randomColorIndex)
            randomColorIndex = Int(arc4random_uniform(UInt32(tempColors.count)))
        }
        
        var buttons: [UIButton] = [(self.view.viewWithTag(1) as? UIButton)!, (self.view.viewWithTag(2) as? UIButton)!, (self.view.viewWithTag(3) as? UIButton)!, (self.view.viewWithTag(4) as? UIButton)!]
        var randomButtonIndex: Int = Int(arc4random_uniform(UInt32(buttons.count)))
        
        for i in 0..<4 {
            buttons[randomButtonIndex].backgroundColor = finalColors[i]
            buttons.removeAtIndex(randomButtonIndex)
            randomButtonIndex = Int(arc4random_uniform(UInt32(buttons.count)))
        }
        
    }
    
    func updateTimer() {
        if timeLeft > 0 {
            timeLeft--
            timeLabel.text = String(timeLeft)
        }else {
            killTouch = true
            let buttons: [UIButton] = [(self.view.viewWithTag(1) as? UIButton)!, (self.view.viewWithTag(2) as? UIButton)!, (self.view.viewWithTag(3) as? UIButton)!, (self.view.viewWithTag(4) as? UIButton)!]
            for (_, button) in buttons.enumerate() {
                button.enabled = false
            }
            colorNameLabel.text = "Time's Up!"
            colorNameLabel.textColor = UIColor.blackColor()
            timer.invalidate()
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("toGameOverScreen"), userInfo: nil, repeats: false)
        }
    }
    
    func toGameOverScreen() {
        performSegueWithIdentifier("toGameOverSegue", sender: self)
    }
    
    
    
}

