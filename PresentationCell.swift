//
//  PresentationCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

protocol PresentationCellButtonDelegate {
    func indexOfClassSelectedWithButton(section:Int, and button:UIButton)
}

class PresentationCell: UITableViewCell {
    
    @IBOutlet var isInBreakoutLabel: UILabel!
    @IBOutlet var fadedViewClassContent: UIView!
    @IBOutlet var addRemoveButton: UIButton!
    @IBOutlet var speakerAndLocationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

 
    var delegate:PresentationCellButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRemoveButton.layer.cornerRadius = self.addRemoveButton.bounds.width/2
        self.speakerAndLocationLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.addRemoveButton.tintColor = UIColor.clearColor()
        self.addRemoveButton.setBackgroundImage(UIImage(named: "homeAddClas"), forState: .Normal)
        self.addRemoveButton.setBackgroundImage(UIImage(named: "removeClass"), forState: .Selected)
        self.titleLabel.numberOfLines = 3
        self.titleLabel.preferredMaxLayoutWidth = 35
        self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.titleLabel.backgroundColor = UIColor.grayColor()
        self.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.descriptionLabel.preferredMaxLayoutWidth = 35
        self.descriptionLabel.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.descriptionLabel.numberOfLines = 3
        self.descriptionLabel.textAlignment = .Justified
        self.fadedViewClassContent.hidden = true
        self.fadedViewClassContent.alpha = 0.9
        self.isInBreakoutLabel.hidden = true
        self.isInBreakoutLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        
    }
        @IBAction func addRemoveButtonTapped(sender: UIButton) {
            self.delegate?.indexOfClassSelectedWithButton(sender.tag, and: sender)
            self.fadedViewClassContent.hidden = true
            self.isInBreakoutLabel.hidden = true
    }
    
    override func prepareForReuse() {
        //self.backgroundColor = UIColor.whiteColor()
        self.fadedViewClassContent.hidden =  true
        self.isInBreakoutLabel.hidden = true
    }
    
    func setInBreakoutLabel(breakoutID:Int) {
        self.isInBreakoutLabel.hidden = false
        self.fadedViewClassContent.hidden = false
        self.isInBreakoutLabel.text = String(format:"Saved in breakout %d", breakoutID)
    }
}
