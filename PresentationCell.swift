//
//  PresentationCell.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

protocol PresentationCellButtonDelegate {
    func indexOfClassSelectedWithButton(section:Int, and button:AddRemoveClass)
}

class PresentationCell: UITableViewCell {
    
 
    @IBOutlet var addRemoveButton: AddRemoveClass!
    @IBOutlet var speakerAndLocationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

 
    var delegate:PresentationCellButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRemoveButton.layer.cornerRadius = self.addRemoveButton.bounds.width/2
        //self.addRemoveButton.setBackgroundImage(UIImage(named: "addButton"), forState: .Normal)
       // self.addRemoveButton.setBackgroundImage(UIImage(named: "removeClass"), forState: .Selected)
        self.titleLabel.numberOfLines = 3
        self.titleLabel.preferredMaxLayoutWidth = 35
        self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.titleLabel.backgroundColor = UIColor.grayColor()
        self.titleLabel.font = UIFont(name: "SanFranciscoText-Semibold", size: 20)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.descriptionLabel.preferredMaxLayoutWidth = 35
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.descriptionLabel.font = UIFont(name: "SanFranciscoText-Light", size: 18)
        self.descriptionLabel.numberOfLines = 3
        self.speakerAndLocationLabel.font = UIFont(name: "SanFranciscoText-Semibold", size: 15)
        
    }
        @IBAction func addRemoveButtonTapped(sender: AddRemoveClass) {
        if let buttonSection = sender.section {
            self.delegate?.indexOfClassSelectedWithButton(buttonSection, and: sender)
        }
    }

    

}
