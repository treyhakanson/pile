//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class ViewController: UIViewController {
    var timer = NSTimer()
    var timeRecorded = 0.0
    // button
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer(timeInterval: 0.1, target: self, selector: #selector(updateVideoBar), userInfo: nil, repeats: true)
        
        timer.fire() // button tapped
    }
    
    func updateVideoBar() {
        timeRecorded += (1.0/60.0)
        // video bar width = width of screen * time recorded (1 minute max)
    }
    
    // button tapped again -> timer.invalidate(), reset video bar
    
}

let view = UIView(frame: CGRectMake(0.0,0.0,375.0,675.0))
view.backgroundColor = .blackColor()
XCPlaygroundPage.currentPage.liveView = view















