//
//  BreakoutsDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/21/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

let breakoutCellID = "breakoutCellID"

class BreakoutsDataSource: NSObject, UITableViewDataSource {
    var breakoutsByDay:[Breakout] = []
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            
            break
        default:
            break
        }
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(breakoutCellID, forIndexPath: indexPath) as? BreakoutCell
       cell?.backgroundColor = UIColor.clearColor()
//        cell?.layer.cornerRadius = 10
//        cell?.layer.shadowColor = UIColor.blackColor().CGColor
//        cell?.layer.shadowOffset = CGSizeMake(0.0, 2.0)
//        cell?.layer.shadowRadius = 5
//        cell?.layer.shadowOpacity = 0.3
//        cell?.layer.masksToBounds = false
        cell?.breakoutLabel.layer.borderColor = UIColor.blackColor().CGColor
       // cell?.breakoutLabel.layer.cornerRadius = 10
        cell?.breakoutLabel.backgroundColor = UIColor.whiteColor()
        cell?.breakoutLabel.layer.shadowOpacity = 0.3
        cell?.breakoutLabel.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        cell?.breakoutLabel.layer.shadowRadius = 5
       // cell?.breakoutLabel.layer.masksToBounds = true
        
        let breakoutAtIndex = self.breakoutsByDay[indexPath.section]
        cell?.breakoutLabel.numberOfLines = 2
        if let startDate = breakoutAtIndex.startTime {
            if let endDate = breakoutAtIndex.endTime {
                cell?.breakoutLabel.text = String(format:"Breakout %@ \n  %@ to %@", breakoutAtIndex.breakoutID!,NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle),NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
            }
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func updateBreakoutsArray(with array:[Breakout]) {
        self.breakoutsByDay = array
    }

    
}

