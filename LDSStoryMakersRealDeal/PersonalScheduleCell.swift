//
//  PersonalScheduleCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PersonalScheduleCell: UITableViewCell {
    @IBOutlet var timeAndLocationLabel: UILabel!
    @IBOutlet var classAndSpeakerLabel: UILabel!
    @IBOutlet var removeClassButton: AddRemoveClass!
    @IBOutlet var extraBackGRoundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.removeClassButton.layer.cornerRadius = self.removeClassButton.bounds.width/2
        self.removeClassButton.backgroundColor = UIColor(red: 0.561, green: 0.008, blue: 0.020, alpha: 0.6)
        self.extraBackGRoundView.backgroundColor = UIColor.whiteColor()
        self.timeAndLocationLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
        self.timeAndLocationLabel.preferredMaxLayoutWidth = 30
        self.timeAndLocationLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.timeAndLocationLabel.numberOfLines = 0
        self.classAndSpeakerLabel.numberOfLines = 0
        self.classAndSpeakerLabel.preferredMaxLayoutWidth = 30
        self.classAndSpeakerLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.classAndSpeakerLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
