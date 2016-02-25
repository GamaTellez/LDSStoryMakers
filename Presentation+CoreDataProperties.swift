//
//  Presentation+CoreDataProperties.swift
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

extension Presentation {

    @NSManaged var id: NSNumber?
    @NSManaged var isIntensive: NSNumber?
    @NSManaged var keyNote: NSNumber?
    @NSManaged var presentationDescription: String?
    @NSManaged var sectionId: NSNumber?
    @NSManaged var speakerId: NSNumber?
    @NSManaged var speakerName: String?
    @NSManaged var title: String?
    @NSManaged var classedScheduled: ClassScheduled?

}
