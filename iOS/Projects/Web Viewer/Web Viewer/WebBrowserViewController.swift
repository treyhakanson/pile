//
//  WebBrowserViewController.swift
//  Web Viewer
//
//  Created by David Hakanson on 5/4/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class WebBrowserViewController: UIViewController {

    @IBOutlet weak var webViewer: UIWebView!
    
    @IBAction func closeButtonTapped(sender: UIBarButtonItem) {
        // remove view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        // share page contents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func passUrl(link: NSURL) {
        self.webViewer.loadRequest(NSURLRequest(URL: link))
    }

}
