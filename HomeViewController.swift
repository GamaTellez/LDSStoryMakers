//  HomeViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit
import BRYXBanner
import DGActivityIndicatorView


class HomeViewController: UIViewController, UITableViewDelegate {
    
  
    @IBOutlet var helpButton: UIBarButtonItem!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var refreshButton: UIBarButtonItem!
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var addClassButton: UIButton!

    lazy var helpView = UIVisualEffectView()
    lazy var conteinerView = UIView()
    lazy var defaults = NSUserDefaults.standardUserDefaults()
    
    lazy var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    let tableViewDataSource = TableViewDataSource()
    let kclassSelectedNotification = "kClassSelectedNotification"
    let kallObjectsFromGoogleSpreadSheetsInCoreData = "allObjectsFromGoogleSpreadSheetsInCoreData"
    let finishedRedownLoadingData = "finishedRedownLoadingData"
    var newestNotification:Notification?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstLaunch = self.defaults.valueForKey("firstLaunch") as? Bool {
            if firstLaunch  != false {
                self.presentWaitingLoadingView(with: "Welcome To LDStorymakers 2016")
            }
        } else {
            self.presentWaitingLoadingView(with: "Welcome To LDStorymakers 2016")
            self.enableAndDisableTabBarItems(false)
        }
        self.setUpViewsApperance()
        self.setBackgroundImageView()
        self.setUpTablewView()
        self.registerForNotifications()
        self.getAllClassesAndPassToDataSource()
        self.setUpButtons()
        self.setUpStatusBarBackground()
        self.getNewestNotification()
    }
    
    
    func getNewestNotification(){
        NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Notifications") { (finished) -> Void in
            if let newNots = ManagedObjectsController.sharedInstance.getNotification("mostRecent") as? [Notification] {
                if let recentNot = newNots.first {
                    self.newestNotification = recentNot
                    if let notificationMessage = self.newestNotification?.valueForKey("notificationInfo") as? String {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                              let banner = Banner(title: "", subtitle: notificationMessage, image: nil, backgroundColor: UIColor.whiteColor(), didTapBlock: { () -> () in
                              })
                                banner.sizeToFit()
                                banner.dismissesOnTap = true
                                banner.show()
                      })
                    }
                }
            }
        }
    }
    
    func setUpButtons() {
        self.addClassButton.layer.cornerRadius = self.addClassButton.frame.width / 2
        self.addClassButton.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 0.8)
        self.addClassButton.tintColor = UIColor.whiteColor()
        self.addClassButton.setImage(UIImage(named: "homeAddClas"), forState: .Normal)
       // self.refreshButton.setImage(UIImage(named:"refresh"), forState: .Normal)
        self.refreshButton.image = UIImage(named: "refresh")
        self.helpButton.image = UIImage(named: "help")
       
    }
    func setUpStatusBarBackground() {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 22))
        statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
       // self.labelTitle.addSubview(statusBarView)
        self.view.addSubview(statusBarView)
    }
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.scheduleMandatoryClassesOnFirstLaunch), name:kallObjectsFromGoogleSpreadSheetsInCoreData, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.getNewestNotification), name: "appIsResuming", object: nil)
    }
    
    func scheduleMandatoryClassesOnFirstLaunch() {
        let mandatoryClasses = ManagedObjectsController.sharedInstance.getMandatoryClassesForSchedule()
            for mustGoClass in mandatoryClasses {
                ManagedObjectsController.sharedInstance.createScheduledClass(from: mustGoClass, completion: { (succeeded) in
                    if (succeeded == true) {
                        print("must go class added")
                    } else {
                        print("failed to save must go class")
                    }
                })
            }
        self.getAllClassesAndPassToDataSource()
        self.removeAndStopBlurryView()
        self.defaults.setBool(false, forKey: "firstLaunch")
        self.defaults.synchronize()
    }
    
    func getAllClassesAndPassToDataSource() {
        if let allClasses = ManagedObjectsController.sharedInstance.getAllScheduledClasses() as? [ClassScheduled] {
            if allClasses.isEmpty {
                print("have to wait until finshed downloading items")
            } else {
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.tableView.alpha = 1
                })
                self.updateTableViewData(from: allClasses)
                 ManagedObjectsController.sharedInstance.requestPermissionForNotification()
            }
        }
    }
    
    @IBAction func addClassButtonTapped(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 1
    }

    func setBackgroundImageView() {
     //   self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        //self.view.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
    }
    
    func setUpTablewView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.alpha = 0
        self.tableView.dataSource = self.tableViewDataSource
    }
   
    func setUpViewsApperance() {
        self.navBar.tintColor = UIColor.whiteColor()
        self.navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:  UIFont(name: "AppleSDGothicNeo-Bold", size: 20)!]
        self.navBar.topItem?.title = "LDStorymakers 2016"
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
            viewForHeader = self.makeViewForTableViewHeaders(withTitle: "Next")
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
        headerLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
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
            return 248
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
    
    func presentWaitingLoadingView(with text:String) {
        let blurryEfect = UIBlurEffect(style: .Light)
        let blurryEfectView = UIVisualEffectView()
        blurryEfectView.effect = blurryEfect
        blurryEfectView.frame = self.view.frame
        blurryEfectView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        let label = UILabel(frame: CGRect(x: self.view.center.x - 30, y: self.view.center.y, width: self.view.frame.width - 20, height: 60))
        label.center.x = self.view.center.x
        label.center.y = self.view.center.y - 200
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        blurryEfectView.addSubview(label)
        label.text = text
        let activityView = DGActivityIndicatorView(type: .BallPulse, tintColor: UIColor.blackColor(), size: 50)
        activityView.center = self.view.center
        activityView.startAnimating()
        blurryEfectView.addSubview(activityView)
        self.conteinerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.conteinerView.hidden = false
        self.conteinerView.alpha = 1
        self.conteinerView.addSubview(blurryEfectView)
        self.view.addSubview(conteinerView)
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
            UIView.animateWithDuration(1.0, animations: {
                self.presentWaitingLoadingView(with: "Updating Schedule")
            }) { (succeded:Bool) in
                    self.enableAndDisableTabBarItems(false)
                    ManagedObjectsController.sharedInstance.deleteAllDataAndDownloadAgain({ (finished) in
                        NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Schedules", completion: { (finished) in
                            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Speakers", completion: { (finished) in
                                NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Presentations", completion: { (finished) in
                                    NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Breakouts", completion: { (finished) in
                                        dispatch_async(dispatch_get_main_queue(), { 
                                                self.removeAndStopBlurryView()
                                            NSNotificationCenter.defaultCenter().postNotificationName(self.finishedRedownLoadingData, object: nil)
                                        })
                                    })
                                })
                            })
                        })
                })
        }
    }
    
    func removeAndStopBlurryView() {
        UIView.animateWithDuration(1.0, delay: 2.0, options: [], animations: { () -> Void in
            self.conteinerView.alpha = 0
            }) { (done:Bool) -> Void in
                self.conteinerView.hidden = true
                self.enableAndDisableTabBarItems(true)
        }
        self.conteinerView.removeFromSuperview()
    }
    func enableAndDisableTabBarItems(enable:Bool) {
        if let arrayOfTabBarItems = self.tabBarController?.tabBar.items as! AnyObject as? NSArray{
            for item in arrayOfTabBarItems {
                if let tabBarItem = item as? UITabBarItem {
                    tabBarItem.enabled = enable
                }
            }
        }
    }
    
    @IBAction func helpButtonTapped(sender: AnyObject) {
        let blurryEffect = UIBlurEffect(style: .Light)
        helpView.effect = blurryEffect
        helpView.frame = CGRect(x: 30, y: 60, width: self.view.frame.width - 60, height: self.view.frame.height - 150)
    
        let dismissButton = UIButton(frame: CGRect(x: 10, y: helpView.frame.height - 40, width: helpView.frame.width - 20, height: 30))
        dismissButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(HomeViewController.dismissHelpView), forControlEvents: .AllEvents)
        dismissButton.backgroundColor = UIColor.clearColor()
        helpView.addSubview(dismissButton)
        
        let refreshImage = UIImageView(frame: CGRect(x: 10, y: 20, width: 30, height: 30))
        refreshImage.image = UIImage(named: "refresh")
        helpView.addSubview(refreshImage)
        
        let refreshButtonDescriptionLabel = UILabel(frame: CGRect(x: refreshImage.frame.width + 20, y: 20, width: helpView.frame.width - 70, height: 40))
        refreshButtonDescriptionLabel.backgroundColor = UIColor.whiteColor()
        refreshButtonDescriptionLabel.numberOfLines = 2
        refreshButtonDescriptionLabel.backgroundColor = UIColor.clearColor()
        refreshButtonDescriptionLabel.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        refreshButtonDescriptionLabel.text = "Updates the conference schudule to match any changes from Storymakers."
        helpView.addSubview(refreshButtonDescriptionLabel)
        
        let addButtonImage = UIImageView(frame: CGRect(x: 10, y: refreshImage.frame.width + 40, width: 30, height: 30))
        addButtonImage.layer.cornerRadius = addButtonImage.frame.width / 2
        addButtonImage.image = UIImage(named: "homeAddClas")
        addButtonImage.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        helpView.addSubview(addButtonImage)
        
        let addButtonDescriptionLabel = UILabel(frame: CGRect(x: addButtonImage.frame.width + 20, y: refreshButtonDescriptionLabel.frame.height + 25, width: helpView.frame.width - 70, height: 40))
        addButtonDescriptionLabel.backgroundColor = UIColor.clearColor()
        addButtonDescriptionLabel.numberOfLines = 2
        addButtonDescriptionLabel.text = "Tapp to add classes to your schedule"
        addButtonDescriptionLabel.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
        helpView.addSubview(addButtonDescriptionLabel)
        let tipsLabel = UILabel(frame: CGRect(x: 10, y: addButtonImage.frame.height + refreshImage.frame.height + 50, width: helpView.frame.width - 20, height: 150))
        tipsLabel.backgroundColor = UIColor.clearColor()
        tipsLabel.numberOfLines = 0
        tipsLabel.text = "The \"Next\" section tells you which event is coming up next in your schedule.\n\nThe \"Upcoming\" sections tells you what events are coming up next.\n\n To view your schedule in more detail tap the button Personal at the bottom of the view"
        tipsLabel.textAlignment = .Justified
        tipsLabel.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        helpView.addSubview(tipsLabel)
        self.view.addSubview(helpView)
    }
    
    func dismissHelpView() {
        self.helpView.removeFromSuperview()
    }
  
    
}

