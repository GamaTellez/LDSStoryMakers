//
//  BreakoutCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/21/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutCell: UITableViewCell {
let breakoutCellID = "breakoutCell"
    @IBOutlet var breakoutLabel: UILabel!
    
     override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        self.breakoutLabel.layer.borderColor = UIColor.blackColor().CGColor
        self.breakoutLabel.backgroundColor = UIColor.whiteColor()
        self.breakoutLabel.numberOfLines = 2
        self.breakoutLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
