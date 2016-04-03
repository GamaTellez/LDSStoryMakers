//
//  PersonalScheduleCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/3/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

//protocol ClassScheduledDeletedDelegate {
//    func indexOfClassDeletedInTableView(row:Int, table:UITableView)
//}

class PersonalScheduleCell: UITableViewCell {
    @IBOutlet var timeAndLocationLabel: UILabel!
    @IBOutlet var classAndSpeakerLabel: UILabel!
    
    var tableView:UITableView?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeAndLocationLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
        self.timeAndLocationLabel.preferredMaxLayoutWidth = 30
        self.timeAndLocationLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.timeAndLocationLabel.numberOfLines = 0
        self.classAndSpeakerLabel.numberOfLines = 0
        self.classAndSpeakerLabel.preferredMaxLayoutWidth = 30
        self.classAndSpeakerLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.classAndSpeakerLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 15)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
