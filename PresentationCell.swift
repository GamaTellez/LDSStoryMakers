//
//  PresentationCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PresentationCell: UITableViewCell {
    
    @IBOutlet var addRemoveButton: UIButton!
    @IBOutlet var speakerNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var itemTimeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRemoveButton.layer.cornerRadius = self.addRemoveButton.bounds.width/2
        self.addRemoveButton.layer.borderWidth = 0.3
        self.addRemoveButton.layer.borderColor = UIColor.blackColor().CGColor
        self.titleLabel.numberOfLines = 2
        self.titleLabel.preferredMaxLayoutWidth = 35
        self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
