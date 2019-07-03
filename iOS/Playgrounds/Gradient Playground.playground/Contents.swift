//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let grad = CAGradientLayer()
grad.colors = [
    UIColor.red.cgColor,
    UIColor.blue.cgColor
]
grad.locations = [0.0, 1.0]

let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 500.0))
view.backgroundColor = .white

grad.frame = view.bounds
view.layer.addSublayer(grad)

PlaygroundPage.current.liveView = view
