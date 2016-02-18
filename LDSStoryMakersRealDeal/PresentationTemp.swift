//
//  PresentationTemp.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class PresentationTemp: NSObject {
    var presentationID:Int?
    var presentationTitle:String?
    var presentationDescription:String?
    var presentationSpeaker:String?
    var presentationSpeakerId:Int?
    var isIntensive:Bool?
    var keyNote:Bool?
    var sectionId:Int?

    init(presentationInfoArray:NSArray) {
        if let idDictionary = presentationInfoArray[0] as? NSDictionary {
            if let id = idDictionary.objectForKey("v") as? Int {
                self.presentationID = id
            }
        }
        if let titleDictionary = presentationInfoArray[1] as? NSDictionary {
            if let title = titleDictionary.objectForKey("v") as? String {
                self.presentationTitle = title
            }
        }
        if let descriptionDictionary = presentationInfoArray[2] as? NSDictionary {
            if let descript = descriptionDictionary.objectForKey("v") as? String {
                self.presentationDescription = descript
            }
        }
        if let speakerDictionary = presentationInfoArray[3] as? NSDictionary {
            if let speaker = speakerDictionary.objectForKey("v") as? String {
                self.presentationSpeaker = speaker
            }
        }
        if let speakerIdDictionary =  presentationInfoArray[4] as? NSDictionary {
            if let speakerId = speakerIdDictionary.objectForKey("v") as? Int  {
                self.presentationSpeakerId = speakerId
            }
        }
        if let presentationKindDictionaty = presentationInfoArray[5] as? NSDictionary {
            if let kind = presentationKindDictionaty.objectForKey("v") as? String {
                if kind == "Yes" {
                    self.isIntensive = true
                } else {
                    self.isIntensive = false
                }
            }
        }
        if let presentationSection = presentationInfoArray[6] as? NSDictionary {
            if let sect = presentationSection.objectForKey("v") as? Int {
                self.sectionId = sect
            }
        }
    }

}

