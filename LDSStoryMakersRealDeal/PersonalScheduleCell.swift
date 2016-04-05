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
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont(name: "AlNile-Bold", size: 15)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
