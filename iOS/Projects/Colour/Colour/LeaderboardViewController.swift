//
//  CountdownViewController.swift
//  Colour
//
//  Created by David Hakanson on 12/30/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var leaderboardTableView: UITableView!
    @IBOutlet weak var leaderBoardHeaderLabel: UILabel!
    
    // MARK: Main Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(leaderBoardHeaderLabel)
    }
    
    // MARK: UITableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return highScoreList.count
        
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell: LeaderBoardTableViewCell = leaderboardTableView.dequeueReusableCellWithIdentifier("leaderBoardCell", forIndexPath: indexPath) as! LeaderBoardTableViewCell
        if let highScoreAtIndex: HighScore = highScoreList[indexPath.row] {
            tableCell.playNameLabel.text = highScoreAtIndex.getPlayerName()
            tableCell.playerScoreLabel.text = String(highScoreAtIndex.getScore())
            tableCell.positionLabel.text = "\(indexPath.row + 1)"
        }else {
            tableCell.playNameLabel.text = ""
            tableCell.playerScoreLabel.text = ""
            tableCell.positionLabel.text = ""
        }
        
        return tableCell
    }
    
}