//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 675.0))
XCPShowView("container", view: container)

class animatedSquareButton: UIView {
    
    var btn: UIButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.btn.frame = frame
    }
    
    func setColor(color: UIColor) {
        self.backgroundColor = color
        self.btn.backgroundColor = color
    }
    
    func setButtonImage(image: UIImage) {
        self.btn.setImage(image, forState: [.Normal, .Highlighted, .Selected])
    }
    
    func toggle() {
        self.btn.enabled = false
        self.btn.transform = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(0.5, delay: 0.25, usingSpringWithDamping: 0.25, initialSpringVelocity: 5.0, options: [], animations: {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }) { (finished) in
            self.btn.enabled = true
        }
    }
    
}

let view: animatedSquareButton = animatedSquareButton(frame: CGRectMake(0, 0, 200, 200))
view.setColor(UIColor.redColor())
container.addSubview(view)


