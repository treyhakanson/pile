//
//  IntervalPicker.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/27/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit

protocol IntervalPickerViewDelegate {
    
    func intervalPickingCanceled() -> Void
    func intervalSelected(minutes: Int, seconds: Int) -> Void
    
}

class IntervalPickerView: UIView {

    var delegate: IntervalPickerViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func cancel(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        delegate.intervalPickingCanceled()
        self.hide()
    }
    
    @IBAction func done(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        let minutes = self.pickerView.selectedRow(inComponent: 0)
        let seconds = self.pickerView.selectedRow(inComponent: 1)
        delegate.intervalSelected(minutes: minutes, seconds: seconds)
        self.hide()
    }
    
    @IBOutlet weak var done: UIButton!
    let intervalPickerData = [
        [Int](0...10), // minutes
        [Int](0...60)  // seconds
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("IntervalPickerView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.contentView)
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.layer.borderColor = ApplicationColors.grey2.cgColor
        self.layer.borderWidth = 1
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
}

extension IntervalPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.intervalPickerData[component][row])"
    }
    
}

extension IntervalPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.intervalPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.intervalPickerData[component].count
    }
    
}
