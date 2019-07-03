//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let vc = UIViewController()
vc.view.backgroundColor = .white
vc.view.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 675.0)
PlaygroundPage.current.liveView = vc

class ModalPageViewController: UIPageViewController {
    
    convenience init(frame: CGRect) {
        self.init()
        self.view.frame = frame
    }
    
}

let modal = ModalPageViewController(frame: CGRect(x: 50.0, y: 87.5, width: 275.0, height: 500.0))
modal.view.backgroundColor = .red

vc.present(modal, animated: true)
