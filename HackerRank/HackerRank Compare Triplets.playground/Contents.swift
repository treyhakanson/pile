import Foundation

// Enter your code here
let a = (5, 6, 7)
let b = (3, 6, 10)

func score(_ a: (Int, Int, Int), _ b: (Int, Int, Int)) -> (a: Int, b: Int) {
    var aScore = 0
    var bScore = 0
    
    let increment = { (_ a: Int, _ b: Int) -> Void in
        if a > b {
            aScore += 1
        } else if a < b {
            bScore += 1
        }
    }
    
    increment(a.0, b.0)
    increment(a.1, b.1)
    increment(a.2, b.2)
    
    return (a: aScore, b: bScore)
}

let abScore = score(a, b)
print("\(abScore.a) \(abScore.b)")