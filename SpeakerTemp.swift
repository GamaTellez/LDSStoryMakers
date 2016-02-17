//
//  SpeakerTemp.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/16/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerTemp: NSObject {
    
    var speakerName:String?
    var speakerBio:String?
    
    init(speakerArray:NSArray) {
        if let dictionaryWithName = speakerArray[1] as? NSDictionary {
            if let name = dictionaryWithName.objectForKey("v") as? String {
                self.speakerName = name
            }
        }
        if let dictionaryWithBio = speakerArray[2] as? NSDictionary {
            if let bio = dictionaryWithBio.objectForKey("v") as? String {
                self.speakerBio = bio
            }
        }
    }
}
