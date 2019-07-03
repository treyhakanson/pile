//
//  ViewController.swift
//  Sparkle Test
//
//  Created by David Hakanson on 4/14/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.twinkle(UIColor.blueColor(), scale: 1.5, alpha: 1.0, chaos: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

