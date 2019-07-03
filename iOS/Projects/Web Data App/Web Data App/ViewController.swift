//
//  ViewController.swift
//  Web Data App
//
//  Created by David Hakanson on 12/29/15.
//  Copyright © 2015 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See plist file for how it needs to be changed to accomodate URLs that aren't https
        
        let url = NSURL(string: "http://stackoverflow.com")!
        
        // To display webpage straight up without first downloading html
        webView.loadRequest(NSURLRequest(URL: url))
        
        
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
//            // Runs on completion of task
//            // Interesting structure; if data exsists, the variable will be created and the code will proceed through the if statement
//            if let urlContent = data {
//                
//                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
//                
//                // This will dispatch the queue as soon as the data is downloaded
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    //Displays downloaded html
//                    self.webView.loadHTMLString(String(webContent!), baseURL: nil)
//                })
//                
//            }else {
//                // If this else is hit, something went wrong, such as the user did not have an internet connection
//            }
//        }
//        
//        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

