//
//  FillBar.swift
//  WalletTracker
//
//  Created by David Hakanson on 10/21/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit

class FillBar: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var outerBar: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var total: CGFloat = 0.0
    var percent: CGFloat = 0.0
    var color: UIColor = .black
    
    // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("FillBar", owner: self, options: nil)
        contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.contentView)
        outerBar.backgroundColor = ColorUtils.GREY_LT
    }
    
    // methods
    func setBarTotal(_ value: CGFloat) {
        self.total = value
    }
    
    func setFillColor(_ color: UIColor) {
        self.color = color
    }
    
    func setFill(_ percent: CGFloat) {
        let frac: CGFloat
        let color: UIColor
        let sign: String
        if percent > 100.0 {
            self.percent = 100.0
            frac = 1.0
            color = .red
            sign = "-"
        } else {
            self.percent = percent
            frac = percent / 100.0
            color = .black
            sign = "+"
        }
        
        let maxWidth = outerBar.frame.width
        let fill = maxWidth * frac
        let fillBar = UIView(frame: CGRect(x: 0.0, y: 0.0, width: fill, height: outerBar.frame.size.height))
        fillBar.backgroundColor = self.color
        for subview in self.outerBar.subviews {
            subview.removeFromSuperview()
        }
        self.outerBar.addSubview(fillBar)
        
        
        let label = String(format: "%.2f", self.total * frac)
        totalLabel.text = "\(sign) $\(label)"
        totalLabel.textColor = color
        
        self.layoutIfNeeded()
        print(fillBar.frame)
        print("")
    }
    
}
