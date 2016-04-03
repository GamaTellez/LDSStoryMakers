//
//  TableViewDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, SpeakerInfoButtonTappedDelegate {
    var classesInSchedule:[ClassScheduled] = []
    let kNextClassCellID = "nextClassCell"
    let kupcomingClassID = "upcomingClass"
    lazy var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //check it is not empty, it is crashing because of that
        
        switch indexPath.section {
        case 0:
            let scheduledClass = self.classesInSchedule[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(self.kNextClassCellID, forIndexPath: indexPath) as! NextClassCell
            cell.backgroundColor = UIColor.clearColor()
            cell.classDescription.setContentOffset(CGPointZero, animated: true)
            cell.speakerBioButton.tag = indexPath.section
            cell.delegate = self
            cell.selectionStyle = .None
            if scheduledClass.valueForKey("speaker") == nil {
                cell.speakerBioButton.alpha = 0.4
                cell.speakerBioButton.enabled = false
            }
            
            if let start = scheduledClass.breakOut?.valueForKey("startTime") as? NSDate {
                if let end = scheduledClass.breakOut?.valueForKey("endTime") as? NSDate {
                    let startTime = NSDateFormatter.localizedStringFromDate(start, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    let endTime = NSDateFormatter.localizedStringFromDate(end, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    cell.timeLabel.text = String(format: "%@ - %@", startTime, endTime)
                }
            }
            if let className = scheduledClass.presentation?.valueForKey("title") as? String {
                cell.speakerAndClassNameLabel.text = className
                if let speakerName = scheduledClass.presentation?.valueForKey("speakerName") as? String {
                   cell.speakerAndClassNameLabel.text = String(format: "%@ , %@", className, speakerName)
                }
            } else {
                if let breakoutName = scheduledClass.breakOut?.valueForKey("breakoutID") as? String {
                    cell.speakerAndClassNameLabel.text = breakoutName
                }
            }
            if let classDescription = scheduledClass.presentation?.valueForKey("presentationDescription") as? String {
                cell.classDescription.text = classDescription
                cell.classDescription.textAlignment = NSTextAlignment.Justified
            } else {
               cell.classDescription.text = "No description available for this event"
                cell.classDescription.textAlignment = NSTextAlignment.Center
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
        let currentTime = NSDate()
        let calendar = NSCalendar.currentCalendar()
        for classScheduled in alreadyScheduledClasses {
            if let classStartTime = classScheduled.valueForKey("startDate") as? NSDate {
                    let timeComparison =  calendar.compareDate(currentTime, toDate: classStartTime, toUnitGranularity: NSCalendarUnit.Hour)
                if timeComparison == NSComparisonResult.OrderedAscending {
                    self.classesInSchedule.append(classScheduled)
                } else {
                    print("time is ")
                }
            }
        }
    }
    
    func indexOfClassForSpeakerSelected(section: Int) {
        let speakerBioVC = self.storyBoard.instantiateViewControllerWithIdentifier("speakerBioVC") as? SpeakerBioView
        let classSelected = self.classesInSchedule[section]
        if let speakerSelected = classSelected.valueForKey("speaker") as? Speaker {
            speakerBioVC?.speakerSelected = speakerSelected
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(speakerBioVC!, animated: true, completion: nil)
        }
    }
    
//    func findCurrentBreakout() -> Breakout {
//        let currentTime = NSDate()
//        let currentCalendar = NSCalendar.currentCalendar()
//        var currentBreakout:Breakout?
//        if let allBreakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
//            for breakoutTime in allBreakouts {
//                if let startTimeBreakout = (breakoutTime.valueForKey("startTime") as? NSDate)?.dateByAddingTimeInterval(-(60 * 30)) {
//                let comparisonResultStart = currentCalendar.compareDate(currentTime, toDate: startTimeBreakout, toUnitGranularity: .Hour)
//                    if comparisonResultStart == NSComparisonResult.OrderedDescending {
//                        if let endTimeBreakout = (breakoutTime.valueForKey("endTime") as? NSDate)?.dateByAddingTimeInterval(-(60 * 30)) {
//                            let comparisonResultEnd = currentCalendar.compareDate(currentTime, toDate: endTimeBreakout, toUnitGranularity: .Hour)
//                            if comparisonResultEnd == NSComparisonResult.OrderedDescending {
//                                currentBreakout = breakoutTime
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        return currentBreakout!
//    }
}
