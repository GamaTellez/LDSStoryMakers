//
//  NextClassCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/27/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class NextClassCell: UITableViewCell, UITextViewDelegate {

    
    @IBOutlet var backGroundVieew: UIView!
    @IBOutlet var speakerAndClassNameLabel: UITextView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var classDescription: UITextView!
    @IBOutlet var courseFeedBackButton: UIButton!
    @IBOutlet var speakerBioButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.speakerAndClassNameLabel.backgroundColor = UIColor.clearColor()
        self.speakerAndClassNameLabel.textColor = UIColor.whiteColor()
        self.timeLabel.backgroundColor = UIColor.clearColor()
        self.timeLabel.textColor = UIColor.whiteColor()
        self.classDescription.backgroundColor = UIColor.whiteColor()
        self.classDescription.textColor = UIColor.blackColor()
        self.classDescription.delegate = self
        self.backGroundVieew.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerBioButton.layer.cornerRadius = 10
        self.speakerBioButton.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerBioButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.courseFeedBackButton.layer.cornerRadius = 10
        self.courseFeedBackButton.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.courseFeedBackButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
}
