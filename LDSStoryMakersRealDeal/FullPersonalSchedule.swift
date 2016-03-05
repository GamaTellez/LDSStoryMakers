//
//  FullPersonalSchedule.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class FullPersonalSchedule: UIViewController, UITableViewDelegate {
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topFillerView: UILabel!
    
    var friday:[ClassScheduled] = []
    var saturday:[ClassScheduled] = []
    let dataSource = PersonalScheduleDS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllClassesScheduled()
        self.setUpViews()
        self.setUpTableViewAndSegmentedController()
       
    }

    func setUpViews() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.titleLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.topFillerView.backgroundColor = UIColor(red: 0.445, green: 0.445, blue: 0.455, alpha: 1.00)
    }
    func getAllClassesScheduled() {
        if let allClasses = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled] {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let friday = formatter.dateFromString("5/6/2016")
            let calendarSorter = NSCalendar.currentCalendar()
            for itemClass in allClasses {
                if let start = itemClass.breakOut?.startTime {
                    let comparison = calendarSorter.compareDate(friday!, toDate: start, toUnitGranularity: .Day)
                    if comparison == NSComparisonResult.OrderedSame {
                        self.friday.append(itemClass)
                    } else {
                        self.saturday.append(itemClass)
                    }
                }
            }
        }
    }

    func setUpTableViewAndSegmentedController() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.segmentedController.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.dataSource
        self.segmentedController.selectedSegmentIndex = 0
        self.dataSource.updateDataSource(self.friday)
        self.tableView.reloadData()
    }
    
    @IBAction func segmentedControllerTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.dataSource.updateDataSource(self.friday)
            self.tableView.reloadData()
            break
        default:
            self.dataSource.updateDataSource(self.saturday)
            self.tableView.reloadData()
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 119
    }
}
