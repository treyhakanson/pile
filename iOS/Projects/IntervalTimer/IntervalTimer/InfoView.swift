//
//  InfoView.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/26/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    var onTap: ((Any) -> Void)?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBAction func infoViewTapped(_ sender: Any) {
        guard let onTap = self.onTap else { return }
        onTap(sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.contentView)
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setValue(text: String) {
        self.valueLabel.text = text
    }
    
    func setValue(seconds s: Int) {
        self.valueLabel.text = Utils.toDisplayTime(seconds: s)
    }
    
}
