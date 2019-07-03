//
//  CropGridView.swift
//  hatch1.2
//
//  Created by David Hakanson on 4/18/16.
//  Copyright © 2016 Gain llc. All rights reserved.
//

import UIKit

class CropView: UIView {
    
    // offset outer width by stroke width of inner grid
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let dim = min(frame.width, frame.height)
        let gridWidth: CGFloat = 2.0
        
        super.init(frame: CGRectMake(0.0, 0.0, dim, dim))
        
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
            if let shapeLayer: CAShapeLayer = layer as? CAShapeLayer {
                shapeLayer.strokeColor = color.CGColor
            }
        }
    }
    
}
