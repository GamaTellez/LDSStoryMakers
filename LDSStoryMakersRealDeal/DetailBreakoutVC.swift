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
    let itemSuccesfullySaved = "itemSuccesfullySaved"
    let itemSuccesFullyDeleted = "itemSuccesFullyDeleted"
    let timeConlictNotication = "timeConlictNotication"
    let itemSuccesFullyDeletedFromPersonalView = "itemSuccesFullyDeletedFromPersonalView"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
        self.setUpTableView()
        self.loadTableViewWithBreakouts(self.classesInBreakout)
        self.setUpLabel()

    }
    
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailBreakoutVC.itemSavedAlert), name: itemSuccesfullySaved, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailBreakoutVC.itemDeletedAlert), name: itemSuccesFullyDeleted, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailBreakoutVC.classTimeConflictAlert), name: timeConlictNotication, object: nil)
    }
    
    func unregisterFromNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: self.itemSuccesfullySaved, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: self.itemSuccesFullyDeleted, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: self.timeConlictNotication, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.unregisterFromNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailBreakoutVC.classDeletedInPersonalSchedule), name: self.itemSuccesFullyDeletedFromPersonalView, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.registerForNotifications()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: self.itemSuccesFullyDeletedFromPersonalView, object: nil)
    }
    
    func classDeletedInPersonalSchedule() {
        self.loadTableViewWithBreakouts(self.classesInBreakout)
    }
    
    func itemSavedAlert() {
        let classSavedAlert = UIAlertController(title: "Class Saved", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        classSavedAlert.popoverPresentationController?.sourceView = self.view
        classSavedAlert.popoverPresentationController?.sourceRect = self.view.bounds
        self.navigationController?.presentViewController(classSavedAlert, animated: true, completion: { () -> Void in
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
    
    func itemDeletedAlert() {
        let classDeletedAlert = UIAlertController(title: "Class Deleted", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        classDeletedAlert.popoverPresentationController?.sourceView = self.view
        classDeletedAlert.popoverPresentationController?.sourceRect = self.view.bounds
        // this is the center of the screen currently but it can be any point in the vi
        self.navigationController?.presentViewController(classDeletedAlert, animated: true, completion: { () -> Void in
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
        func classTimeConflictAlert() {
            let timeConflictAlert = UIAlertController(title: "Failed to add Class", message: "There is a time conflic with your schedule", preferredStyle: UIAlertControllerStyle.Alert)
            timeConflictAlert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.navigationController?.presentViewController(timeConflictAlert, animated: true, completion: nil)
        }
    
    func setUpLabel() {
        self.labelBreakoutTime.text = self.stringForLabelBreakoutTime
        self.labelBreakoutTime.backgroundColor = UIColor.clearColor()
    }
    
    func setBackgroundImageView() {
       // self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        //self.view.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
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
