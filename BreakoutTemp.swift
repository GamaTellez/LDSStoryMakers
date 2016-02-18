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
    
    init(from arrayWithInfoDictionaries:NSArray) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        var dDay = ""
        
        if let dictiWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let id = dictiWithBreakoutID.objectForKey("v") as? String {
                self.breakoutId = id
            }
        }
       
        if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
            if let dayDate = breakoutDayDate.objectForKey("f") as? String {
                dDay = dayDate
            }
        }
        
        if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? NSDictionary {
          if let stringStartTime = dictionayWithBreakoutStartTime.objectForKey("f") as? String {
            let fullStartTimeString = String(format: "%@ %@", dDay, stringStartTime)
            if let startDate = dateFormatter.dateFromString(fullStartTimeString) {
                self.breakoutStartTime = startDate
            } else {
                print("no startDate")
                }
            }
        }
        
        if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? NSDictionary {
            if let stringEndTime = dictionaryWithBreakoutEndTime.objectForKey("f") as? String {
                let fullEndTimeString = String(format: "%@ %@", dDay, stringEndTime)
                if let endDate = dateFormatter.dateFromString(fullEndTimeString) {
                    self.breakputEndtime = endDate
                } else {
                    print("no end date")
                }
            }
        }
     
    }
}
