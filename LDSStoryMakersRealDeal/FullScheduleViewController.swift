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
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        self.setViewControllerBackgroundImage()
        
    }
    
    func setViewControllerBackgroundImage() {
        self.backGroundImageView.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func segementedControllerTapped(sender: AnyObject) {
        
    }

    
}
