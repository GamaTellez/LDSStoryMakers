//
//  SettingsDataSource.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/30/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

protocol NotificationsToggledDelegate{
    func notificationsSwitchToggled(switchSelected:Bool)
}

class SettingsDataSource: NSObject, UITableViewDataSource {
    let feedBackCell = "feedBackCell"
    let notificationsCell = "notificationsCell"
    var onOffNotifications = ""
    var delegate:NotificationsToggledDelegate?
    lazy var defaults = NSUserDefaults.standardUserDefaults()
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "FeedBack"
        } else {
            return "Notifications"
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellForFeedBack =  tableView.dequeueReusableCellWithIdentifier(feedBackCell)
            if indexPath.row == 0 {
                cellForFeedBack?.textLabel?.text = "Conference Feedback"
            } else {
                cellForFeedBack?.textLabel?.text = "Course Feedback"
            }
            return cellForFeedBack!
        default:
            let cellForNotifications = tableView.dequeueReusableCellWithIdentifier(notificationsCell)
            cellForNotifications?.textLabel?.text = "Class Notifications"
            let switchNotifications = UISwitch()
            let userNotifications = self.checkIfNotificationSettingIsOn()
            if userNotifications == true {
                onOffNotifications = "On"
                switchNotifications.setOn(true, animated: false)
            } else {
                onOffNotifications = "Off"
                switchNotifications.setOn(false, animated: false)
            }
            cellForNotifications?.detailTextLabel?.text = onOffNotifications
            switchNotifications.addTarget(self, action: #selector(SettingsDataSource.switchTapped), forControlEvents: .ValueChanged)
            cellForNotifications?.accessoryView = switchNotifications
            cellForNotifications?.selectionStyle = .None
            return cellForNotifications!
        }
    }
    
    func switchTapped(sender:UISwitch) {
     self.delegate?.notificationsSwitchToggled(sender.on)
    }
    
    func checkIfNotificationSettingIsOn() -> Bool {
        if let localNotifications = self.defaults.valueForKey("localNotifications") as? Bool {
            if localNotifications {
                return true
            }
        } else {
            return false
        }
        return false
    }

}
