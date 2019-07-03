//
//  State.swift
//  Game Of Life
//
//  Created by David Hakanson on 10/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import Foundation

enum State: Int {
    case living = 1, prebirth, dead
    
    static func randomState() -> State {
        guard let state = State(rawValue: Int(arc4random_uniform(2))) else { return .prebirth }
        return state
    }
    
}
