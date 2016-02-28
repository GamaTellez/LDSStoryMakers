//
//  TableViewDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var days:[Day] = []
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("nextClassCell", forIndexPath: indexPath) as! NextClassCell
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        return 1
    }
       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}
