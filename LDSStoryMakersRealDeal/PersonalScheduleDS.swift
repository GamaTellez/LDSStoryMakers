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
    
    func updateDataSource(withClasses:[ClassScheduled]) {
        self.classesScheduled = withClasses
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID) as! PersonalScheduleCell
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        let classForCell = self.classesScheduled[indexPath.row]
        print(classForCell.presentation?.title)
        print(classForCell.presentation?.speakerName)
        print(classForCell.breakOut?.startTime)
        print(classForCell.breakOut?.endTime)
        print(classForCell.scheduleItem?.presentationTitle)
        if let startTime = classForCell.breakOut?.startTime {
            let startString = NSDateFormatter.localizedStringFromDate(startTime, dateStyle: .NoStyle, timeStyle: .ShortStyle)
            if let endTime = classForCell.breakOut?.endTime {
                let endTimeString = NSDateFormatter.localizedStringFromDate(endTime, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                if let location = classForCell.scheduleItem?.location {
                    cell.timeAndLocationLabel.text = String(format: "%@ - %@, %@", startString, endTimeString, location)
                }
            }
        }
        
        if let className = classForCell.presentation?.title {
            if let classSpeaker = classForCell.presentation?.speakerName {
                cell.classAndSpeakerLabel.text = String(format:"%@, by %@", className, classSpeaker)
            }
        }

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classesScheduled.count
    }
}
