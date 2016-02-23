//
//  DetailBreakoutVC.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class DetailBreakoutVC: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backGroundImage: UIImageView!
    
    var tableViewDataSource = DetailBreakoutDataSource()
    var classesInBreakout:[Class] = []
    let scheduleItemCellID = "scheduleItemCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
        self.setUpTableView()
        self.loadTableViewWithBreakouts(self.classesInBreakout)
    }
    
    func setBackgroundImageView() {
        self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }

    func setUpTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self.tableViewDataSource
    }
    func loadTableViewWithBreakouts(allClassesPos:[Class]) {
        self.tableViewDataSource.updateClassesArray(from: allClassesPos)
        self.tableView.reloadData()
    }
    
//    func getPresentationFromItemScheduleName(items:[ScheduleItem]) -> [Presentation] {
//        var breakoutsPresentation:[Presentation] = []
//        if let allPresentations = ManagedObjectsController.sharedInstance.getAllPresentationsFromCoreData() as? [Presentation] {
//            for itemSchedule in items {
//                for pres in allPresentations {
//                    if itemSchedule.presentationTitle == pres.title {
//                        breakoutsPresentation.append(pres)
//                        break
//                    }
//                }
//            }
//        } else {
//            print("could find presenations")
//        }
//        return breakoutsPresentation
//    }

}
