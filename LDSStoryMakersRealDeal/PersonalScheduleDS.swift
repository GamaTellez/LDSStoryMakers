//
//  PersonalScheduleDS.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleDS: NSObject, UITableViewDataSource {
  //  var classesScheduled:[ClassScheduled] = []
    var breakOutsForDay: [Breakout] = []
    let addClassCell = "addClassCell"
    let scheduledClassCell = "scheduledClassCell"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
    lazy var scheduleItems = ManagedObjectsController.sharedInstance.getAllSchedulesFRomCoreData()
  
    func updateDataSource(breakouts:[Breakout]) {
    // self.classesScheduled = withClasses
    self.breakOutsForDay = breakouts
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return self.breakOutsForDay.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let currentBreakout =  self.breakOutsForDay[indexPath.section]
        if let currentBreakoutID = currentBreakout.valueForKey("id") as? Int {
            if currentBreakoutID < 13 {
                if let classesInBreakout = currentBreakout.classesScheduled?.allObjects as? [ClassScheduled] {
                    if classesInBreakout.count == 0 {
                        let cell = tableView.dequeueReusableCellWithIdentifier("addClassCell")
                        cell?.textLabel?.text = "Browse Classes for breakout"
                        cell?.textLabel?.textAlignment = .Center
                        cell?.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
                        return cell!
                    } else {
                    let classInBreakout = classesInBreakout[indexPath.row]
                    if let cell = tableView.dequeueReusableCellWithIdentifier("scheduledClassCell") as? PersonalScheduleCell {
                        cell.backgroundColor = UIColor.whiteColor()
                        var title = ""
                        var speaker = ""
                        var location = ""
                        if let classTitle = classInBreakout.presentation?.valueForKey("title") as? String {
                            title = classTitle
                        }
                        if let classSpeaker = classInBreakout.presentation?.valueForKey("speakerName") as? String {
                            speaker = classSpeaker
                        }
                        if let classLocation = classInBreakout.scheduleItem?.valueForKey("location") as? String {
                            location = classLocation
                        }
                        cell.titleLabel.text = title
                        cell.speakerLabel.text = speaker
                        cell.locationLabel.text = location
                        return cell
                        }
                    }
                }
            }
        }
            let cell = tableView.dequeueReusableCellWithIdentifier("addClassCell")
            cell?.textLabel?.text = "Browse Classes for breakout"
            cell?.textLabel?.textAlignment = .Center
            return cell!
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let currentBreakoutForSection = self.breakOutsForDay[section]
        if let id = currentBreakoutForSection.valueForKey("id") as? Int {
            if id > 12 {
                return 0
            } else {
                if let classesInBreakout = currentBreakoutForSection.classesScheduled?.allObjects as? [ClassScheduled] {
                    if classesInBreakout.count == 0 {
                        return classesInBreakout.count + 1
                    } else {
                        return classesInBreakout.count
                    }
                }
            }
        }
        return (currentBreakoutForSection.classesScheduled?.count)!
    }
    
    func findLocationForBreakout(from idTimeBreakout:Int) -> String {
       var location = "no location available"
        if let allSchedules = self.scheduleItems as? [ScheduleItem] {
            for itemSchedule  in allSchedules {
                if let itemScheduleTimeId = itemSchedule.valueForKey("timeId") as? Int {
                    if itemScheduleTimeId == idTimeBreakout {
                        if let itemLocation = itemSchedule.valueForKey("location") as? String {
                            location = itemLocation
                        }
                    }
                }
            }
        }
        return location
    }
}
