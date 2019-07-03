//
//  NavBarCollapseTableViewController.swift
//  NavBar Interactions Test
//
//  Created by David Hakanson on 1/16/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class NavBarCollapseTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
    let screenWidth = UIScreen.mainScreen().bounds.width
    var navigationBarHeight: CGFloat?
    var topBannerBackgroundColor = UIColor.darkGrayColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        let topBanner = UIView(frame: CGRectMake(0, 0, screenWidth, statusBarHeight))
        topBanner.backgroundColor = self.topBannerBackgroundColor
        view.window!.addSubview(topBanner)
    
    }
    
}