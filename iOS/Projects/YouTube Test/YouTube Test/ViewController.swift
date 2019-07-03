//
//  ViewController.swift
//  YouTube Test
//
//  Created by David Hakanson on 4/13/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let youTubeView = SquareYouTubeView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0), cropFactor: 1.8, videoId: "YR7_fuV5RDw") // crop factor of 1.8 is for tasty videos
        youTubeView.center = self.view.center
        self.view.addSubview(youTubeView)
        
    }
    
}

