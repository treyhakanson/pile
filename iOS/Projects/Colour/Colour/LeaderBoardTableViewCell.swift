//
//  LeaderBoardTableViewCell.swift
//  Colour
//
//  Created by David Hakanson on 12/31/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var playNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}