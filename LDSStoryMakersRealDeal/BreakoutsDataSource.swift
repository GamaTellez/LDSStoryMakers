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
        return self.breakoutsByDay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(breakoutCellID, forIndexPath: indexPath) as? BreakoutCell
        let breakoutAtIndex = self.breakoutsByDay[indexPath.section]
        if let startDate = breakoutAtIndex.valueForKey("startTime") as? NSDate {
            if let endDate = breakoutAtIndex.valueForKey("endTime") as? NSDate {
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

