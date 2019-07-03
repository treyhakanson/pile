//
//  ViewController.swift
//  Game Of Life
//
//  Created by David Hakanson on 10/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: UIView!
    var life = Life()
    let gameboard: Gameboard

    required init?(coder aDecoder: NSCoder) {
        gameboard = Gameboard(with: life)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidLayoutSubviews() {
        // results of frame.width, etc. are erroneous in viewDidLoad due to autolayout
        gameboard.frame = boardView.frame
        gameboard.center = CGPoint(
            x: gameboard.frame.width/2,
            y: gameboard.frame.height/2
        )
        boardView.addSubview(gameboard)
    }
    
}

