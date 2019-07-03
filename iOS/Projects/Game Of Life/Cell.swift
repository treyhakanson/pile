//
//  Cell.swift
//  Game Of Life
//
//  Created by David Hakanson on 10/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import Foundation

class Cell {
    let x: Int
    let y: Int
    let state: State
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
        state = State.randomState()
    }
    
}
