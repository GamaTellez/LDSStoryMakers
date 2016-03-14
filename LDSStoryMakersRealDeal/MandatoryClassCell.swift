//
//  MandatoryClassCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/14/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class MandatoryClassCell: UITableViewCell {

    @IBOutlet var labelInfo: UILabel!
    @IBOutlet var extraBackGroundView: UIView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.labelInfo.numberOfLines = 0
        self.labelInfo.preferredMaxLayoutWidth = 30
        self.labelInfo.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.labelInfo.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
        self.extraBackGroundView.backgroundColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1.00)
    }

    }
