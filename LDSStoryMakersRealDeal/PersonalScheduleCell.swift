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

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var speakerLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var tableView:UITableView?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.speakerLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.locationLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
