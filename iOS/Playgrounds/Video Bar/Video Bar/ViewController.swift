//
//  ViewController.swift
//  Video Bar
//
//  Created by David Hakanson on 5/26/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let button = UIButton()
    var isPlaying = false
    
    class VideoBar: UIView {
        
        let circleLayer = CAShapeLayer()
        lazy var animation = CABasicAnimation(keyPath: "strokeEnd")
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .clearColor()
            
            let circlePath = UIBezierPath(ovalInRect: frame).CGPath
            circleLayer.path = circlePath
            circleLayer.fillColor = UIColor.clearColor().CGColor
            circleLayer.strokeColor = UIColor.redColor().CGColor
            circleLayer.lineWidth = 8.0
            circleLayer.strokeEnd = 0.0
            
            self.layer.addSublayer(circleLayer)
            
        }
        
        func startVideoBar() {
            animation.duration = 60.0
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            
            circleLayer.addAnimation(animation, forKey: "animateVideoBar")
            
        }
        
        func stopVideoBar() {
            if circleLayer.animationForKey("animateVideoBar") != nil {
                circleLayer.removeAnimationForKey("animateVideoBar")
            }
        }
        
    }

    var videoBar = VideoBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        videoBar = VideoBar(frame: CGRectMake(0.0, 0.0, 50.0, 50.0))
        self.view.addSubview(videoBar)
        videoBar.center = self.view.center
        videoBar.startVideoBar()
        
        button.frame = CGRectMake(0.0, 0.0, 100.0, 25.0)
        button.setTitle("Button", forState: .Normal)
        button.backgroundColor = .yellowColor()
        button.addTarget(self, action: #selector(toggleVideoBar), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
    }

    func toggleVideoBar() {
        isPlaying = !isPlaying
        if isPlaying {
            videoBar.startVideoBar()
        } else {
            videoBar.stopVideoBar()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

