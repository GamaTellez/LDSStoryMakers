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
   // var indexOfClassSelected: Int { get set }
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
       // self.addRemoveButton.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.addRemoveButton.setBackgroundImage(UIImage(named: "button-add_green"), forState: .Normal)
        self.addRemoveButton.setBackgroundImage(UIImage(named: "removewButton"), forState: .Selected)
        self.titleLabel.numberOfLines = 3
        self.titleLabel.preferredMaxLayoutWidth = 35
        self.titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.titleLabel.backgroundColor = UIColor.grayColor()
        self.titleLabel.font = UIFont(name: "SanFranciscoText-Semibold", size: 20)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.descriptionLabel.preferredMaxLayoutWidth = 35
        //self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
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
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//       UIView.animateWithDuration(0.5) { () -> Void in
//        self.addRemoveButton.alpha = 0
//        self.speakerAndLocationLabel.alpha = 0
//        self.descriptionLabel.alpha = 0
//        self.titleLabel.alpha = 0
//        self.addRemoveButton.alpha = 1
//        self.speakerAndLocationLabel.alpha = 1
//        self.descriptionLabel.alpha = 1
//        self.titleLabel.alpha = 1
//        }
        
        // Configure the view for the selected state
    }
    

}
