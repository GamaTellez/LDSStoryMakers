//
//  SpeakerBioView.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/25/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerBioView: UIViewController, UITextViewDelegate {

    @IBOutlet var speakerNameLabel: UILabel!
    @IBOutlet var fillerLabel: UILabel!
    @IBOutlet var speakerImageView: UIImageView!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var bioTextView: UITextView!
    
    var speakerSelected:Speaker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.setViewContent()
    }
    
    func setUpViews() {
        self.fillerLabel.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerNameLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.speakerNameLabel.textColor = UIColor.whiteColor()
        self.speakerImageView.layer.borderColor = UIColor.blackColor().CGColor
        self.speakerImageView.layer.borderWidth = 1
    }
    
    func setViewContent() {
        if let currentSpeaker = self.speakerSelected {
            if let spakerName = currentSpeaker.speakerName {
                self.speakerNameLabel.text = spakerName
            }
            if let speakerBio = currentSpeaker.speakerBio {
                self.bioTextView.text = speakerBio
            }
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
}
