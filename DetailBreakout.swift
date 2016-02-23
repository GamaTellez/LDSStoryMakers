//
//  DetailBreakout.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/22/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakout: UITableViewController {
    var scheduleItems:[ScheduleItem]?
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.scheduleItems?.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
