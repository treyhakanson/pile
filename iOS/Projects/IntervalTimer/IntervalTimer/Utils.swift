//
//  Utils.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/26/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import Foundation
import UIKit

class Utils {

    static func toDisplayTime(seconds s: Int) -> String {
        let rem = s % 60
        let min = s / 60
        
        let text: String
        
        if (min > 0 && rem > 0) {
            text = "\(min)m \(rem)s"
        } else if (min > 0) {
            text = "\(min)m"
        } else {
            text = "\(s)s"
        }
        
        return text
    }
    
    static func mockCoreData() {
        let mockData = [
            TimerConfig(intervalTime: 20, breakTime: 5, sets: 3),
            TimerConfig(intervalTime: 30, breakTime: 15, sets: 5),
            TimerConfig(intervalTime: 90, breakTime: 30, sets: 3)
        ]
        
        for datum in mockData {
            try? datum.save()
        }
    }
    
}
