//
//  UIColorExtension.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/27/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha a: CGFloat) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

let ApplicationColors = (
    green: UIColor(hex: 0x18e166, alpha: 1),
    red: UIColor(hex: 0xfc2025, alpha: 1),
    blue: UIColor(hex: 0x007aff, alpha: 1),
    grey1: UIColor(hex: 0xfafafa, alpha: 1),
    grey2: UIColor(hex: 0xededed, alpha: 1)
)
