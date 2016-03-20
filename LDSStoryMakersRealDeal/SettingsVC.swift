//
//  SettingsVC.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var backGroundImage: UIImageView!
    @IBOutlet var conferenceFeedBackButton: UIButton!
    @IBOutlet var courseFeedBackButton: UIButton!
    @IBOutlet var switchNotifications: UISwitch!
    @IBOutlet var notificationsLabel: UILabel!
    @IBOutlet var feedBackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpApperanceViews()
        self.setBackgroundImageView()
        self.setUpStatusBarBackground()
        
    
    }
    
    func setBackgroundImageView() {
        self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
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

    
    func setUpApperanceViews() {
        let underlinedText =  NSAttributedString(string: "Feedback", attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        self.feedBackLabel.attributedText = underlinedText
        self.conferenceFeedBackButton.backgroundColor = UIColor.whiteColor()
        self.conferenceFeedBackButton.layer.masksToBounds = false
        self.conferenceFeedBackButton.layer.shadowColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00).CGColor
        self.conferenceFeedBackButton.layer.shadowOpacity = 1.0
        self.conferenceFeedBackButton.layer.shadowRadius = 0
        self.conferenceFeedBackButton.layer.shadowOffset = CGSizeMake(0, 0.1)
        self.conferenceFeedBackButton.titleLabel?.numberOfLines = 2
        self.conferenceFeedBackButton.setTitle("Take the course feedback.\n We would greately appreciate it", forState: .Normal)
        self.conferenceFeedBackButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.conferenceFeedBackButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.courseFeedBackButton.backgroundColor = UIColor.whiteColor()
        self.courseFeedBackButton.layer.masksToBounds = false
        self.courseFeedBackButton.layer.shadowColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00).CGColor
        self.courseFeedBackButton.layer.shadowOpacity = 1.0
        self.courseFeedBackButton.layer.shadowRadius = 0
        self.courseFeedBackButton.layer.shadowOffset = CGSizeMake(0, 0.1)
        self.courseFeedBackButton.titleLabel?.numberOfLines = 2
        self.courseFeedBackButton.setTitle("Take the course feedback.\n We would greately appreciate it", forState: .Normal)
        self.courseFeedBackButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.courseFeedBackButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        self.notificationsLabel.numberOfLines = 2
        self.notificationsLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 15)
        self.notificationsLabel.text = "Notifications"
    }
    
    func updateNotificationLabelText(onOff:String) {
        
    }
    
    @IBAction  func conferenceFeedBackButtonTapped(sender:UIButton) {
        ManagedObjectsController.sharedInstance.openConferenceFeedBack()
    }
    
    @IBAction func courseFeedBackButtonTapped(sender:UIButton) {
        ManagedObjectsController.sharedInstance.openGeneralCourseFeedBack()
    }
    
    @IBAction func notificationSwitchTapped(sender: UISwitch) {
        if sender.on {
            self.updateNotificationLabelText("On.")
        } else {
            self.updateNotificationLabelText("Off.")
        }
    }
}
