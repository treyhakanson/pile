//
//  ViewController.swift
//  WalletTracker
//
//  Created by David Hakanson on 10/21/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import UIKit
import PieCharts

class ViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var totalSpendLabel: UILabel!
    @IBOutlet weak var totalSpend: PieChart!
    @IBOutlet weak var fillBar1: FillBar!
    @IBOutlet weak var fillBar2: FillBar!
    @IBOutlet weak var fillBar3: FillBar!
    
    @IBAction func settingsButtonClicked(_ sender: UIBarButtonItem) {
        print("Settings Button Clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ColorUtils.MAIN
        
        // for testing
        let fill1Max: CGFloat = 200.00
        let fill2Max: CGFloat = 150.00
        let fill3Max: CGFloat = 150.00
        
        let fill1Act: CGFloat = 107.00
        let fill2Act: CGFloat = 23.00
        let fill3Act: CGFloat = 73.00
        
        fillBar1.setFillColor(ColorUtils.FILL_1)
        fillBar1.setBarTotal(fill1Max)
        fillBar1.setFill(fill1Act / fill1Max * 100.0)
        
        fillBar2.setFillColor(ColorUtils.FILL_2)
        fillBar2.setBarTotal(fill2Max)
        fillBar2.setFill(fill2Act / fill2Max * 100.0)
        
        fillBar3.setFillColor(ColorUtils.FILL_3)
        fillBar3.setBarTotal(fill3Max)
        fillBar3.setFill(fill3Act / fill3Max * 100.0)
        
        totalSpendLabel.text = "$\(fill1Act + fill2Act + fill3Act)"
        
        totalSpend.models = [
            PieSliceModel(value: Double(fill1Act), color: ColorUtils.FILL_1),
            PieSliceModel(value: Double(fill2Act), color: ColorUtils.FILL_2),
            PieSliceModel(value: Double(fill3Act), color: ColorUtils.FILL_3)
        ]
    }

}
