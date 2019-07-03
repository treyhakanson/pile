//: Playground - noun: a place where people can play

import UIKit

// if a custom table cell with a button in it is tapped, a static var of the implementing custom table view is set to is active
// an implementing viewcontrolle could then monitor this static with a willSet to respond appropriately
class CustomTableView: UITableView {
    static var cellIsActive = false { // no cell is active by default
        didSet {
            if cellIsActive {
                // a cell is active, do something like display a message
            } else {
                // no cells are active, do something like hide any messages
            }
        }
    }
}

class CustomTableViewCell: UITableViewCell {
    var button: UIButton
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        button = UIButton(frame: CGRectMake(0.0, 0.0, 25.0, 25.0))
        button.addTarget(self, action: #selector(someAction), forControlEvents: .TouchUpInside)
    }
    
    func someAction() {
        CustomTableView.cellIsActive = true
    }
    
}
