//: Playground - noun: a place where people can play

import UIKit

// subscripts are in square brackets, and can be specified using the keyword subscript with getters and setters. 
// subscripts can be set for any type (not a variable though)

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier*index // can drop the get keyword if read-only
    }
}

let twosTimesTable = TimesTable(multiplier: 2)
twosTimesTable[3]
twosTimesTable[8]

// subscript overloading allows for multiple subscripts to be defined for different input types
// can have inputs of any type, and can even be variadic (cannot be inout, or set default values)
struct OverloadedStruct {
    subscript(val: String) -> Int {
        return Int(val)!
    }
    subscript(val: Int) -> String {
        return String(val)
    }
}

let test = OverloadedStruct()
test["100"]
test[25]

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows*columns, repeatedValue: 0.0)
    }
    
    func indexIsValidFor(row row: Int, column: Int) -> Bool {
        return (row >= 0 && row < rows) && (column >= 0 && column < columns)
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidFor(row: row, column: column), "Index out of range")
            let index = (row*columns) + column
            return grid[index]
        }
        set {
            assert(indexIsValidFor(row: row, column: column), "Index out of range")
            let index = (row*columns) + column
            grid[index] = newValue
        }
    }
    
}

var a = Matrix(rows: 5, columns: 5)
a.indexIsValidFor(row: 0, column: 0)
a.indexIsValidFor(row: -1, column: 0)
a.indexIsValidFor(row: 4, column: 4)
a.indexIsValidFor(row: 5, column: 5)

a[0,0]
a[3,1] = 10.0
a[3,1]










