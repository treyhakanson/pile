////: Playground - noun: a place where people can play
//
import UIKit
//import XCPlayground
//
//let iPhone = UIView(frame: CGRectMake(0.0, 0.0, 360, 640))
//iPhone.backgroundColor = .whiteColor()
//XCPlaygroundPage.currentPage.liveView = iPhone
//
//extension UIColor {
//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//        
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//    
//    convenience init(netHex:Int) {
//        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
//    }
//}
//
//let tmpView = UIView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0))
//tmpView.center = iPhone.center
//tmpView.backgroundColor = UIColor(netHex: 0xA0A0A0)
//iPhone.addSubview(tmpView)
//
//let filmIconWidth: CGFloat = 50.0
//let filmIconHeight: CGFloat = filmIconWidth*10.0/9.0
//
//let filmIcon = CAShapeLayer()
//
//class SmallSquare: CAShapeLayer {
//    
//    override init() {
//        super.init()
//        let smallSquare1 = CAShapeLayer()
//        smallSquare1.path = UIBezierPath(rect: CGRectMake(0.0, 0.0, filmIconHeight/5.0, filmIconHeight/5.0)).CGPath
//        smallSquare1.fillColor = UIColor.whiteColor().CGColor
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//let smallSquare1 = CAShapeLayer()
//smallSquare1.path = UIBezierPath(rect: CGRectMake(0.0, 0.0, filmIconHeight/5.0, filmIconHeight/5.0)).CGPath
//smallSquare1.fillColor = UIColor.whiteColor().CGColor
//
//let smallSquare2 = smallSquare1
//let smallSquare3 = smallSquare1
//let smallSquare4 = smallSquare1
//let smallSquare5 = smallSquare1
//let smallSquare6 = smallSquare1

extension NSDate {
    func format() -> String {
        var timeDiff = floor(self.timeIntervalSinceNow/1000.0) // time in seconds
        
        var weeks: Int = 0
        var days: Int = 0
        var hours: Int = 0
        var minutes: Int = 0
        
        while timeDiff > 0 {
            if (timeDiff % 604_800) > 0 { // a week
                timeDiff /= 604_800
                weeks += 1
                continue
            } else if (timeDiff % 86_400) > 0 { // a day
                timeDiff /= 86_400
                days += 1
                continue
            } else if (timeDiff % 3600) > 0 { // an hour
                timeDiff /= 3600
                hours += 1
                continue
            } else if (timeDiff % 300) > 0 { // 5 minutes
                timeDiff /= 300
                minutes += 1
                continue
            } else { // "just now"
                continue
            }
            
        }
        
        let timeString: String
        
        if weeks > 0 {
            timeString = "\(weeks) wk"
        } else if days > 0 {
            timeString = "\(days) d"
        } else if hours > 0 {
            timeString = "\(hours) h"
        } else if minutes > 0 {
            timeString = "\(minutes) m"
        } else {
            timeString = "just now"
        }
        
        return timeString
        
    }
    
}

let date = NSDate(timeIntervalSinceNow: NSTimeInterval(7924147))
date.format()

















