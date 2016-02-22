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
    
    var fridayBreakouts:[Breakout] = []
    var saturdayBreakouts:[Breakout] = []
    let tableViewDataSoruce:BreakoutsDataSource = BreakoutsDataSource()
    
    override func viewDidLoad() {
        self.getbreakoutsByDay()
        self.setViewControllerBackgroundImage()
        self.setUpTableView()
        self.segmentedController.selectedSegmentIndex = 0
    }
    
    func setViewControllerBackgroundImage() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func setUpTableView(){
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self.tableViewDataSoruce
        self.loadTableViewWithBreakouts(self.fridayBreakouts)
    }
    
    func loadTableViewWithBreakouts(breakoutsByDay:[Breakout]) {
        self.tableViewDataSoruce.updateBreakoutsArray(with: breakoutsByDay)
        self.tableView.reloadData()
    }
    
    func getbreakoutsByDay() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let friday = formatter.dateFromString("5/6/2016")
        let saturday = formatter.dateFromString("5/7/2016")
        if let allBreakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
            var order = NSCalendar.currentCalendar()
            for timeBreakout in allBreakouts {
                if timeBreakout.breakoutID?.characters.count > 2 {
                    print("it is a mandatory thingy")
                } else {
                if let dayDate = timeBreakout.startTime {
                  //  print(NSDateFormatter.localizedStringFromDate(dayDate, dateStyle: .FullStyle, timeStyle: .NoStyle))
                        let comparison = order.compareDate(friday!, toDate: dayDate, toUnitGranularity: .Day)
                        if comparison == NSComparisonResult.OrderedSame {
                            self.fridayBreakouts.append(timeBreakout)
                        }
                        let comparisonTwo = order.compareDate(saturday!, toDate: dayDate, toUnitGranularity: .Day)
                        if comparisonTwo == NSComparisonResult.OrderedSame {
                            self.saturdayBreakouts.append(timeBreakout)
                        }
                    }
                }
            }
        }
        print(String("FirdayBreakoouts %@",self.fridayBreakouts.count))
        print(String("Saturday breakouts %@", self.saturdayBreakouts.count))
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
    
    @IBAction func segementedControllerTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.loadTableViewWithBreakouts(self.fridayBreakouts)
            break
        case 1:
            self.loadTableViewWithBreakouts(self.saturdayBreakouts)
            break
        default:
            break
        }
    }

}
