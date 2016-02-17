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
    
    init(arrayWithInfoDictionaries:NSArray) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        var sTime = ""
        var eTime = ""
        
        if let dictiWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let id = dictiWithBreakoutID.objectForKey("v") as? String {
                self.breakoutId = id
            }
        }
       
        if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? NSDictionary {
          if let stringStartTime = dictionayWithBreakoutStartTime.objectForKey("f") as? String {
                sTime = stringStartTime
            }
        }
        if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? NSDictionary {
            if let stringEndTime = dictionaryWithBreakoutEndTime.objectForKey("f") as? String {
                eTime = stringEndTime
            }
        }
        if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
            if let dayDate = breakoutDayDate.objectForKey("f") as? String {
                let fullStartTimeString = dayDate + " " + sTime
                //.print(fullStartTimeString)
                if let startDate = dateFormatter.dateFromString(fullStartTimeString) {
                    self.breakoutStartTime = startDate
                   // print(NSDateFormatter.localizedStringFromDate(startDate, dateStyle: .FullStyle, timeStyle: .FullStyle))
                }
                let fullEndTimeString = dayDate + " " + eTime
                if let endDate = dateFormatter.dateFromString(fullEndTimeString) {
                    self.breakputEndtime = endDate
                    //print(NSDateFormatter.localizedStringFromDate(endDate, dateStyle: .FullStyle, timeStyle: .FullStyle))
                }
            }
        }
    }
}
