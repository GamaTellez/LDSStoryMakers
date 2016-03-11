//
//  PersonalScheduleDS.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleDS: NSObject, UITableViewDataSource, ClassScheduledDeletedDelegate {
    var classesScheduled:[ClassScheduled] = []
    let cellID = "classCell"
    
    func updateDataSource(withClasses:[ClassScheduled]) {
        self.classesScheduled = withClasses
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! PersonalScheduleCell
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        cell.delegate = self
        cell.removeClassButton.section = indexPath.row
        let classForCell = self.classesScheduled[indexPath.row]
        var startTimeString = ""
        var endTimeString = ""
        var location = ""
        var className = ""
        var speakerName = ""
        if let startTimeDate = classForCell.breakOut?.valueForKey("startTime") as? NSDate {
             startTimeString = NSDateFormatter.localizedStringFromDate(startTimeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        }
        if let endTimeDate = classForCell.breakOut?.valueForKey("endTime") as? NSDate {
            endTimeString = NSDateFormatter.localizedStringFromDate(endTimeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        }
        if let loc = classForCell.scheduleItem?.valueForKey("location") as? String {
        location = loc
        }
        
        if let presentName = classForCell.presentation?.valueForKey("title") as? String {
            className = presentName
        } else {
            if let event = classForCell.breakOut?.valueForKey("breakoutID") as? String {
                className = event
            }
        }
        if let teacherName = classForCell.presentation?.valueForKey("speakerName") as? String {
                speakerName = teacherName
        }
        cell.timeAndLocationLabel.text = String(format: "%@ - %@ at %@", startTimeString, endTimeString, location)
        cell.classAndSpeakerLabel.text = String(format: "%@, %@", className, speakerName)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classesScheduled.count
    }
    func indexOfClassDeletedInTableView(row: Int) {
         let classToDelete = self.classesScheduled[row]
        ManagedObjectsController.sharedInstance.deleteScheduledClass(classToDelete, fromView: "personalSchedule")
    }
}
