//
//  HomeViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var topLabelBar: UILabel!
    @IBOutlet var notificationLabelBanner: UILabel!
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var fillerLabel: UILabel!
    

    let tableViewDataSource = TableViewDataSource()
     let kclassSelectedNotification = "kClassSelectedNotification"
     let kallObjectsFromGoogleSpreadSheetsInCoreData = "allObjectsFromGoogleSpreadSheetsInCoreData"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLabelsApperance()
        self.setBackgroundImageView()
        self.setUpTablewView()
        self.registerForNotifications()
        self.getAllClassesAndPassedToDataSource()

    }
    
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "scheduleMandatoryClassesOnFirstLaunch", name:kallObjectsFromGoogleSpreadSheetsInCoreData, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatePersonalSchedule:", name: self.kclassSelectedNotification, object: nil)
    }
    
    func scheduleMandatoryClassesOnFirstLaunch() {
        let mandatoryClasses = ManagedObjectsController.sharedInstance.getMandatoryClassesForSchedule()
            for mustGoClass in mandatoryClasses {
                ManagedObjectsController.sharedInstance.createScheduledClass(from: mustGoClass)
            }
        self.getAllClassesAndPassedToDataSource()
    }
    
    func getAllClassesAndPassedToDataSource() {
        if let allClasses = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled] {
            if allClasses.isEmpty {
                print("have to wait until finshed downloading items")
            } else {
                self.updateTableViewData(from: allClasses)
            }
        }
    }
//    func getFullScheduleForFridayAndSaturday() {
//        if let fridayAndSaturday = ManagedObjectsController.sharedInstance.getFridayAndSaturdayObjects() as? [Day] {
//            if fridayAndSaturday.isEmpty {
//                print("have to wait until all objects are downloaded")
//            } else {
//            self.friday = fridayAndSaturday[0]
//            self.saturday = fridayAndSaturday[1]
//            print(self.friday?.name)
//                print(self.friday?.scheduledClasses?.count)
//                print(self.friday?.date)
//            print(self.saturday?.name)
//                print(self.saturday?.scheduledClasses?.count)
//                print(saturday?.date)
//            }
//        }
//    }
    
//    func getDaysObjects() {
//        let fridayAndSaturday = ManagedObjectsController.sharedInstance.getFridayAndSaturdayObjects()
//        if fridayAndSaturday.isEmpty {
//           ManagedObjectsController.sharedInstance.createFridayAndSaturday()
//            if let fridayAndSaturday = ManagedObjectsController.sharedInstance.getFridayAndSaturdayObjects() as? [Day] {
//                 self.friday = fridayAndSaturday[0]
//                 self.saturday = fridayAndSaturday[1]
//                let mandatoryClassesForSchedule = ManagedObjectsController.sharedInstance.getMandatoryClassesForSchedule()
//                let ordererByDate = NSCalendar.currentCalendar()
//                for itemToSchedule in mandatoryClassesForSchedule {
//                    if let startDate = itemToSchedule.breakout?.startTime {
//                        let comparison = ordererByDate.compareDate(friday!.date!, toDate: startDate, toUnitGranularity: .Day)
//                        if comparison == NSComparisonResult.OrderedSame {
//                            ManagedObjectsController.sharedInstance.createScheduledClass(from: itemToSchedule, with: self.friday!)
//                        } else {
//                            ManagedObjectsController.sharedInstance.createScheduledClass(from: itemToSchedule, with: self.saturday!)
//                        }
//                    }
//                }
//                if let fridayAndSaturday = ManagedObjectsController.sharedInstance.getFridayAndSaturdayObjects() as? [Day] {
//                }
//        } else {
//            }
//        }
//    }
    
    func updatePersonalScheduleWithNewClass(notification:NSNotification) {
        if let classSelected = notification.userInfo!["classSelected"] as? ClassToSchedule {
            print(classSelected.presentation?.title)
        }
    }
    func setBackgroundImageView() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func setUpTablewView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.tableViewDataSource
    }
   
    func setUpLabelsApperance() {
        self.notificationLabelBanner.backgroundColor = UIColor.whiteColor()
        self.notificationLabelBanner.clipsToBounds = true
        self.fillerLabel.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.topLabelBar.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.topLabelBar.textColor = UIColor.whiteColor()
        
    }
    
    func updatePersonalSchedule(notification:NSNotification) {
        print("we are receiving the notifixation")
            if let classObject = notification.userInfo!["classSelected"] as? ClassToSchedule {
                   print(classObject)
            }
        
    }
    
    func updateTableViewData(from arrayOfClasses:[ClassScheduled]) {
        self.tableViewDataSource.updateArrayForDataSource(arrayOfClasses)
        self.tableView.reloadData()
    }
    
    //tableview delegate methods
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var viewForHeader:UIView = UIView()
        switch section {
        case 1:
            viewForHeader = self.makeViewForTableViewHeaders(withTitle: "Upcoming Class")
            break
        default:
            viewForHeader = self.makeViewForTableViewHeaders(withTitle: "Next Class")
            break
        }        
        return viewForHeader
    }
    
    func makeViewForTableViewHeaders(withTitle title:String) ->UIView {
        let underLinedAttribute =  [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let underLinedAttributedString = NSAttributedString(string: title, attributes: underLinedAttribute)

        let headerSectionView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20.0))
        headerSectionView.backgroundColor = UIColor.clearColor()
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: headerSectionView.frame.width, height: headerSectionView.frame.height))
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.attributedText = underLinedAttributedString
        headerLabel.textColor = UIColor(red: 0.310, green: 0.431, blue: 0.435, alpha: 1.00)
        headerSectionView.addSubview(headerLabel)
           return headerSectionView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 185
        default:
            return 81
        }
    }
    
}

