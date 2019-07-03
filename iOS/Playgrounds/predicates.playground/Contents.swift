import UIKit

class Ball {
    var color: String
    var size: Int
    
    required init(color: String, size: Int) {
        self.color = color
        self.size = size
    }
    
}

let balls: [Ball] = [Ball(color: "yellow", size: 1), Ball(color: "blue", size: 2)]

if let i = balls.indexOf({$0.color == "blue"}) {
    print("matching index: \(i)")
}
