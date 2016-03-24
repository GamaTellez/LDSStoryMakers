//
//  DetailBreakoutDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutDataSource: NSObject, UITableViewDataSource, PresentationCellButtonDelegate {
    
    var classes:[ClassToSchedule] = []
    let presentationCellID = "detailPresentation"
    let timeConlictNotication = "timeConlictNotication"
    let itemSuccesfullySaved = "itemSuccesfullySaved"
    let itemSuccesFullyDeleted = "itemSuccesFullyDeleted"
    
    func updateClassesArray(from classesArray:[ClassToSchedule]) {
        self.checkIfClassIsAlreadyScheduled(classesArray)
        self.classes  = classesArray
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell =  tableView.dequeueReusableCellWithIdentifier(presentationCellID) as! PresentationCell
        cell.selectionStyle = .None
        cell.delegate = self
        cell.addRemoveButton.section = indexPath.section
        let classAttend = self.classes[indexPath.section]
        if let scheduled = classAttend.inSchedule {
            if scheduled == true {
                cell.addRemoveButton.selected = true
            } else {
                cell.addRemoveButton.selected = false
            }
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
        if let currentlySavedClasses = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled] {
        let classSelected = self.classes[section]
        switch button.selected {
        case true:
                for classItem in currentlySavedClasses {
                    if classSelected.presentation?.title == classItem.presentation?.valueForKey("title") as? String {
                       ManagedObjectsController.sharedInstance.deleteScheduledClass(classItem, completion: { (succedeed) in
                        if (succedeed == true) {
                            button.selected = false
                            classSelected.inSchedule = false
                            NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeleted, object: nil)
                        } else {
                            print("failed to delete Item")
                        }
                       })
                       
                    }
                }
            break
        default:
            if let classSelectedBreakout = classSelected.breakout?.valueForKey("breakoutID") as? String {
                let canSave = self.isBreakoutAvailable(classSelectedBreakout, allClasses: currentlySavedClasses)
                if canSave {
                    ManagedObjectsController.sharedInstance.createScheduledClass(from: classSelected, completion: { (succeeded) in
                        if (succeeded == true) {
                            button.selected = true
                            classSelected.inSchedule = true
                            NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesfullySaved, object: nil)
                        } else {
                        }
                    })
                } else {
                    NSNotificationCenter.defaultCenter().postNotificationName(timeConlictNotication, object: nil)
                }
            }
          break
        }
      }
    }
    
    func isBreakoutAvailable(newClassBreakout:String, allClasses:[ClassScheduled]) -> Bool {
        for possibleClass in allClasses {
            if possibleClass.breakOut?.valueForKey("id") as? String == newClassBreakout {
                return false
            }
        }
    return true
    }
    
    func checkIfClassIsAlreadyScheduled(classesToSchedule:[ClassToSchedule]) {
        let personalSchedule = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled]
        for clsToSched in self.classes {
            let isAlreadyInSchedule = self.isClassScheduled(clsToSched, from: personalSchedule!)
            if isAlreadyInSchedule == true {
                clsToSched.inSchedule = true
            } else {
                clsToSched.inSchedule = false
            }
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
