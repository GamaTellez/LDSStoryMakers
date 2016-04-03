//
//  SettingsVC.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, NotificationsToggledDelegate{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backGroundImage: UIImageView!
    var dataSource = SettingsDataSource()
    lazy var defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
        self.setUpStatusBarBackground()
        self.tableView.dataSource = self.dataSource
        self.dataSource.delegate = self
    }
    
    func setBackgroundImageView() {
       // self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        //self.view.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)

    }

    func setUpStatusBarBackground() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
        titleLabel.text = "\nSettings"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.view.addSubview(titleLabel)
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 22))
        statusBarView.backgroundColor = UIColor(red: 0.125, green: 0.337, blue: 0.353, alpha: 1.00)
        titleLabel.addSubview(statusBarView)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                ManagedObjectsController.sharedInstance.openConferenceFeedBack()
            }
            if indexPath.row == 1 {
                ManagedObjectsController.sharedInstance.openGeneralCourseFeedBack()
            }
        }
    }
  
    func notificationsSwitchToggled(switchSelected: Bool) {
        self.setNotificationsSettings(switchSelected)
       self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: .Fade)
    }
    
    func setNotificationsSettings(onOrOff:Bool) {
        if onOrOff {
            self.defaults.setBool(true, forKey: "localNotifications")
            self.defaults.synchronize()
        } else {
            self.defaults.setBool(false, forKey: "localNotifications")
            self.defaults.synchronize()
        }
    }
}
