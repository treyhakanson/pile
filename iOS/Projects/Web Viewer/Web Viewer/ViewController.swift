//
//  ViewController.swift
//  Web Viewer
//
//  Created by David Hakanson on 5/4/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let webViewController = WebBrowserViewController(nibName: "WebBrowserViewController", bundle: nil)
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func linkButtonTapped(sender: UIButton!) {
        if var link = sender.titleLabel?.text {
            link = link.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            let index1 = link.startIndex.advancedBy(8)
            let index2 = link.startIndex.advancedBy(7)
            let httpString = link.substringToIndex(index2)
            let httpsString = link.substringToIndex(index1)
            
            if httpsString != "https://" && httpString != "http://" {
                link = "http://" + link
                print(link)
            }
            
            if let url = NSURL(string: link) {
                if UIApplication.sharedApplication().canOpenURL(url) {
                    self.presentViewController(webViewController, animated: true, completion: { 
                        self.webViewController.passUrl(url)
                    })
                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button.setTitle("https://google.com", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

