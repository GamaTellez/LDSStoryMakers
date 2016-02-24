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
        //        cell?.layer.cornerRadius = 10
        //        cell?.layer.shadowColor = UIColor.blackColor().CGColor
        //        cell?.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        //        cell?.layer.shadowRadius = 5
        //        cell?.layer.shadowOpacity = 0.3
        //        cell?.layer.masksToBounds = false
        
        self.breakoutLabel.layer.borderColor = UIColor.blackColor().CGColor
        // cell?.breakoutLabel.layer.cornerRadius = 10
        self.breakoutLabel.backgroundColor = UIColor.whiteColor()
        self.breakoutLabel.layer.shadowOpacity = 0.5
        self.breakoutLabel.layer.shadowOffset = CGSizeMake(2.5, 2.5)
        self.breakoutLabel.layer.shadowRadius = 10
        self.breakoutLabel.numberOfLines = 2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
