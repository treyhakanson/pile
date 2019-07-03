//
//  ViewController.swift
//  SuperPopup
//
//  Created by David Hakanson on 5/29/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let superPopup = SuperPopup(isUpvote: false, parentFrame: self.view.frame)
        superPopup.nestButton.addTarget(self, action: #selector(printSomething), forControlEvents: .TouchUpInside)
        self.view.addSubview(superPopup)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func printSomething() {
        print("It works!")
    }

}

