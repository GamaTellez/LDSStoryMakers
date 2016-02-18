//
//  ScheduleItemTemp.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/18/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class ScheduleItemTemp: NSObject {

    var scheduleId:Int?
    var itemPresentationTitle:String?
    var itemPresentationID:Int?
    var itemSection:Int?
    var itemLocation:String?
    var itemIsPresentation:Bool?
    var itemTimeID:Int?
    
    init(from arrayWithInfoDictionaries:NSArray) {
        if let scheduleIdDictionary = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let schID = scheduleIdDictionary.objectForKey("v") as? Int {
                self.scheduleId = schID
            }
        }
        if let itemPresentationTitleDict = arrayWithInfoDictionaries[1] as? NSDictionary {
            if let title = itemPresentationTitleDict.objectForKey("v") as? String {
                self.itemPresentationTitle = title
            }
        }
        if let itemPresentationIdDict = arrayWithInfoDictionaries[2] as? NSDictionary {
            if let idNum = itemPresentationIdDict.objectForKey("v") as? Int {
                self.itemPresentationID = idNum
            }
        }
        if let itemSectionDictionary = arrayWithInfoDictionaries[4] as? NSDictionary {
            if let sect = itemSectionDictionary.objectForKey("v") as? Int {
                self.itemSection = sect
            }
        }
        //not sure what data type is location goinng to be but most likely string
        if let itemLocationDictionary = arrayWithInfoDictionaries[5] as? NSDictionary {
            if let location = itemLocationDictionary.objectForKey("v") as? String {
                self.itemLocation = location
            }
        }
        if let itemIsPresentationDictionaty = arrayWithInfoDictionaries[6] as? NSDictionary {
            if let isPresentation = itemIsPresentationDictionaty.objectForKey("v") as? String {
                if isPresentation == "Yes" {
                    self.itemIsPresentation = true
                } else {
                    self.itemIsPresentation = false
                }
            }
        }
        if let itemTimeIdDictionary = arrayWithInfoDictionaries[7] as? NSDictionary {
            if let timeId = itemTimeIdDictionary.objectForKey("v") as? Int {
                self.itemTimeID = timeId
            }
        }
    }
    
}
