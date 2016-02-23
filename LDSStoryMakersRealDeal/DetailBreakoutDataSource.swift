//
//  DetailBreakoutDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutDataSource: NSObject, UITableViewDataSource {
    var classes:[Class] = []
    let presentationCellID = "detailPresentation"
    
    func updateClassesArray(from classesArray:[Class]) {
        self.classes  = classesArray
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell =  tableView.dequeueReusableCellWithIdentifier(presentationCellID) as! PresentationCell
        let classAttend = self.classes[indexPath.row]
        cell.titleLabel.text = classAttend.presentation?.title
        cell.speakerNameLabel.text = classAttend.presentation?.speakerName
        cell.locationLabel.text = classAttend.scheduleItem?.location
        
    return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classes.count
    }
    

}
