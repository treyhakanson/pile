//
//  GameBoard.swift
//  Game Of Life
//
//  Created by David Hakanson on 10/2/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

private extension UIColor {
    static let living =     UIColor(red: 54/255, green: 127/255, blue: 255/255, alpha: 1.0)
    static let prebirth =   UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
    static let dead =       UIColor(red: 0/255, green: 56/255, blue: 153/255, alpha: 1.0)
}

class Gameboard: UIView {
    let life: Life
    
    init(with life: Life) {
        self.life = life
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        for cell in life.cells {
            ctx.setFillColor(cellColor(for: cell.state).cgColor)
            ctx.addRect(cellFrame(for: cell))
            ctx.fillPath()
        }
        
    }
    
    func cellColor(for state: State) -> UIColor {
        switch state {
        case .living:
            return .living
        case .prebirth:
            return .prebirth
        case .dead:
            return .dead
        }
    }
    
    func cellFrame(for cell: Cell) -> CGRect {
        let dimen = CGFloat(life.gridSize)
        let cellSize = CGSize(
            width: self.bounds.width/dimen,
            height: self.bounds.height/dimen
        )
        return CGRect(
            x: CGFloat(cell.x) * cellSize.width,
            y: CGFloat(cell.y) * cellSize.height,
            width: cellSize.width,
            height: cellSize.height
        )
        
    }

}
