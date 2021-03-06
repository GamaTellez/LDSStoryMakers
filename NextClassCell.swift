//
//  NextClassCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/27/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

    protocol SpeakerInfoButtonTappedDelegate {
        func indexOfClassForSpeakerSelected(section:Int)
    }


class NextClassCell: UITableViewCell, UITextViewDelegate {

    
    @IBOutlet var backGroundVieew: UIView!
    @IBOutlet var speakerAndClassNameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var classDescription: UITextView!
    @IBOutlet var speakerBioButton: UIButton!
    var delegate:SpeakerInfoButtonTappedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.speakerAndClassNameLabel.backgroundColor = UIColor.clearColor()
        self.speakerAndClassNameLabel.textColor = UIColor.whiteColor()
        self.speakerAndClassNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.timeLabel.backgroundColor = UIColor.clearColor()
        self.timeLabel.textColor = UIColor.whiteColor()
        self.timeLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.classDescription.backgroundColor = UIColor.whiteColor()
        self.classDescription.textColor = UIColor.blackColor()
        self.classDescription.delegate = self
        self.classDescription.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.backGroundVieew.backgroundColor = UIColor(red: 0.094, green: 0.498, blue: 0.494, alpha: 1.00)
        self.speakerBioButton.layer.cornerRadius = 10
        self.speakerBioButton.setTitle("About Speaker", forState: .Normal)
        self.speakerBioButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.speakerBioButton.backgroundColor = UIColor(red: 0.094, green: 0.498, blue: 0.494, alpha: 1.00)
        self.speakerBioButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        dispatch_async(dispatch_get_main_queue(), {
            let desiredOffset = CGPoint(x: 0, y: -self.classDescription.contentInset.top)
            self.classDescription.setContentOffset(desiredOffset, animated: false)
        })

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    @IBAction func speakerBioButtonTapped(sender: UIButton) {
        self.delegate?.indexOfClassForSpeakerSelected(sender.tag)
    }
    
}
