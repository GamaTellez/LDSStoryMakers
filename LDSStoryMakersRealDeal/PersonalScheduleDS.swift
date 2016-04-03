//
//  PersonalScheduleDS.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleDS: NSObject, UITableViewDataSource {
    var classesScheduled:[ClassScheduled] = []
    var breakOutsForDay: [Breakout] = []
    let addClassCell = "addClassCell"
    let scheduledClassCell = "scheduledClassCell"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
    lazy var scheduleItems = ManagedObjectsController.sharedInstance.getAllSchedulesFRomCoreData()
  
    func updateDataSource(withClasses:[ClassScheduled], breakouts:[Breakout]) {
        self.classesScheduled = withClasses
        self.breakOutsForDay = breakouts
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return self.breakOutsForDay.count
    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var breakOutString = ""
//        let breakoutForSection = self.breakOutsForDay[section]
//        if let startDate = breakoutForSection.valueForKey("startTime") as? NSDate {
//            if let endDate = breakoutForSection.valueForKey("endTime") as? NSDate {
//                if let breakOutName = breakoutForSection.valueForKey("breakoutID") as? String {
//                    if breakOutName.characters.count > 2 {
//                        var location = ""
//                        if let idTimeBreakout = breakoutForSection.valueForKey("id") as? Int {
//                            location = self.findLocationForBreakout(from: idTimeBreakout)
//                        }
//                        breakOutString = String(format: "%@\n%@ - %@\n%@", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), location)
//                    } else {
//                        breakOutString = String(format: "Breakout %@ \n%@ - %@", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
//                    }
//                }
//            }
//        }
//        return breakOutString
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let currentBreakout =  self.breakOutsForDay[indexPath.section]
        if let breakoutID = currentBreakout.valueForKey("id") as? Int {
            for scheduledClass in self.classesScheduled {
                if let scheduleClassBreakoutId = scheduledClass.breakOut?.valueForKey("id") as? Int {
                    if breakoutID == scheduleClassBreakoutId {
                        let cell = tableView.dequeueReusableCellWithIdentifier("scheduledClassCell")
                        return cell!
                    }
                }
            }
            let cell = tableView.dequeueReusableCellWithIdentifier("addClassCell")
            cell?.textLabel?.text = "Browse Classes for breakout"
            return cell!
        }
        return UITableViewCell()
        }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.classesScheduled.count
        let currentBreakout =  self.breakOutsForDay[section]
        if let currentBreakoutID = currentBreakout.valueForKey("id") as? Int {
            if currentBreakoutID > 12 {
                return 0
            }
        }
        return 1
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
