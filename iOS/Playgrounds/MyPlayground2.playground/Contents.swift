//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375, height: 675.0))
view.backgroundColor = .white
PlaygroundPage.current.liveView = view

class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 150, y: 150))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 150, y: 250))
        
        path.lineWidth = 25.0
        
        UIColor.darkGray.setStroke()
        path.stroke()
    }
    
}

let customView = CustomView(frame: CGRect(x: 0.0, y: 0.0, width: 400.0, height: 400.0))
view.addSubview(customView)