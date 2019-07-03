//
//  HighScore.swift
//  Colour
//
//  Created by David Hakanson on 12/31/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class HighScore {
    
    private var playerName: String
    private var score: Int
    
    init(playerName: String, score: Int) {
        self.playerName = playerName
        self.score = score
    }
    
    func getPlayerName() -> String {
        return self.playerName
    }
    
    func getScore() -> Int {
        return self.score
    }
    
}
