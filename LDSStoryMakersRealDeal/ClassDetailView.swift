//
//  ClassDetailView.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/24/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ClassDetailView: UIViewController, UITextViewDelegate {
    @IBOutlet var classTitleLabel: UILabel!
    @IBOutlet var classTimeLabel: UILabel!
    @IBOutlet var classLocationLabel: UILabel!
    @IBOutlet var classDescriptionTextView: UITextView!
    @IBOutlet var speakerButton: UIButton!
    @IBOutlet var feecBackButtom: UIButton!
    
    @IBOutlet var backGroundImage: UIImageView!
    var classSelected:ClassToSchedule?
    lazy var userDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
        self.setViewsAppearance()
        self.setUpViewsContent()
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            let desiredOffset = CGPoint(x: 0, y: -self.classDescriptionTextView.contentInset.top)
            self.classDescriptionTextView.setContentOffset(desiredOffset, animated: false)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackgroundImageView() {
        //self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        //self.view.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
    }
    
    func setViewsAppearance() {
        self.classTitleLabel.backgroundColor = UIColor.clearColor()
        self.classTitleLabel.preferredMaxLayoutWidth = self.classTitleLabel.frame.width
        self.classTitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.classTitleLabel.numberOfLines = 0
        self.classTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        self.classTimeLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.classTimeLabel.textColor = UIColor(red: 0.445, green: 0.445, blue: 0.455, alpha: 1.00)
        self.classTimeLabel.backgroundColor = UIColor.clearColor()
        self.classTimeLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.classDescriptionTextView.textColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.classDescriptionTextView.textAlignment = NSTextAlignment.Center
        self.classDescriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.classDescriptionTextView.backgroundColor = UIColor.clearColor()
        self.speakerButton.titleLabel?.textColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerButton.layer.cornerRadius = 5
        self.speakerButton.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerButton.setTitleColor(UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00), forState: .Normal)
        self.speakerButton.titleLabel?.preferredMaxLayoutWidth = self.speakerButton.frame.width
        self.speakerButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.speakerButton.titleLabel?.numberOfLines = 2
        self.speakerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.feecBackButtom.layer.cornerRadius = 5
        self.feecBackButtom.titleLabel?.textColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.feecBackButtom.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.feecBackButtom.setTitleColor(UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00), forState: .Normal)
        self.classLocationLabel.textColor = UIColor(red: 0.445, green: 0.445, blue: 0.455, alpha: 1.00)
        self.classLocationLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
//        let navTitleLAbel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.classTitleLabel.frame.height))
//        navTitleLAbel.numberOfLines = 0
//        navTitleLAbel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
//        navTitleLAbel.textAlignment = .Center
//        navTitleLAbel.preferredMaxLayoutWidth = 30
//        navTitleLAbel.lineBreakMode = .ByWordWrapping
//        navTitleLAbel.sizeToFit()
//        navTitleLAbel.text = "fdsfdsfdsfdsfdsfdsfdsf sdfdsfd sdfdsf sdfdsf sdfd fsdf"
//        navTitleLAbel.textColor = UIColor.whiteColor()
//        self.navigationController?.navigationItem.titleView = navTitleLAbel
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    
    func setUpViewsContent() {
        if let currentClass = self.classSelected {
            if let classTitle = currentClass.scheduleItem?.presentationTitle {
                self.classTitleLabel.text = classTitle
            }
            if let startDate = currentClass.breakout?.startTime {
            let startTime = NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                if let endDate = currentClass.breakout?.endTime {
                    let endTime = NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
                    self.classTimeLabel.text = String(format:"%@ %@ - %@", self.getDayFromDate(startDate), startTime, endTime)
                }
            }
            if let location = currentClass.scheduleItem?.location {
                self.classLocationLabel.text = location
            } else {
                self.classLocationLabel.text = "To be determined"
            }
            if let classDescription = currentClass.presentation?.presentationDescription {
                self.classDescriptionTextView.text = classDescription
            }
            if let speakerName = currentClass.presentation?.speakerName {
                self.speakerButton.setTitle(speakerName, forState: .Normal)
            }
             self.feecBackButtom.setTitle("Feedback", forState: .Normal)
        }
    }
    
    
    func getDayFromDate(date:NSDate) -> String {
           let day = NSCalendar.currentCalendar().component(.Weekday, fromDate: date)
        switch day {
        case 6:
            return "Friday"
        default:
            return "Saturday"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            switch segueId {
            default:
                let speakerBioVC = segue.destinationViewController as! SpeakerBioView
                if let speakerOfClassSelected = self.classSelected?.valueForKey("speaker") as? Speaker {
                    speakerBioVC.speakerSelected = speakerOfClassSelected
                }
                break
            }
        }
    }

    @IBAction func feedBackButtonTapped(sender: AnyObject) {
        if let courseName = self.classSelected?.presentation?.valueForKey("title") as? String {
            ManagedObjectsController.sharedInstance.openFeedBackPageForCourse(courseName)
        }
    }
    
}
