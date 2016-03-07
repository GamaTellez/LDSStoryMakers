//
//  DetailBreakoutDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutDataSource: NSObject, UITableViewDataSource,PresentationCellButtonDelegate {
    
    var classes:[ClassToSchedule] = []
    let classesInSchedule = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled]
    let presentationCellID = "detailPresentation"
    let kclassSelectedNotification = "kClassSelectedNotification"
    func updateClassesArray(from classesArray:[ClassToSchedule]) {
        self.classes  = classesArray
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell =  tableView.dequeueReusableCellWithIdentifier(presentationCellID) as! PresentationCell
        cell.selectionStyle = .None
        cell.delegate = self
        cell.addRemoveButton.section = indexPath.section
        let classAttend = self.classes[indexPath.section]
        let isInSchedule = self.isClassScheduled(classAttend, from: self.classesInSchedule!)
        if isInSchedule == true {
            cell.addRemoveButton.selected = true
        }
        if let title = classAttend.presentation?.title {
            cell.titleLabel.text = title
        }
        if let spakerName = classAttend.speaker?.speakerName {
            if let location = classAttend.scheduleItem?.location {
                cell.speakerAndLocationLabel.text = String(format: "%@ at %@",spakerName, location)
            } else {
                cell.speakerAndLocationLabel.text = spakerName
            }
        }
        if let shortDescription = classAttend.presentation?.presentationDescription {
            cell.descriptionLabel.text = shortDescription
        }
    return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.classes.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //cell delegate
    func indexOfClassSelectedWithButton(section: Int, and button: AddRemoveClass) {
        let classSelected = self.classes[section]
        switch button.selected {
        case true:
            button.selected = false
            if let classesInSchedule = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled] {
                for classItem in classesInSchedule {
                   if classSelected.presentation?.title == classItem.presentation?.valueForKey("title") as? String {
                        ManagedObjectsController.sharedInstance.deleteScheduledClass(classItem)
                    }
                }
            }
            break
        default:
            ManagedObjectsController.sharedInstance.createScheduledClass(from: classSelected)
            button.selected = true
        }
    }
 
    func isClassScheduled(classForCell:ClassToSchedule, from classesInSchedule:[ClassScheduled]) -> Bool {
        for possibleClass in classesInSchedule {
            if  classForCell.presentation?.valueForKey("title") as? String == possibleClass.presentation?.valueForKey("title") as? String {
                return true
            }
        }
        return false
    }
    
}
