//
//  CountdownViewController.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit
import iAd

class CountdownViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var upperAdBanner: ADBannerView!
    var counter = 3
    
    // MARK: Main Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        
        score = 0
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("checkIfReady"), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: Helper Functions
    func checkIfReady() {
        if counter > 0 {
            if counter > 1 {
                countdownLabel.text = "\(counter - 1)..."
            }else {
                countdownLabel.text = "Go!"
            }
            counter--
            
        }else {
            performSegueWithIdentifier("toGameplaySegue", sender: nil)
            
        }
    }
    
}