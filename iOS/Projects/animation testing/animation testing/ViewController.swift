//
//  ViewController.swift
//  animation testing
//
//  Created by David Hakanson on 1/28/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    @IBOutlet weak var button: UIButton!
    @IBAction func touchedButton(sender: AnyObject) {
        button.enabled = false
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                self.button.bounds.size.width += 80.0
            }, completion: nil)
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                self.button.center.y += 60.0
            }, completion: nil)
        self.button.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
        self.spinner.center = CGPoint(x: 40.0, y: self.button.frame.size.height/2)
        self.spinner.alpha = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // this is the only place where the button will start off the screen
    override func viewDidLayoutSubviews() {
        self.button.center.x -= self.view.bounds.width
    }
    
    // this is the only place this animation works
    override func viewDidAppear(animated: Bool) {
        // .Repeat loops the animation forever
        // .Autoreverse can only be used in conjunction with .Repeat and will play the animation in reverse before playing it forward again
        // .CurveEaseIn/Out/InOut ease animations
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
                self.button.center.x += self.view.bounds.width
            }, completion: nil)
    }
}

