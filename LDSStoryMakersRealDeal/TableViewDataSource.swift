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
        //check it is not empty, it is crashing because of that
        
        switch indexPath.section {
        case 0:
            let scheduledClass = self.classesInSchedule[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(self.kNextClassID, forIndexPath: indexPath) as! NextClassCell
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            if let start = scheduledClass.breakOut?.startTime {
                if let end = scheduledClass.breakOut?.endTime {
                    let startTime = NSDateFormatter.localizedStringFromDate(start, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    let endTime = NSDateFormatter.localizedStringFromDate(end, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    cell.timeLabel.text = String(format: "%@ - %@", startTime, endTime)
                }
            }
            if let className = scheduledClass.presentation?.title {
                cell.speakerAndClassNameLabel.text = className
                if let speakerName = scheduledClass.presentation?.speakerName {
                   cell.speakerAndClassNameLabel.text = String(format: "@% , @%", className, speakerName)
                }
            } else {
                if let breakoutName = scheduledClass.breakOut?.breakoutID {
                    cell.speakerAndClassNameLabel.text = breakoutName
                }
            }
            if let classDescription = scheduledClass.presentation?.presentationDescription {
                cell.classDescription.text = classDescription
            }
            return cell
        default:
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCellWithIdentifier("fullSchedule")
                cell?.contentView.backgroundColor = UIColor.clearColor()
                cell?.backgroundColor = UIColor.clearColor()
                cell?.textLabel?.textColor = UIColor.whiteColor()
                return cell!
            } else {
            let scheduledClass = self.classesInSchedule[indexPath.row + 1]
            let cell = tableView.dequeueReusableCellWithIdentifier(self.kupcomingClassID, forIndexPath: indexPath) as! UpcomingClassCell
            cell.backgroundColor = UIColor.clearColor()
            cell.userInteractionEnabled = false
                
            if let start = scheduledClass.breakOut?.startTime {
                if let end = scheduledClass.breakOut?.endTime {
                    let startTime = NSDateFormatter.localizedStringFromDate(start, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                     let endTime = NSDateFormatter.localizedStringFromDate(end, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    cell.classLocationAndTime.text = String(format: "%@ - %@", startTime, endTime)
                }
            }
            if let className = scheduledClass.presentation?.title {
                    cell.className.text = className
            }
            return cell
            }
        }
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.classesInSchedule.isEmpty {
            return 0
        } else {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 4
        }
        return 1
        }
    }
       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func updateArrayForDataSource(alreadyScheduledClasses:[ClassScheduled]) {
        self.classesInSchedule = alreadyScheduledClasses
    }
}
