//: Playground - noun: a place where people can play

import Foundation

func interpreter(_ prog: String) -> String {
    var idx = 0
    var out = [0]
    var val = ""
    
    for char in prog.characters {
        switch char {
        case ">":
            idx += 1
            if idx > out.count - 1 {
                out.append(0)
            }
        case "<":
            idx -= 1
            if idx < 0 {
                out.insert(0, at: 0)
                idx = 0;
            }
        case "+":
            out[idx] += 1
            if out[idx] == 256 {
                out[idx] = 0
            }
        case "*":
            val.append(Character(UnicodeScalar(out[idx])!))
        default: break
        }
    }
    
    return val
}

let raw = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++**>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*<<*>>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*<<<<*>>>>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++*"
let str = interpreter(raw)
print(str)
