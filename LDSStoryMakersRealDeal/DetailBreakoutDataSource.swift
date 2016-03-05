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
    func indexOfClassSelected(section: Int) {
        let classSelected = self.classes[section]
            ManagedObjectsController.sharedInstance.createScheduledClass(from: classSelected)
        //NSNotificationCenter.defaultCenter().postNotificationName(self.kclassSelectedNotification, object: self, userInfo: ["classSelected":classSelected])
    }

}
