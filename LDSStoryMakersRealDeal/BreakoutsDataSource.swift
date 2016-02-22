//
//  BreakoutsDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/21/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

let breakoutCellID = "breakoutCell"

class BreakoutsDataSource: NSObject, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(breakoutCellID, forIndexPath: indexPath) as? BreakoutCell
        if (cell ==  nil) {
            tableView.registerNib(UINib(nibName: "CustomBreakoutCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: breakoutCellID)
            tableView.registerClass(BreakoutCell.self, forCellReuseIdentifier: breakoutCellID)
        }
        cell?.backgroundColor = UIColor.clearColor()
        cell?.layer.cornerRadius = 5
        cell?.layer.borderColor = UIColor.blackColor().CGColor
        cell?.layer.borderWidth = 1
        //cell?.breakoutButton.titleLabel?.text = "Breakout"
        cell?.timeLabel.text = "time here"
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
