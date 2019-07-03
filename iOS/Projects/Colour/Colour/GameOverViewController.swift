//
//  CountdownViewController.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit
import iAd

class GameOverViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var upperAdBanner: ADBannerView!
    @IBOutlet weak var highScoreAlert: HighScoreAlert!
    var showHighScoreAlert = false
    
    
    let finalScore = score
    
    // MARK: Main Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        
        if let bestScore = NSUserDefaults.standardUserDefaults().objectForKey("bestScore") {
            if finalScore > (bestScore as! Int) {
                NSUserDefaults.standardUserDefaults().setObject(finalScore, forKey: "bestScore")
                highScoreAlert.updateTypeIdentifier(1)
                showHighScoreAlert = true
            }
            for (_, highScoreElement) in highScoreList.enumerate() {
                if finalScore > highScoreElement.getScore() {
                    highScoreAlert.updateTypeIdentifier(2)
                    showHighScoreAlert = true
                }
            }
            if showHighScoreAlert {
                highScoreAlert.hidden = false
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        view.bringSubviewToFront(finalScoreLabel)
        finalScoreLabel.text = String(finalScore)
        
    }
    
}