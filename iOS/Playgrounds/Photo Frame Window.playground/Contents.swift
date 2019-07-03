//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
XCPShowView("container", view: container)

container.backgroundColor = UIColor.blueColor()

class CropView: UIView {
    
    // offset outer width by stroke width of inner grid
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let dim = min(frame.width, frame.height)
        let outerWidth: CGFloat = 7.0
        let gridWidth: CGFloat = 1.0
        
        //        super.init(frame: CGRectMake(frame.size.width/2.0 - dim/(1.5*2.0), frame.size.height/2.0 - dim/(1.5*2.0), dim/1.5, dim/1.5))
        super.init(frame: CGRectMake(0.0, 0.0, dim, dim))
        
//        let rectLayer = CAShapeLayer()
//        rectLayer.lineWidth = outerWidth
//        rectLayer.fillColor = UIColor.clearColor().CGColor
//        rectLayer.lineJoin = kCALineCapButt
//        rectLayer.lineCap = kCALineCapSquare
//        let smallStroke = self.frame.width/6.0
//        let medStroke = self.frame.width*2.0/6.0
//        let longStroke = self.frame.width*4.0/6.0
//        rectLayer.lineDashPattern = [
//            smallStroke, longStroke,
//            medStroke, longStroke,
//            medStroke, longStroke,
//            medStroke, longStroke,
//            longStroke, smallStroke
//        ]
//        rectLayer.path = UIBezierPath(rect: CGRectMake(0.0, 0.0, dim/1.5, dim/1.5)).CGPath
//        self.layer.addSublayer(rectLayer)
        
        for i in 0...2 {
            for j in 0...2 {
                let gridDim = min(self.frame.width, self.frame.height)
                let gridComp = CAShapeLayer()
                gridComp.lineWidth = gridWidth
                gridComp.strokeColor = UIColor.whiteColor().CGColor
                gridComp.fillColor = UIColor.clearColor().CGColor
                gridComp.path = UIBezierPath(rect: CGRectMake(gridDim/3.0*CGFloat(i), gridDim/3.0*CGFloat(j), gridDim/3.0, gridDim/3.0)).CGPath
                self.layer.addSublayer(gridComp)
            }
        }
        
    }
    
    func setColor(color: UIColor) {
        for layer in self.layer.sublayers! {
            print("here")
            if let shapeLayer: CAShapeLayer = layer as? CAShapeLayer {
                shapeLayer.strokeColor = color.CGColor
            }
        }
    }
    
}

let cropView: CropView = CropView(frame: container.frame)
cropView.setColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
cropView.transform = CGAffineTransformMakeTranslation(0.0, 15.0)
container.addSubview(cropView)












