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
    let cellID = "classCell"
    let mandatoryClassCell = "mandatoryClassCell"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
    
    func updateDataSource(withClasses:[ClassScheduled]) {
        self.classesScheduled = withClasses
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let classForCell = self.classesScheduled[indexPath.row]
        if let mandatory = classForCell.valueForKey("isMandatory") as? Bool {
            switch (mandatory) {
            case true:
                let cell = tableView.dequeueReusableCellWithIdentifier(mandatoryClassCell) as? MandatoryClassCell
                cell?.userInteractionEnabled = false
                cell?.backgroundColor = UIColor.clearColor()
                var startTimeString = ""
                var endTimeString = ""
                var location = ""
                var className = ""
                if let startTimeDate = classForCell.breakOut?.valueForKey("startTime") as? NSDate {
                    startTimeString = NSDateFormatter.localizedStringFromDate(startTimeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                }
                if let endTimeDate = classForCell.breakOut?.valueForKey("endTime") as? NSDate {
                    endTimeString = NSDateFormatter.localizedStringFromDate(endTimeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                }
                if let event = classForCell.breakOut?.valueForKey("breakoutID") as? String {
                    className = event
                }
                if let loc = classForCell.scheduleItem?.valueForKey("location") as? String {
                    location = loc
                }
                cell?.labelInfo.text = String(format:"%@ \n %@ - %@ \n %@",className, startTimeString, endTimeString, location)
                
                return cell!
                
            default:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! PersonalScheduleCell
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            cell.tableView = tableView
            //cell.removeClassButton.tag = indexPath.row
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
            }
            if let teacherName = classForCell.presentation?.valueForKey("speakerName") as? String {
                speakerName = teacherName
            }
            cell.timeAndLocationLabel.text = String(format: "%@ - %@ at %@", startTimeString, endTimeString, location)
            cell.classAndSpeakerLabel.text = String(format: "%@, %@", className, speakerName)
            return cell
                }
            }
        return UITableViewCell()
        }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classesScheduled.count
    }
//    func indexOfClassDeletedInTableView(row:Int, table:UITableView) {
//         let classToDelete = self.classesScheduled[row]
//        ManagedObjectsController.sharedInstance.deleteScheduledClass(classToDelete) { (succedeed) in
//            if (succedeed == true) {
//                NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeletedFromPersonalView, object: nil)
//                    let path = NSIndexPath(forRow: row, inSection:0);
//                    print(path)
//                    self.classesScheduled.removeAtIndex(row)
//                    self.updateDataSource(self.classesScheduled)
//                    table.deleteRowsAtIndexPaths([path], withRowAnimation: .Fade)
//                    } else {
//                print("failed to delete class from personal schedule")
//            }
//        }
//    }
}
