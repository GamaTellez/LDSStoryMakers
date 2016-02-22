//
//  FullScheduleViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/19/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class FullScheduleViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        self.setViewControllerBackgroundImage()
        self.getAllBreakouts()
        self.setUpTableView()
    }
    
    func getAllBreakouts() -> [Breakout] {
        var allBreakouts:[Breakout] = []
        if let breakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
            allBreakouts = breakouts
        }
//        for timeBreakout in allBreakouts {
//            print(timeBreakout.id)
//            print(timeBreakout.startTime)
//        }
        return allBreakouts
    }
    
    func setViewControllerBackgroundImage() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func setUpTableView(){
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "CustomBreakoutCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: breakoutCellID)
        tableView.registerClass(BreakoutCell.self, forCellReuseIdentifier: breakoutCellID)
        self.tableView.showsVerticalScrollIndicator = false

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    @IBAction func segementedControllerTapped(sender: AnyObject) {
        
    }

}
