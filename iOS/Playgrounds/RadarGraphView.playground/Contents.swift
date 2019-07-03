//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

var screen = UIView(frame: CGRectMake(0.0, 0.0, 700.0, 350.0))
screen.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = screen

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
}

class RadarGraph: UIView {
    
    // MARK: Class Constants
    let lineWidth: CGFloat = 2.0
    let strokeColor: UIColor = UIColor(netHex: 0x232323)
    var categories: [(name: String, fillProportion: CGFloat, color: UIColor)] = []
    
    // MARK: Numeric Variables
    var numPoints: Int = 0
    var endPoints: [CGPoint] = []
    
    // MARK: View Variables
    var baseLayer: CAShapeLayer = CAShapeLayer()
    
    convenience init(frame: CGRect, categories: [(name: String, fillProportion: CGFloat, color: UIColor)]) {
        self.init(frame: frame)
        self.categories = categories
        numPoints = categories.count
        
        let length = min(frame.height, frame.width)/2.0
        let theta = 360.0/CGFloat(numPoints)*CGFloat(M_PI)/180.0
        let spokePath = UIBezierPath()
        let shapePath = UIBezierPath()
        let plotPath = UIBezierPath()
        
        var prevPoint = CGPointZero
        
        for i in 0..<numPoints {
            let angle = theta*CGFloat(i)

            let x =  length * sin(angle)
            let y =  length * cos(angle)
            let point = CGPoint(x: x, y: y)
            
            let x1 = length * categories[i].fillProportion * sin(angle)
            let y1 = length * categories[i].fillProportion * cos(angle)
            let plotPoint = CGPoint(x: x1, y: y1)
            
            if i == 0 {
                shapePath.moveToPoint(point)
                plotPath.moveToPoint(plotPoint)
            } else {
                shapePath.addLineToPoint(point)
                plotPath.addLineToPoint(plotPoint)
            }
            
            spokePath.addLineToPoint(prevPoint)
            spokePath.moveToPoint(CGPointZero)
            spokePath.addLineToPoint(point)
            prevPoint = point
            
            endPoints.append(point)
            
        }
        
        if let firstPoint = endPoints.first { shapePath.addLineToPoint(firstPoint) }
        
        let spokeLayer = CAShapeLayer()
        spokeLayer.lineWidth = 2.0
        spokeLayer.strokeColor = strokeColor.CGColor
        spokeLayer.fillColor = UIColor.clearColor().CGColor
        spokeLayer.path = spokePath.CGPath
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeColor = strokeColor.CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.path = shapePath.CGPath
        
        let plotLayer = CAShapeLayer()
        let plotColor = (self.categories.sort() { $0.fillProportion > $1.fillProportion })[0].color
        plotLayer.fillColor = plotColor.colorWithAlphaComponent(0.65).CGColor
        plotLayer.path = plotPath.CGPath
        
        baseLayer.addSublayer(shapeLayer)
        baseLayer.addSublayer(spokeLayer)
        baseLayer.addSublayer(plotLayer)
        self.layer.addSublayer(baseLayer)
        
        baseLayer.position = CGPointMake(frame.width/2.0, frame.height/2.0)
        baseLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
        
        generateLabels()
        
    }
    
    func generateLabels() {
        for (i, point) in endPoints.enumerate() {
            let category = categories[i]
            let labelLayer = CATextLayer()
            let center = baseLayer.position
            
            labelLayer.frame = CGRectMake(0, 0, 100, 30);
            labelLayer.foregroundColor = UIColor.blueColor().CGColor
            labelLayer.font = UIFont(name: "Avenir-Heavy", size: 18.0)!
            labelLayer.fontSize = 18
            labelLayer.string = category.name
            labelLayer.alignmentMode = kCAAlignmentCenter
            labelLayer.contentsScale = UIScreen.mainScreen().scale
            
            let x: CGFloat
            if point.x > 0 {
                x = point.x + 20.0
            } else if point.x == 0 {
                x = point.x
            } else {
                x = point.x - 20.0
            }
            
            let y: CGFloat
            if point.y > 0 {
                y = point.y + 20.0
            } else if point.y == 0 {
                y = point.y
            } else {
                y = point.y - 20.0
            }
            labelLayer.position = CGPointMake(x, y)
            labelLayer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
            baseLayer.addSublayer(labelLayer)
            
        }
        
    }

}

let categories: [(name: String, fillProportion: CGFloat, color: UIColor)] = [
    ("Business", 4.0/10.0, UIColor(netHex: 0xFFF000)),
    ("Random", 2.0/10.0, UIColor(netHex: 0xFFF0F0)),
    ("Design", 10.0/10.0, UIColor(netHex: 0xFFFF00)),
    ("Technology", 5.0/10.0, UIColor(netHex: 0x0000FF))
]
let radarGraph: RadarGraph = RadarGraph(
    frame: CGRectMake(0.0, 0.0, 250.0, 250.0),
    categories: categories)
radarGraph.backgroundColor = .whiteColor()
radarGraph.center = screen.center

radarGraph.transform = CGAffineTransformMakeScale(0.0, 0.0)
UIView.animateWithDuration(0.35) { 
    radarGraph.transform = CGAffineTransformMakeScale(1.0, 1.0)
}

screen.addSubview(radarGraph)

//class BarGraphView: UIView {
//    
//    class LabelGroup: UIView {
//        var upperLabel: UILabel = UILabel()
//        var lowerLabel: UILabel = UILabel()
//        
//        convenience init(frame: CGRect, upperText: String, lowerText: String) {
//            self.init(frame: frame)
//            
//            upperLabel.frame = CGRectMake(0.0, 0.0, frame.width, 2.0/3.0*frame.height)
//            upperLabel.attributedText = NSAttributedString(string: upperText, attributes: [
//                NSFontAttributeName : UIFont(name: "Avenir-Heavy", size: 32.0)!,
//                NSForegroundColorAttributeName : UIColor.blackColor()])
//            upperLabel.textAlignment = .Center
//            
//            lowerLabel.frame = CGRectMake(0.0, 1.5/3.0*frame.height, frame.width, 1.0/3.0*frame.height)
//            lowerLabel.attributedText = NSAttributedString(string: lowerText, attributes: [
//                NSFontAttributeName : UIFont(name: "Avenir-Medium", size: 22.0)!,
//                NSForegroundColorAttributeName : UIColor.blackColor()])
//            lowerLabel.textAlignment = .Center
//            
//            self.addSubview(upperLabel)
//            self.addSubview(lowerLabel)
//            
//        }
//        
//        
//    }
//    
//    var upperBar: CAShapeLayer = CAShapeLayer()
//    var upperBarLabelGroup: LabelGroup = LabelGroup()
//    
//    var middleBar: CAShapeLayer = CAShapeLayer()
//    var middleBarLabelGroup: LabelGroup = LabelGroup()
//    
//    var lowerBar: CAShapeLayer = CAShapeLayer()
//    var lowerBarLabelGroup: LabelGroup = LabelGroup()
//    
//    convenience init(frame: CGRect, upperBarFill: CGFloat, middleBarFill: CGFloat, lowerBarFill: CGFloat) {
//        self.init(frame: frame)
//        
//        let barLength = frame.width*7.0/10.0
//        let barHeight = frame.height/9.0
//        let barBufferX = frame.width/10.0
//        let barBufferY = (frame.height - 2.0*barHeight)/3.0
//        let barFrameHeight = frame.height/3.0
//        
//        let upperPath = UIBezierPath()
//        upperPath.moveToPoint(CGPointMake(0.0, barFrameHeight/2.0))
//        upperPath.addLineToPoint(CGPointMake(barLength*upperBarFill, barFrameHeight/2.0))
//        upperBar.frame = CGRectMake(0.0, 0.0, barLength, barFrameHeight)
//        upperBar.strokeColor = UIColor.redColor().CGColor
//        upperBar.lineWidth = barFrameHeight
//        
//        upperBar.path = upperPath.CGPath
//        upperBar.strokeEnd = 0.0
//        
//        let upperAnimation = CASpringAnimation(keyPath: "strokeEnd")
//        upperAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        upperAnimation.duration = upperAnimation.settlingDuration
//        upperAnimation.damping = 5.0
//        upperAnimation.speed = 1.0
//        upperAnimation.fromValue = 0.0
//        upperAnimation.toValue = 1.0
//        upperAnimation.fillMode = kCAFillModeForwards
//        upperAnimation.removedOnCompletion = false
//        upperBar.addAnimation(upperAnimation, forKey: nil)
//        
//        let upperLabelGroup = LabelGroup(frame: CGRectMake(barLength, 0.0, frame.width - barLength - 10.0, barFrameHeight), upperText: "##", lowerText: "Downvotes")
//        let middleLabelGroup = LabelGroup(frame: CGRectMake(barLength, barFrameHeight, frame.width - barLength - 10.0, barFrameHeight), upperText: "##", lowerText: "Saves")
//        let lowerLabelGroup = LabelGroup(frame: CGRectMake(barLength, barFrameHeight*2.0, frame.width - barLength - 10.0, barFrameHeight), upperText: "##", lowerText: "Upvotes")
//        
//        let middlePath = UIBezierPath()
//        middlePath.moveToPoint(CGPointMake(0.0, barFrameHeight/2.0))
//        middlePath.addLineToPoint(CGPointMake(barLength*middleBarFill, barFrameHeight/2.0))
//        middleBar.frame = CGRectMake(0.0, barFrameHeight, barLength, barFrameHeight)
//        middleBar.strokeColor = UIColor.blueColor().CGColor
//        middleBar.lineWidth = barFrameHeight
//        middleBar.lineCap = kCALineCapRound
//        middleBar.path = middlePath.CGPath
//        
//        let middleAnimation = CASpringAnimation(keyPath: "strokeEnd")
//        middleAnimation.duration = upperAnimation.settlingDuration
//        middleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        middleAnimation.damping = 5.0
//        middleAnimation.speed = 1.0
//        middleAnimation.fromValue = 0.0
//        middleAnimation.toValue = 1.0
//        middleAnimation.fillMode = kCAFillModeForwards
//        middleAnimation.removedOnCompletion = false
//        middleBar.addAnimation(middleAnimation, forKey: nil)
//        
//        let lowerPath = UIBezierPath()
//        lowerPath.moveToPoint(CGPointMake(0.0, barFrameHeight/2.0))
//        lowerPath.addLineToPoint(CGPointMake(barLength*lowerBarFill, barFrameHeight/2.0))
//        lowerBar.frame = CGRectMake(0.0, barFrameHeight*2.0, barLength, barFrameHeight)
//        lowerBar.strokeColor = UIColor.greenColor().CGColor
//        lowerBar.lineWidth = barFrameHeight
//        lowerBar.lineCap = kCALineCapRound
//        lowerBar.path = lowerPath.CGPath
//        
//        let lowerAnimation = CASpringAnimation(keyPath: "strokeEnd")
//        lowerAnimation.duration = upperAnimation.settlingDuration
//        lowerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        lowerAnimation.damping = 5.0
//        lowerAnimation.speed = 1.0
//        lowerAnimation.fromValue = 0.0
//        lowerAnimation.toValue = 1.0
//        lowerAnimation.fillMode = kCAFillModeForwards
//        lowerAnimation.removedOnCompletion = false
//        lowerBar.addAnimation(lowerAnimation, forKey: nil)
//        
//        self.addSubview(upperLabelGroup)
//        self.addSubview(middleLabelGroup)
//        self.addSubview(lowerLabelGroup)
//        self.layer.addSublayer(upperBar)
//        self.layer.addSublayer(middleBar)
//        self.layer.addSublayer(lowerBar)
//        
//    }
//    
//}
//
//let barGraphView = BarGraphView(frame: CGRectMake(0.0, 0.0, 700.0, 350.0), upperBarFill: 6.0/10.0, middleBarFill: 2.0/10.0, lowerBarFill: 4.0/10.0)
//screen.addSubview(barGraphView)










