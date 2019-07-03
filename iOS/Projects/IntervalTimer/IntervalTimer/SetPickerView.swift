//
//  SetPickerView.swift
//  IntervalTimer
//
//  Created by David Hakanson on 7/27/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit

protocol SetPickerViewDelegate {
    
    func setPickingCanceled() -> Void
    func setsSelected(_: Int) -> Void
    
}

class SetPickerView: UIView {

    var delegate: SetPickerViewDelegate?
    
    let setPickerData = [[Int](0...15)]
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func cancel(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        delegate.setPickingCanceled()
        self.hide()
    }
    
    @IBAction func done(_ sender: Any) {
        guard let delegate = self.delegate else { return }
        let sets = self.pickerView.selectedRow(inComponent: 0)
        delegate.setsSelected(sets)
        self.hide()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SetPickerView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(self.contentView)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.layer.borderColor = ApplicationColors.grey2.cgColor
        self.layer.borderWidth = 1
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }

}

extension SetPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.setPickerData[component][row])"
    }
    
}

extension SetPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.setPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.setPickerData[component].count
    }
    
}
