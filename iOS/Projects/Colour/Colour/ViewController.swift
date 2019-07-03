//
//  ViewController.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit
import Parse

var highScoreList: [HighScore] = []
var score: Int = 0

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var splashHeaderLabel: UIView!
    var tempHighScoreList: [HighScore] = []
    let colors: [UIColor] = [
        UIColor(red: CGFloat(238.0/255.0), green: CGFloat(41.0/255.0), blue: CGFloat(40.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(244.0/255.0), green: CGFloat(116.0/255.0), blue: CGFloat(34.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(249.0/255.0), green: CGFloat(237.0/255.0), blue: CGFloat(44.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(117.0/255.0), green: CGFloat(192.0/255.0), blue: CGFloat(67.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(70.0/255.0), green: CGFloat(93.0/255.0), blue: CGFloat(170.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(142.0/255.0), green: CGFloat(70.0/255.0), blue: CGFloat(155.0/255.0), alpha: CGFloat(1.0)),
        UIColor(red: CGFloat(220.0/255.0), green: CGFloat(93.0/255.0), blue: CGFloat(162.0/255.0), alpha: CGFloat(1.0))
    ]
    
    // MARK: Actions
    @IBAction func playButtonClicked(sender: UIButton) {
        
    }
    @IBAction func topsButtonClicked(sender: UIButton) {
        
    }
    
    // MARK: Main Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sendSubviewToBack(splashHeaderLabel)
        pickHeaderColor()
        self.view.bringSubviewToFront(bestScoreLabel)
        
        let query = PFQuery(className: "HighScore")
        query.limit = 20
        query.orderByDescending("score")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for (_, object) in objects.enumerate() {
                        let queriedHighScore: HighScore = HighScore(playerName: object["playerName"] as! String, score: object["score"] as! Int)
                        self.tempHighScoreList.append(queriedHighScore)
                    }
                    highScoreList = self.tempHighScoreList
                }
            }
        }
        
        
        if let bestScore = NSUserDefaults.standardUserDefaults().objectForKey("bestScore") {
            bestScoreLabel.text = String(bestScore)
            
        } else {
            bestScoreLabel.text = "0"
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "bestScore")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.view.sendSubviewToBack(splashHeaderLabel)
        self.view.bringSubviewToFront(bestScoreLabel)
    }
    
    // MARK: Helper Functions
    func pickHeaderColor() {
        let randomColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        self.splashHeaderLabel.backgroundColor = colors[randomColorIndex]
    }


}

