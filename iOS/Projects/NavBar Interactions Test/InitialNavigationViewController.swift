//
//  InitialNavigationViewController.swift
//  NavBar Interactions Test
//
//  Created by David Hakanson on 1/16/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class InitialNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        UINavigationBar.appearance().barTintColor = UIColor.redColor()
        self.navigationController?.navigationBar.translucent = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
