//
//  DetailBreakoutVC.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutVC: UIViewController, UITableViewDelegate{

    @IBOutlet var labelBreakoutTime: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backGroundImage: UIImageView!
   
    var tableViewDataSource = DetailBreakoutDataSource()
    var classesInBreakout:[ClassToSchedule] = []
    var stringForLabelBreakoutTime:String?
    let scheduleItemCellID = "scheduleItemCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
        self.setUpTableView()
        self.loadTableViewWithBreakouts(self.classesInBreakout)
        self.setUpLabel()
        
    }
    func setUpLabel() {
        self.labelBreakoutTime.text = self.stringForLabelBreakoutTime
        self.labelBreakoutTime.backgroundColor = UIColor.clearColor()
    }
    
    func setBackgroundImageView() {
        self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }

    func setUpTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.tableViewDataSource
  
    }
    func loadTableViewWithBreakouts(allClassesPos:[ClassToSchedule]) {
        self.tableViewDataSource.updateClassesArray(from: allClassesPos)
        self.tableView.reloadData()
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueID = segue.identifier {
            switch segueID {
            default:
                let classSelectedDetailVC = segue.destinationViewController as! ClassDetailView
                if let indexOfClassSelected = self.tableView.indexPathForSelectedRow?.section {
                    let classSelected = self.classesInBreakout[indexOfClassSelected]
                    classSelectedDetailVC.classSelected = classSelected
                }
                break
            }
        }
    }

}
