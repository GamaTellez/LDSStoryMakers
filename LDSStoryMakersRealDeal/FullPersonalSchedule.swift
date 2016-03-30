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
   
    
    let itemSuccesfullySaved = "itemSuccesfullySaved"
    let itemSuccesFullyDeleted = "itemSuccesFullyDeleted"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
    var friday:[ClassScheduled] = []
    var saturday:[ClassScheduled] = []
    let dataSource = PersonalScheduleDS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllClassesScheduled()
        self.setUpViews()
        self.setUpTableViewAndSegmentedController()
        self.registerForNotifications()
       
    }

    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesfullySaved, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesFullyDeleted, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataFromPersonalVC), name: self.itemSuccesFullyDeletedFromPersonalView, object: nil)
    }

    func setUpViews() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
            let statusBarView = UIView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 22))
            statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
            self.navigationController?.navigationBar.addSubview(statusBarView)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.segmentedController.tintColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
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
//        print(self.friday.count)
//        print(self.saturday.count)
    }

    func setUpTableViewAndSegmentedController() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.segmentedController.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.dataSource
        self.segmentedController.selectedSegmentIndex = 0
        self.dataSource.updateDataSource(self.friday)
        self.tableView.reloadData()
    }
    
    func updateTableViewAndReloadDataUponNotification(){
        self.friday.removeAll()
        self.saturday.removeAll()
        self.getAllClassesScheduled()
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.friday)
        } else {
            self.dataSource.updateDataSource(self.saturday)
        }
        self.tableView.reloadData()
      }
    
    func updateTableViewAndReloadDataFromPersonalVC(){
        self.friday.removeAll()
        self.saturday.removeAll()
        self.getAllClassesScheduled()
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.friday)
        } else {
            self.dataSource.updateDataSource(self.saturday)
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            switch (segueId) {
            default:
                let detailView = segue.destinationViewController as! ClassDetailView
                if segmentedController.selectedSegmentIndex == 0 {
                    if let rowSelected = self.tableView.indexPathForSelectedRow?.row {
                      let classScheduledSelected = self.friday[rowSelected]
                        detailView.classSelected = self.classToScheduleFromClassScheduled(classScheduledSelected)
                    }
                }
            break
            }
        }
    }
    
    func classToScheduleFromClassScheduled(scheduledClass: ClassScheduled) -> ClassToSchedule {
        let temporarelyClass = ClassToSchedule()
        if let breakoutForClass = scheduledClass.valueForKey("breakOut") as? Breakout {
            temporarelyClass.breakout = breakoutForClass
        }
        if let speakerForClass = scheduledClass.valueForKey("speaker") as? Speaker {
            temporarelyClass.speaker = speakerForClass
        }
        if let presentationForClass = scheduledClass.valueForKey("presentation") as? Presentation {
            temporarelyClass.presentation = presentationForClass
        }
        if let scheduleItemForClass = scheduledClass.valueForKey("scheduleItem") as? ScheduleItem {
            temporarelyClass.scheduleItem = scheduleItemForClass
        }
        return temporarelyClass
    }
    
}
