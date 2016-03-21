//
//  HomeViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit
import BRYXBanner

class HomeViewController: UIViewController, UITableViewDelegate {
    
   // @IBOutlet var notificationLabelBanner: UILabel!
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addClassButton: UIButton!
    //@IBOutlet var notificationsButton: UIButton!
    @IBOutlet var labelTitle: UILabel!
    
    lazy var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    let tableViewDataSource = TableViewDataSource()
    let kclassSelectedNotification = "kClassSelectedNotification"
    let kallObjectsFromGoogleSpreadSheetsInCoreData = "allObjectsFromGoogleSpreadSheetsInCoreData"
    var newestNotification:Notification?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLabelsApperance()
        self.setBackgroundImageView()
        self.setUpTablewView()
        self.registerForNotifications()
        self.getAllClassesAndPassedToDataSource()
        self.setUpButtons()
        self.setUpStatusBarBackground()
        self.getNewestNotification()
    }
    
    func getNewestNotification(){
        NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Notifications") { (finished) -> Void in
            if let newNot = ManagedObjectsController.sharedInstance.getNotification("mostRecent") as? [Notification] {
                if let recentNot = newNot.first {
                    self.newestNotification = recentNot
                    if let notificationMessage = self.newestNotification?.valueForKey("notificationInfo") as? String {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                              let banner = Banner(title: "", subtitle: notificationMessage, image: nil, backgroundColor: UIColor.redColor(), didTapBlock: { () -> () in
                              })
                                banner.dismissesOnTap = true
                                banner.show()
                            
                        })
                    }
                }
            }
        }
    }
    

    
    func setUpButtons() {
        //self.notificationsButton.layer.cornerRadius = self.notificationsButton.frame.width / 2
        //self.notificationsButton.layer.borderWidth = 1
        //self.notificationsButton.layer.borderColor = UIColor.blackColor().CGColor
        //self.notificationLabelBanner.userInteractionEnabled = true
      //  self.notificationsButton.setBackgroundImage(UIImage(named: "closeBlack"), forState: .Normal)
        self.addClassButton.layer.cornerRadius = self.addClassButton.frame.width / 2
        self.addClassButton.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 0.8)
        //self.addClassButton.setBackgroundImage(UIImage(named: "cross-3"), forState: .Normal)
    }
    func setUpStatusBarBackground() {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 22))
        statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
        self.labelTitle.addSubview(statusBarView)
    }
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "scheduleMandatoryClassesOnFirstLaunch", name:kallObjectsFromGoogleSpreadSheetsInCoreData, object: nil)
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatePersonalSchedule:", name: self.kclassSelectedNotification, object: nil)
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

//    @IBAction func dismissNotificationButtonTapped(button:UIButton) {
//        UIView.animateWithDuration(0.6, animations: { () -> Void in
//            self.notificationLabelBanner.center.y -= self.notificationLabelBanner.frame.height
//            self.tableView.center.y -= self.notificationLabelBanner.frame.height
//            self.notificationsButton.center.y -= self.notificationLabelBanner.frame.height
//            }) { (Bool) -> Void in
//        }
//    }
    
    @IBAction func addClassButtonTapped(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 1
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
//        self.notificationLabelBanner.backgroundColor = UIColor.whiteColor()
//        self.notificationLabelBanner.clipsToBounds = true
//        self.notificationLabelBanner.preferredMaxLayoutWidth = 30
//        self.notificationLabelBanner.lineBreakMode = NSLineBreakMode.ByTruncatingTail
//        self.notificationLabelBanner.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
//        self.notificationLabelBanner.numberOfLines = 0
        self.labelTitle.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.labelTitle.numberOfLines = 2
        self.labelTitle.text = "\n LDS Storymakers Conference 2016"
        //self.fillerLabel.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
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
            return 210
        
        default:
            if indexPath.row == 3 {
            return 40
            } 
            return 81
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section {
        case 1:
                self.tabBarController?.selectedIndex = 2
        default:
            break
        }
    }
}

