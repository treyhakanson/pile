//
//  TutorialPageOneViewController.swift
//  ModalPageView
//
//  Created by David Hakanson on 10/15/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class TutorialPageOneViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lyr = containerView.layer
            
        lyr.cornerRadius = 10.0
        lyr.borderColor = UIColor.white.cgColor
        lyr.borderWidth = 1.0
        
        lyr.shadowColor = UIColor.black.cgColor
        lyr.shadowOffset = CGSize(width: -3.0, height: 3.0)
        lyr.shadowRadius = 3.0
        lyr.shadowOpacity = 0.25
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }

}
