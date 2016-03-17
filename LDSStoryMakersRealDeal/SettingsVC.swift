//
//  SettingsVC.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 3/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var backGroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImageView()
    }
    
    func setBackgroundImageView() {
        self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }

    func setUpApperanceViews() {
        self.titleLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
    }
}
