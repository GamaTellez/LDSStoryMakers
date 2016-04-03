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
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.labelInfo.numberOfLines = 0
        self.labelInfo.preferredMaxLayoutWidth = 30
        self.labelInfo.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.labelInfo.font = UIFont(name: "IowanOldStyle-Roman", size: 10)
    }

    }
