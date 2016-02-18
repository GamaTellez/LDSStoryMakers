//
//  ViewController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/8/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSURLSessionController.sharedInstance.getAllSpeakersGoogleSpreadSheet { (result) -> Void in
            print("speakers")
            print(result.count)
        }
        NSURLSessionController.sharedInstance.getAllPresentationsFromGoogleSpreadSheet { (result) -> Void in
            print("presentations")
            print(result.count)
        }
         NSURLSessionController.sharedInstance.getAllBreakoutsFromGoogleSpreadSheet { (result) -> Void in
            print("breakouts")
            print(result.count)
        }
           NSURLSessionController.sharedInstance.getAllSchedulesFromGooglrSpreadSheet { (result) -> Void in
            print("schedules")
            print(result.count)
        }
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }

}
