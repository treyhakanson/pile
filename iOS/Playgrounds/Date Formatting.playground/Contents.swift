//: Playground - noun: a place where people can play

import UIKit

extension NSDate {
    func format() -> String {
        //        print("\n###############")
        //        print("Formatting date")
        //        print("###############")
        //        print("time: \(self)")
        var timeDiff = -Int(self.timeIntervalSinceNow)// time in seconds
        
        var weeks: Int = 0
        var days: Int = 0
        var hours: Int = 0
        var minutes: Int = 0
        
        while timeDiff > 0 {
            //            print("timeDiff = \(timeDiff)")
            if Int(timeDiff / 604_800) > 0 { // a week
                timeDiff -= 604_800
                weeks += 1
                continue
            } else if Int(timeDiff / 86_400) > 0 { // a day
                timeDiff -= 86_400
                days += 1
                continue
            } else if Int(timeDiff / 3600) > 0 { // an hour
                timeDiff -= 3600
                hours += 1
                continue
            } else if Int(timeDiff / 300) > 0 { // 5 minutes
                timeDiff -= 300
                minutes += 1
                continue
            } else { // "just now"
                break
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

let date = "2016-07-14T10:10:59.966301".stringByReplacingOccurrencesOfString("T", withString: " ").componentsSeparatedByString(".")[0]



let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd kk:mm:ss"
let formattedDate = dateFormatter.dateFromString(date)
formattedDate?.format()


let names = ["Trey", "Ian", "Greg"]
names.indexOf("Greg")
names.indexOf("Dan")



