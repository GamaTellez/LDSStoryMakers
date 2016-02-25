//
//  Speaker+CoreDataProperties.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/25/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Speaker {

    @NSManaged var speakerBio: String?
    @NSManaged var speakerId: NSNumber?
    @NSManaged var speakerName: String?
    @NSManaged var classScheduled: ClassScheduled?

}
