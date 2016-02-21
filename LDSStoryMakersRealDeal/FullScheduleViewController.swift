//
//  FullScheduleViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/19/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class FullScheduleViewController: UIViewController {

    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var segmentedController: UISegmentedControl!

    
    override func viewDidLoad() {
        self.setViewControllerBackgroundImage()
        self.getAllBreakouts()
    }
    
    func getAllBreakouts() -> [Breakout] {
        var allBreakouts:[Breakout] = []
        if let breakouts = ManagedObjectsController.sharedInstance.getAllBreakoutsFromCoreData() as? [Breakout] {
            allBreakouts = breakouts
        }
        for timeBreakout in allBreakouts {
            print(timeBreakout.id)
        }
        
        return allBreakouts
    }
    
    func setViewControllerBackgroundImage() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func segementedControllerTapped(sender: AnyObject) {
        
    }

    
}
