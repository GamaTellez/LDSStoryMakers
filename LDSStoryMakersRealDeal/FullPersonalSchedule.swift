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
    @IBOutlet var helpButton: UIBarButtonItem!
   
    
    let itemSuccesfullySaved = "itemSuccesfullySaved"
    let itemSuccesFullyDeleted = "itemSuccesFullyDeleted"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"
    var fridayBreakouts:[Breakout] = []
    var saturdayBreakouts:[Breakout] = []
    let dataSource = PersonalScheduleDS()
    lazy var helpView = UIVisualEffectView()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AppleSDGothicNeo-Bold", size: 20)!]
        super.viewDidLoad()
        self.getbreakoutsByDay()
        self.setUpViews()
        self.setUpTableViewAndSegmentedController()
        self.registerForNotifications()
    }
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesfullySaved, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FullPersonalSchedule.updateTableViewAndReloadDataUponNotification), name: itemSuccesFullyDeleted, object: nil)
    }

    func setUpViews() {
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
        let statusBarView = UIView(frame: CGRect(x: 0, y: -20, width: self.view.frame.width, height: 22))
        statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
        self.navigationController?.navigationBar.addSubview(statusBarView)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.segmentedController.tintColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
        self.helpButton.image = UIImage(named: "help")
        self.helpButton.tintColor = UIColor.whiteColor()
    }
    
    func setUpTableViewAndSegmentedController() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.segmentedController.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.dataSource
        self.segmentedController.selectedSegmentIndex = 0
        self.dataSource.updateDataSource(self.fridayBreakouts)
        self.tableView.reloadData()
    }
    
    func updateTableViewAndReloadDataUponNotification(){
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.fridayBreakouts)
        } else {
            self.dataSource.updateDataSource(self.saturdayBreakouts)
        }
        self.tableView.reloadData()
      }
    
    func updateTableViewAndReloadDataFromPersonalVC(){
        if self.segmentedController.selectedSegmentIndex == 0 {
            self.dataSource.updateDataSource(self.fridayBreakouts)
        } else {
            self.dataSource.updateDataSource(self.saturdayBreakouts)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func segmentedControllerTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.dataSource.updateDataSource(self.fridayBreakouts)
            self.tableView.reloadData()
            break
        default:
            self.dataSource.updateDataSource(self.saturdayBreakouts)
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
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        if self.segmentedController.selectedSegmentIndex == 0 {
                        let selectedBreakout = self.fridayBreakouts[indexPath.section]
                        if let classesInBreakout = selectedBreakout.classesScheduled?.allObjects as? [ClassScheduled] {
                            if classesInBreakout.isEmpty  {
                                    return UITableViewCellEditingStyle.None
                            }
                        }
                    } else {
                        if self.segmentedController.selectedSegmentIndex == 1 {
                            let selectedBreakout = self.saturdayBreakouts[indexPath.section]
                            if let classesInBreakout = selectedBreakout.classesScheduled?.allObjects as? [ClassScheduled] {
                                if classesInBreakout.isEmpty {
                                        return UITableViewCellEditingStyle.None
                                    }
                                }
                        }
                    }
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var rowActions:[UITableViewRowAction] = []
        if self.segmentedController.selectedSegmentIndex == 0 {
           rowActions.append(self.createDeleteClassRowAction(0, tableView: tableView))
        } else {
            rowActions.append(self.createDeleteClassRowAction(1, tableView: tableView))
        }
        return rowActions;
    }
    
    func createDeleteClassRowAction(segmentedSelected:Int, tableView:UITableView) -> UITableViewRowAction {
        let deleteClassRowAction = UITableViewRowAction(style: .Default, title: "Delete") { (action:UITableViewRowAction, indexPath:NSIndexPath) in
            switch (segmentedSelected) {
                case 0:
                    let breakoutInsection = self.fridayBreakouts[indexPath.section]
                    if let classesInBreakout = breakoutInsection.valueForKey("classesScheduled") {
                        if var breakoutClasses = classesInBreakout.allObjects as? [ClassScheduled] {
                            if !breakoutClasses.isEmpty {
                                let classSelected = breakoutClasses[indexPath.row]
                                ManagedObjectsController.sharedInstance.deleteScheduledClass(classSelected, completion: { (succedeed) in
                                    if (succedeed) {
                                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                                        NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeletedFromPersonalView, object: nil)
                                    }
                                })
                            }
                        }
                    }
                break
            default:
                let breakoutInsection = self.saturdayBreakouts[indexPath.section]
                if let classesInBreakout = breakoutInsection.valueForKey("classesScheduled") {
                    if var breakoutClasses = classesInBreakout.allObjects as? [ClassScheduled] {
                        if !breakoutClasses.isEmpty {
                            let classSelected = breakoutClasses[indexPath.row]
                            ManagedObjectsController.sharedInstance.deleteScheduledClass(classSelected, completion: { (succedeed) in
                                if (succedeed) {
                                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                                    NSNotificationCenter.defaultCenter().postNotificationName(self.itemSuccesFullyDeletedFromPersonalView, object: nil)
                                }
                            })
                        }
                    }
                }

                break
            }
        }
        return deleteClassRowAction
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let separatorView = UIView(frame: CGRect(x: 40, y: headerView.frame.size.height - 1, width: self.tableView.frame.size.width - 80 , height: 1))
        separatorView.backgroundColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00)
        headerView.addSubview(separatorView)
        
        if self.segmentedController.selectedSegmentIndex == 0 {
            let breakoutInsection = self.fridayBreakouts[section]
            if let breakoutID = breakoutInsection.valueForKey("id") as? Int {
                if breakoutID >= 12 {
                    return headerView
                }
            }
        } else {
            let breakoutInsection =  self.saturdayBreakouts[section]
            if let breakoutInsectionID = breakoutInsection.valueForKey("id") as? Int {
                if breakoutInsectionID >= 12 {
                    return headerView
                }
            }
        }
        separatorView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let labelHeader = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 90))
        labelHeader.numberOfLines = 0
        labelHeader.textAlignment = .Center
        labelHeader.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        if self.segmentedController.selectedSegmentIndex == 0 {
            labelHeader.text = self.textForHeaderBreakoutLabel(self.fridayBreakouts, section: section, label: labelHeader)
        } else {
            labelHeader.text = self.textForHeaderBreakoutLabel(self.saturdayBreakouts, section: section, label: labelHeader)
        }
        return labelHeader
    }
    
    func textForHeaderBreakoutLabel(breakoutsOfDay:[Breakout], section:Int, label:UILabel) -> String {
        var breakOutString = ""
        let breakoutForSection = breakoutsOfDay[section]
        if let startDate = breakoutForSection.valueForKey("startTime") as? NSDate {
            if let endDate = breakoutForSection.valueForKey("endTime") as? NSDate {
                if let breakOutName = breakoutForSection.valueForKey("breakoutID") as? String {
                    if breakOutName.characters.count > 2 {
                        var location = ""
                        if let idTimeBreakout = breakoutForSection.valueForKey("id") as? Int {
                            location = self.dataSource.findLocationForBreakout(from: idTimeBreakout)
                        }
                        breakOutString = String(format: "%@\n%@ - %@\n%@", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), location)
                    } else {
                        label.textAlignment = NSTextAlignment.Left
                        label.textColor = UIColor(red: 0.445, green: 0.445, blue: 0.455, alpha: 1.00)
                        breakOutString = String(format: " Breakout %@,%@ - %@", breakOutName, NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle), NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle))
                    }
                }
            }
        }
        return breakOutString
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.segmentedController.selectedSegmentIndex == 0 {
            let currentBreakout = self.fridayBreakouts[section]
            if let breakoutID = currentBreakout.valueForKey("breakoutID") as? String {
                if breakoutID.characters.count > 2 {
                    return 70
                } else {
                    return 20
                }
            }
        } else {
            let currentBreakout = self.saturdayBreakouts[section]
            if let breakoutID = currentBreakout.valueForKey("breakoutID") as? String {
                if breakoutID.characters.count > 2 {
                        return 70
                    } else {
                        return 15
                    }
                }
            }
        return 70
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            switch (segueId) {
                case "toClassDetail":
                     let classDetailView = segue.destinationViewController as! ClassDetailView
                    if self.segmentedController.selectedSegmentIndex == 0 {
                        classDetailView.classSelected = self.findClassSelected(0, and: self.tableView, segue: segue)
                    } else {
                        classDetailView.classSelected = self.findClassSelected(1, and: self.tableView, segue: segue)
                    }
                break
            default:
                let detailBreakout  = segue.destinationViewController as! DetailBreakoutVC
                if let selectedIndex = self.tableView.indexPathForSelectedRow {
                    if self.segmentedController.selectedSegmentIndex == 0 {
                        let selectedBreakout = self.fridayBreakouts[selectedIndex.section]
                        if let title = selectedBreakout.valueForKey("breakoutID") as? String {
                            detailBreakout.title = String(format: "Breakout %@",title)
                        }
                        if let startTime = selectedBreakout.valueForKey("startTime") as? NSDate {
                            if let endTime = selectedBreakout.valueForKey("endTime") as? NSDate {
                                detailBreakout.stringForLabelBreakoutTime = String(format:"%@ - %@", NSDateFormatter.localizedStringFromDate(startTime, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle), NSDateFormatter.localizedStringFromDate(endTime, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
                            }
                        }
                        let selectedBreakoutScheduleItems = self.getAllScheduleItemsForSelectedBreakout(selectedBreakout)
                        detailBreakout.classesInBreakout = self.createClassObjectsReadyToSave(from: selectedBreakoutScheduleItems)
                        
                    } else {
                        let selectedBreakout = self.saturdayBreakouts[selectedIndex.section]
                        if let title = selectedBreakout.valueForKey("breakoutID") as? String {
                            detailBreakout.title = String(format: "Breakout %@",title)
                        }
                        if let startTime = selectedBreakout.valueForKey("startTime") as? NSDate {
                            if let endTime = selectedBreakout.valueForKey("endTime") as? NSDate {
                                detailBreakout.stringForLabelBreakoutTime = String(format:"%@ - %@", NSDateFormatter.localizedStringFromDate(startTime, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle), NSDateFormatter.localizedStringFromDate(endTime, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle))
                            }
                        }
                        let selectedBreakoutScheduleItems = self.getAllScheduleItemsForSelectedBreakout(selectedBreakout)
                        detailBreakout.classesInBreakout = self.createClassObjectsReadyToSave(from: selectedBreakoutScheduleItems)
                    }
                }
            break
            }
        }
    }
    
    
    func findClassSelected(segmentedSelected:Int, and tableView:UITableView, segue:UIStoryboardSegue) -> ClassToSchedule {
        switch (segmentedSelected) {
        case 0:
            if let indexSelected = self.tableView.indexPathForSelectedRow {
            let breakoutSelected = self.fridayBreakouts[indexSelected.section]
            if let classesInBreakout = breakoutSelected.valueForKey("classesScheduled") {
                if let classesInBreakoutArray = classesInBreakout.allObjects as? [ClassScheduled] {
                    if !classesInBreakoutArray.isEmpty {
                        let classSelected = classesInBreakoutArray[indexSelected.row]
                        return self.classToScheduleFromClassScheduled(classSelected)
                        }
                    }
                }
            }
            break
        default:
            if let indexSelected = tableView.indexPathForSelectedRow {
            let breakoutSelected = self.saturdayBreakouts[indexSelected.section]
            if let classesInBreakout = breakoutSelected.valueForKey("classesScheduled") {
                if let classesInBreakoutArray = classesInBreakout.allObjects as? [ClassScheduled] {
                    if !classesInBreakoutArray.isEmpty {
                        let classSelected = classesInBreakoutArray[indexSelected.row]
                             return self.classToScheduleFromClassScheduled(classSelected)
                        }
                    }
                }
            }
            break
        }
        return ClassToSchedule()
    }

    func getbreakoutsByDay() {
        self.fridayBreakouts.removeAll()
        self.saturdayBreakouts.removeAll()
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
 //          print("saturday ",saturdayBreakouts.count)
   //      print("friday ",fridayBreakouts.count)
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
    
    func getAllScheduleItemsForSelectedBreakout(selectedBreakout:Breakout) -> [ScheduleItem] {
        var allScheduleItems:[ScheduleItem] = []
        if let breakoutId = selectedBreakout.valueForKey("id") as? Int {
            // print(breakoutId, "breakoutSelected")
            if let itemsSchedule = ManagedObjectsController.sharedInstance.getAllSchedulesFRomCoreData() as? [ScheduleItem] {
                for item in itemsSchedule {
                    //print(item.presentationTitle)
                    if let isPresentation = item.valueForKey("isPresentation") as? Bool {
                        //  print(isPresentation)
                        if isPresentation {
                            if let itemBreakout = item.valueForKey("breakout") as? Int {
                                //    print(itemBreakout, "item breakout")
                                if itemBreakout == breakoutId {
                                    allScheduleItems.append(item)
                                }
                            }
                        }
                    }
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
                if let itemBreakoutId = item.valueForKey("breakout") as? Int {
                    for breakt in allBreakouts {
                        if itemBreakoutId == breakt.valueForKey("id") as? Int {
                            classObject.breakout = breakt
                        }
                    }
                }
            }
            if let allPresentations = ManagedObjectsController.sharedInstance.getAllPresentationsFromCoreData() as? [Presentation] {
                if let presentationId = item.valueForKey("presentationId") as? Int {
                    for pres in allPresentations {
                        if presentationId == pres.valueForKey("id") as? Int {
                            classObject.presentation = pres
                        }
                    }
                }
            }
            if let allSpeakers = ManagedObjectsController.sharedInstance.getAllSpeakersFromCoreData() as? [Speaker] {
                if let speakerId = classObject.presentation?.valueForKey("speakerId") as? Int {
                    for speak in allSpeakers {
                        if speakerId == speak.valueForKey("speakerId") as? Int {
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
    
    func isClassScheduled(classForCell:ClassToSchedule, from classesInSchedule:[ClassScheduled]) -> Bool {
        for possibleClass in classesInSchedule {
            if  classForCell.presentation?.valueForKey("title") as? String == possibleClass.presentation?.valueForKey("title") as? String {
                return true
            }
        }
        return false
    }
    @IBAction func helpButtonTapped(sender: AnyObject) {
        let blurryEffect = UIBlurEffect(style: .Light)
        helpView.effect = blurryEffect
        helpView.frame = CGRect(x: 30, y: 60, width: self.view.frame.width - 60, height: self.view.frame.height - 150)
        
        let dismissButton = UIButton(frame: CGRect(x: 10, y: helpView.frame.height - 40, width: helpView.frame.width - 20, height: 30))
        dismissButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(FullPersonalSchedule.dismissHelpView), forControlEvents: .AllEvents)
        dismissButton.backgroundColor = UIColor.clearColor()
        helpView.addSubview(dismissButton)
        
        let tipsLabel = UILabel(frame: CGRect(x: 10, y: 10, width: self.self.helpView.frame.width - 20, height: 200))
        tipsLabel.backgroundColor = UIColor.clearColor()
        tipsLabel.numberOfLines = 0
        tipsLabel.text = "Tap on \"Friday\" or \"Saturday\" to update the schedule to the respective day.\n\nTap on \"Find Class\" to find a class for the respective breakout.\n\nTap on a class to find more information about it."
        tipsLabel.textAlignment = .Justified
        tipsLabel.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        helpView.addSubview(tipsLabel)
        self.view.addSubview(helpView)
    }

    func dismissHelpView() {
        self.helpView.removeFromSuperview()
    }
    
}
