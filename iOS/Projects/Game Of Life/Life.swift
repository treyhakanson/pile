//
//  Life.swift
//  Game Of Life
//
//  Created by David Hakanson on 10/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import Foundation

extension Array {
    // Generic
    // common placeholders are T, U, E, K, V; but, anything can be used
    
    // can force generics to conform to certain protocols
    // Ex:
        // func max<T: Comparable>(a: T, b: T) -> T {
        //      return (a > b) ? a : b
        // }
    // the above function only takes variable types that can be compared
    // (conform to the Comparable protocol)
    
    // can also further constrain generics by forcing additional aspects onto them:
//    func max<S: SequenceType where S.Generator.Element: Equatable>(a: [S], b: [S) {  }

    func customFilter(predicate: (Element) -> Bool) -> [Element] {
        return self.filter(predicate)
        
    }
    
}

class Life {
    var cells: [Cell]
    var gridSize: Int = 20
    
    init() {
        cells = [Cell]()
        cells = assignCellsToGrid()
    }
    
    // normally would just us a func, did it this way for practice
    lazy var assignCellsToGrid: () -> [Cell] = {
        [weak self] in
        var cells = [Cell]()
        for x in 0..<self!.gridSize {
            for y in 0..<self!.gridSize {
                cells.append(Cell(x, y))
            }
        }
        return cells
        
    }
    
    func cellNeighbors(cell: Cell) -> [Cell] {
        return self.cells.getNeighbors { self.areNeighbors(cell1: cell, cell2: $0) }
    }
    
    func areNeighbors(cell1: Cell, cell2: Cell) -> Bool {
        let a = abs(cell1.x - cell2.x)
        let b = abs(cell1.y - cell2.y)
        
        if case (0...1, 0...1) = (a, b), !(a == 0 && b == 0) { // if-case structure
            return true
        } else {
            return false
        }
        
        // could use the following structure, but going to use swifts new if-case structure instead
        //
        // switch(a, b) {
        // case (1, 1), (1, 0), (0, 1):
        //      check = true
        // default:
        //      check = false
        // }
        
    }
    
}












