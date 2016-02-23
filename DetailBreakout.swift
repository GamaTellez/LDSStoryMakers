//
//  DetailBreakout.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/22/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakout: UITableViewController {
    var scheduleItems:[ScheduleItem] = []
    let scheduleItemCellID = "scheduleItemCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getInfoAboutItemSchedule(forscheduleItem:[ScheduleItem],from presentations:[Presentation], at index:Int) {
        
        if let allPresentations = ManagedObjectsController.sharedInstance.getAllPresentationsFromCoreData() as? [Presentation] {
            for pres in allPresentations {
            
            }
        }
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(scheduleItemCellID) as! ItemScheduleCell
            cell.titleLabel.text = self.scheduleItems[indexPath.row].presentationTitle
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}
