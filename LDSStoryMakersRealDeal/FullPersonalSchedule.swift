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
    var fridayBreakouts:[Breakout] = []
    var saturdayBreakouts:[Breakout] = []
    let dataSource = PersonalScheduleDS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllClassesScheduled()
        self.getbreakoutsByDay()
        self.setUpViews()
        self.setUpTableViewAndSegmentedController()
        self.registerForNotifications()
       
    }

    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesfullySaved, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesFullyDeleted, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataFromPersonalVC), name: self.itemSuccesFullyDeletedFromPersonalView, object: nil)
    }

    func setUpViews() {
       // self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
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
                    if let start = itemClass.breakOut?.valueForKey("startTime") as? NSDate {
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
        self.dataSource.updateDataSource(self.friday, breakouts: self.fridayBreakouts)
        self.tableView.reloadData()
    }
    
    func updateTableViewAndReloadDataUponNotification(){
        self.friday.removeAll()
        self.saturday.removeAll()
        self.getAllClassesScheduled()
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.friday, breakouts: self.fridayBreakouts)
        } else {
            self.dataSource.updateDataSource(self.saturday, breakouts: self.saturdayBreakouts)
        }
        self.tableView.reloadData()
      }
    
    func updateTableViewAndReloadDataFromPersonalVC(){
        self.friday.removeAll()
        self.saturday.removeAll()
        self.getAllClassesScheduled()
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.friday, breakouts: self.fridayBreakouts)
        } else {
            self.dataSource.updateDataSource(self.saturday, breakouts: self.saturdayBreakouts)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func segmentedControllerTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.dataSource.updateDataSource(self.friday, breakouts: self.fridayBreakouts)
            self.tableView.reloadData()
            break
        default:
            self.dataSource.updateDataSource(self.saturday, breakouts: self.saturdayBreakouts)
            self.tableView.reloadData()
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
       let separatorView = UIView(frame: CGRect(x: 8, y: headerView.frame.size.height - 1, width: self.tableView.frame.size.width , height: 1))
        separatorView.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        headerView.addSubview(separatorView)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
        let deleteClassRowAction = UITableViewRowAction(style: .Default, title: "Delete") { (action:UITableViewRowAction, indexPath:NSIndexPath) in
            if self.segmentedController.selectedSegmentIndex == 0 {
                let classSelected = self.friday[indexPath.row]
                print(classSelected.presentation?.valueForKey("title"))
                ManagedObjectsController.sharedInstance.deleteScheduledClass(classSelected, completion: { (succedeed) in
                    if (succedeed) {
                        self.friday.removeAtIndex(indexPath.row)
                        self.dataSource.updateDataSource(self.friday, breakouts: self.fridayBreakouts)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeletedFromPersonalView, object: nil)
                    }
                })
            } else {
                let classSelected = self.saturday[indexPath.row]
                ManagedObjectsController.sharedInstance.deleteScheduledClass(classSelected, completion: { (succedeed) in
                    if (succedeed) {
                        self.saturday.removeAtIndex(indexPath.row)
                        self.dataSource.updateDataSource(self.saturday, breakouts: self.saturdayBreakouts)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeletedFromPersonalView, object: nil)
                    }
                })
            }
        }
            return [deleteClassRowAction];
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
    
    func getbreakoutsByDay() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let friday = formatter.dateFromString("5/6/2016")
        if let allBreakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
            let order = NSCalendar.currentCalendar()
            for timeBreakout in allBreakouts {
                    if let dayDate = timeBreakout.valueForKey("startTime") as? NSDate {
                        let comparison = order.compareDate(friday!, toDate: dayDate, toUnitGranularity: .Day)
                        if comparison == NSComparisonResult.OrderedSame {
                            self.fridayBreakouts.append(timeBreakout)
                        } else {
                            self.saturdayBreakouts.append(timeBreakout)
                        }
                    }
                
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
