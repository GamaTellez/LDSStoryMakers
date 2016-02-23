//
//  DetailBreakoutDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutDataSource: NSObject, UITableViewDataSource {
    var presentations:[Presentation] = []
    let presentationCellID = "detailPresentation"
    
    func updatePresentationsArray(from presentationsArray:[Presentation]) {
        self.presentations = presentationsArray
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell =  tableView.dequeueReusableCellWithIdentifier(presentationCellID) as! PresentationCell
        let pres = self.presentations[indexPath.row]
        cell.titleLabel.text = pres.title
        cell.speakerNameLabel.text = pres.speakerName
        return PresentationCell()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presentations.count
    }
    
}
