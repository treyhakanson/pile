//
//  ViewController.swift
//  ImageViewPractice
//
//  Created by David Hakanson on 12/2/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var hideImagesButton: UIButton!
    @IBOutlet weak var showImagesButton: UIButton!
    
    
    @IBAction func showImages(sender: UIButton) {
        if (firstImage.hidden || secondImage.hidden){
            firstImage.hidden = false
            firstImage.image = UIImage(named: "coffee")
            secondImage.hidden = false
            secondImage.image = UIImage(named: "segue")
            
            showImagesButton.hidden = true
            hideImagesButton.hidden = false
            
            view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func hideImages(sender: UIButton) {
        if(!firstImage.hidden || !firstImage.hidden){
            firstImage.hidden = true
            secondImage.hidden = true
            
            hideImagesButton.hidden = true
            showImagesButton.hidden = false
            
            view.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

