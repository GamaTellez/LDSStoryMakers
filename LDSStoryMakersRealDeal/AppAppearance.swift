//
//  AppAppearance.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/24/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class AppAppearance: NSObject {

    
    class func setAppAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        UITabBar.appearance().barTintColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        UITabBar.appearance().tintColor = UIColor.blackColor()
    }
}
