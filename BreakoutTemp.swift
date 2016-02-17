//
//  BreakoutTemp.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class BreakoutTemp: NSObject {
    var breakoutId:String?
    var breakoutStartTime:NSDate?
    var breakputEndtime:NSDate?
    var breakoutDayDate:NSDate?
    
    
    init(arrayWithInfoDictionaries:NSArray) {
        if let dictiWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let id = dictiWithBreakoutID.objectForKey("v") as? String {
                self.breakoutId = id
            }
        }
        if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
            if let dayDate = breakoutDayDate.objectForKey("f") {
                print(dayDate)
            }
        }
        if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? NSDictionary {
            let stringStartTime = dictionayWithBreakoutStartTime.objectForKey("f");
            print(stringStartTime)
        }
    
        if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? NSDictionary {
            let stringEndTime = dictionaryWithBreakoutEndTime.objectForKey("f")
            print(stringEndTime)
        }
    }
}
