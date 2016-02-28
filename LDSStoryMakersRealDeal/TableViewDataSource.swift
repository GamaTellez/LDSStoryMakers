//
//  TableViewDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var classesInSchedule:[ClassScheduled] = []
    let kNextClassID = "nextClassCell"
    let kupcomingClassID = "upcomingClass"
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(self.kNextClassID, forIndexPath: indexPath) as! NextClassCell
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(self.kupcomingClassID, forIndexPath: indexPath) as! UpcomingClassCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 10
        }
        return 1
    }
       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func updateArrayForDataSource(alreadyScheduledClasses:[ClassScheduled]) {
        self.classesInSchedule = alreadyScheduledClasses
    }
}
