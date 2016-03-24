//
//  FullScheduleViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/19/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class FullScheduleViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
  
    let finishedRedownLoadingData = "finishedRedownLoadingData"
    var fridayBreakouts:[Breakout] = []
    var saturdayBreakouts:[Breakout] = []
    let tableViewDataSoruce:BreakoutsDataSource = BreakoutsDataSource()
    
    override func viewDidLoad() {
        self.getbreakoutsByDay()
        self.setViewControllerBackgroundImage()
        self.setUpTableView()
        self.segmentedControllerAppearance()
        self.setUpStatusBarBackground()
        self.unregiterFromNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.unregiterFromNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.registerForNotifications()
    }
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullScheduleViewController.reloadTableViewUponNotification), name: self.finishedRedownLoadingData, object: nil)
    }
    func unregiterFromNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: self.finishedRedownLoadingData, object: nil)
    }
    
    func reloadTableViewUponNotification() {
        self.fridayBreakouts.removeAll()
        self.saturdayBreakouts.removeAll()
        self.getbreakoutsByDay()
        self.segmentedController.selectedSegmentIndex = 0
        self.loadTableViewWithBreakouts(self.fridayBreakouts)
    }
    
    func setUpStatusBarBackground() {
        let statusBarView = UIView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 22))
        statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
        self.navigationController?.navigationBar.addSubview(statusBarView)
    }
    
    func segmentedControllerAppearance() {
        self.segmentedController.backgroundColor = UIColor.clearColor()
        self.segmentedController.selectedSegmentIndex = 0
        self.segmentedController.tintColor = UIColor(red: 0.094, green: 0.498, blue: 0.494, alpha: 1.00)
    }
    func setViewControllerBackgroundImage() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func setUpTableView(){
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self.tableViewDataSoruce
        self.loadTableViewWithBreakouts(self.fridayBreakouts)
    }
    
    func loadTableViewWithBreakouts(breakoutsByDay:[Breakout]) {
        self.tableViewDataSoruce.updateBreakoutsArray(with: breakoutsByDay)
        self.tableView.reloadData()
    }
    
    
    func getbreakoutsByDay() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let friday = formatter.dateFromString("5/6/2016")
            if let allBreakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
                let order = NSCalendar.currentCalendar()
                for timeBreakout in allBreakouts {
                    if timeBreakout.breakoutID?.characters.count > 2 {
                    } else {
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
            }
    
    func getAllScheduleItemsForSelectedBreakout(selectedBreakout:Breakout) -> [ScheduleItem] {
        var allScheduleItems:[ScheduleItem] = []
        let breakoutId = selectedBreakout.breakoutID
        if let itemsSchedule = ManagedObjectsController.sharedInstance.getAllSchedulesFRomCoreData() as? [ScheduleItem] {
            for item in itemsSchedule {
                if item.breakout?.stringValue == breakoutId {
                    allScheduleItems.append(item)
                }
            }
        }
        return allScheduleItems
    }
    
    func createClassObjectsReadyToSave(from itemsSchedule:[ScheduleItem]) -> [ClassToSchedule] {
        var allClasses:[ClassToSchedule] = []
        let allClassesStored = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled]
        for item in itemsSchedule {
            let classObject = ClassToSchedule()
            classObject.scheduleItem = item
            classObject.inSchedule = false
           
            if let allBreakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
                if let itemBreakoutId = item.breakout {
                    for breakt in allBreakouts {
                        if itemBreakoutId.stringValue == breakt.id {
                            classObject.breakout = breakt
                        }
                    }
                }
            }
            if let allPresentations = ManagedObjectsController.sharedInstance.getAllPresentationsFromCoreData() as? [Presentation] {
                if let presentationId = item.presentationId {
                    for pres in allPresentations {
                        if presentationId.integerValue == pres.id?.integerValue {
                            classObject.presentation = pres
                        }
                    }
                }
            }
            if let allSpeakers = ManagedObjectsController.sharedInstance.getAllSpeakersFromCoreData() as? [Speaker] {
                if let speakerId = classObject.presentation?.speakerId {
                    for speak in allSpeakers {
                        if speakerId.integerValue == speak.speakerId?.integerValue {
                            classObject.speaker = speak
                        }
                    }
                }
            }
            if let allClassesInScheduled = allClassesStored {
                let scheduled = self.isClassScheduled(classObject, from: allClassesInScheduled)
                if scheduled {
                    classObject.inSchedule = true
                }
            }
            allClasses.append(classObject)
        }
        return allClasses
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            switch segueId {
                case "detailBreakout":
                    let daySelected = self.segmentedController.selectedSegmentIndex
                    if daySelected == 0 {
                        let indexpathOfSelectedBreakout = self.tableView.indexPathForSelectedRow
                        if let sectionBreakout = indexpathOfSelectedBreakout?.section {
                            let selectedBreakout = self.fridayBreakouts[sectionBreakout]
                            let breakoutDetailVC = segue.destinationViewController as! DetailBreakoutVC
                            if let startDate = selectedBreakout.startTime {
                                if let endDate = selectedBreakout.endTime {
                                    breakoutDetailVC.stringForLabelBreakoutTime = String(format:"%@ - %@",NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .
                                        ShortStyle),NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
                                    breakoutDetailVC.title = String(format:"Breakout %@",selectedBreakout.breakoutID!)
                                }
                            }
                            let scheduleItemsForSelectedBreakout = self.getAllScheduleItemsForSelectedBreakout(selectedBreakout)
                           let allClasesToSchedule = self.createClassObjectsReadyToSave(from: scheduleItemsForSelectedBreakout)
                            breakoutDetailVC.classesInBreakout = allClasesToSchedule
//                            let personalSchedule = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled]
//                            for clsToSched in allClasesToSchedule {
//                                let isAlreadyInSchedule = self.isClassScheduled(clsToSched, from: personalSchedule!)
//                                if isAlreadyInSchedule == true {
//                                    clsToSched.inSchedule = true
//                                } else {
//                                    clsToSched.inSchedule = false
//                                }
//                            }
//                             breakoutDetailVC.classesInBreakout = allClasesToSchedule
//                        }
                        }
                    }
                    if daySelected == 1 {
                        let indexpathOfSelectedBreakout = self.tableView.indexPathForSelectedRow
                        if let sectionBreakout = indexpathOfSelectedBreakout?.section {
                            let selectedBreakout = self.saturdayBreakouts[sectionBreakout]
                            let breakoutDetailVC = segue.destinationViewController as! DetailBreakoutVC
                            if let startDate = selectedBreakout.startTime {
                                if let endDate = selectedBreakout.endTime {
                                    breakoutDetailVC.stringForLabelBreakoutTime = String(format:"%@ - %@",NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .
                                        ShortStyle),NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
                                    breakoutDetailVC.title = String(format:"Breakout %@",selectedBreakout.breakoutID!)
                                }
                            }
                            let scheduleItemsForSelectedBreakout = self.getAllScheduleItemsForSelectedBreakout(selectedBreakout)
                            let allClasesToSchedule = self.createClassObjectsReadyToSave(from: scheduleItemsForSelectedBreakout)
                            let personalSchedule = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled]
                            for clsToSched in allClasesToSchedule {
                                let isAlreadyInSchedule = self.isClassScheduled(clsToSched, from: personalSchedule!)
                                if isAlreadyInSchedule == true {
                                    clsToSched.inSchedule = true
                                } else {
                                    clsToSched.inSchedule = false
                                }
                            }
                            breakoutDetailVC.classesInBreakout = allClasesToSchedule
                        }
                    }
                break
            default:
                break
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func segementedControllerTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.loadTableViewWithBreakouts(self.fridayBreakouts)
            break
        case 1:
            self.loadTableViewWithBreakouts(self.saturdayBreakouts)
            break
        default:
            break
        }
    }
}
