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
    let cellID = "classCell"
    let mandatoryClassCell = "mandatoryClassCell"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
  
    func updateDataSource(withClasses:[ClassScheduled], breakouts:[Breakout]) {
        self.classesScheduled = withClasses
        self.breakOutsForDay = breakouts
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
           return self.breakOutsForDay.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var breakOutString = ""
        let breakoutForSection = self.breakOutsForDay[section]
        if let startDate = breakoutForSection.valueForKey("startTime") as? NSDate {
            if let endDate = breakoutForSection.valueForKey("endTime") as? NSDate {
                if let breakOutName = breakoutForSection.valueForKey("breakoutID") as? String {
                    if breakOutName.characters.count > 2 {
                    breakOutString = String(format: "%@ \n%@ - %@ \nlocation", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
                    } else {
                        breakOutString = String(format: "Breakout %@ \n%@ - %@", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
                    }
                }
            }
        }
        return breakOutString
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let classForCell = self.classesScheduled[indexPath.row]
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
}
