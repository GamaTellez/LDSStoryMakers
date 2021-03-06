//
//  UpcomingClassCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/27/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class UpcomingClassCell: UITableViewCell {

    @IBOutlet var backGroundView: UIView!
    @IBOutlet var classLocationAndTime: UILabel!
    @IBOutlet var className: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classLocationAndTime.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.classLocationAndTime.numberOfLines = 2
        self.className.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.backGroundView.backgroundColor = UIColor.whiteColor()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    

        // Configure the view for the selected state
    }

}
