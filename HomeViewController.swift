//
//  HomeViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var topLabelBar: UILabel!
    @IBOutlet var notificationLabelBanner: UILabel!
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSURLSessionController.sharedInstance.getDataFromSpreadSheetsAndSaveObjectsToCoreDataFor("Breakouts")
       let allBreakoouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreData()
        print(allBreakoouts.count)
        self.setUpLabelsApperance()
        self.setBackgroundImageView()
        self.setUpTablewView()
    }
    func setBackgroundImageView() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    func setUpTablewView() {
        self.tableView.backgroundColor = UIColor.clearColor()
       
//        if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
//            self.tableView.scrollEnabled = false;
//        }
//        else {
//            self.tableView.scrollEnabled = true;
//        }
    }
    func setUpLabelsApperance() {
        self.topLabelBar.backgroundColor = UIColor.greenColor()
        self.notificationLabelBanner.backgroundColor = UIColor.blueColor()
        self.notificationLabelBanner.layer.borderWidth = 1.0
        self.notificationLabelBanner.layer.cornerRadius = 10
        self.notificationLabelBanner.layer.borderColor = UIColor.blackColor().CGColor
        self.notificationLabelBanner.clipsToBounds = true
    }

    
    
    //tableview delegate methods
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var viewForHeader:UIView = UIView()
        switch section {
        case 1:
            viewForHeader = self.makeViewForTableViewHeaders(withTitle: "Upcoming Class")
            break
        default:
            viewForHeader = self.makeViewForTableViewHeaders(withTitle: "Next Classes")
            break
        }        
        return viewForHeader
    }
    
    func makeViewForTableViewHeaders(withTitle title:String) ->UIView {
        let underLinedAttribute =  [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let underLinedAttributedString = NSAttributedString(string: title, attributes: underLinedAttribute)
        
        let headerSectionView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 20.0))
        headerSectionView.backgroundColor = UIColor.clearColor()
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: headerSectionView.frame.width, height: headerSectionView.frame.height))
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.attributedText = underLinedAttributedString
        headerSectionView.addSubview(headerLabel)
           return headerSectionView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
}
//        NSURLSessionController.sharedInstance.getAllSpeakersGoogleSpreadSheet { (result) -> Void in
//            print("speakers")
//            print(result.count)
//        }
//        NSURLSessionController.sharedInstance.getAllPresentationsFromGoogleSpreadSheet { (result) -> Void in
//            print("presentations")
//            print(result.count)
//        }
//         NSURLSessionController.sharedInstance.getAllBreakoutsFromGoogleSpreadSheet { (result) -> Void in
//            print("breakouts")
//            print(result.count)
//        }
//           NSURLSessionController.sharedInstance.getAllSchedulesFromGooglrSpreadSheet { (result) -> Void in
//            print("schedules")
//            print(result.count)
//        }
