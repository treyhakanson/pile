//
//  TableViewContoller.swift
//  NavBar Interactions Test
//
//  Created by David Hakanson on 1/16/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class TableViewController: NavBarCollapseTableViewController {

    override func viewDidLoad() {
        self.topBannerBackgroundColor = UIColor.redColor()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50;
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        tableCell.textLabel?.text = "test Content \(indexPath.row)"
        
        return tableCell
        
    }
    
}
