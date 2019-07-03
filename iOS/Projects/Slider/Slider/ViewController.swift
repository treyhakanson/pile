//
//  ViewController.swift
//  Slider
//
//  Created by David Hakanson on 12/2/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    @IBAction func sliderValue(sender: UISlider) {
        // Sender is the element being changed; the one calling the method, which in this case is the slider
        //label.text = String(floor(sender.value))
    }
    
    @IBAction func showSliderValue(sender: AnyObject) {
        label.text = String(Int(slider.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

