//
//  ScheduleItem+CoreDataProperties.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/20/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ScheduleItem {

    @NSManaged var scheduleId: NSNumber?
    @NSManaged var presentationTitle: String?
    @NSManaged var presentationId: NSNumber?
    @NSManaged var section: NSNumber?
    @NSManaged var location: String?
    @NSManaged var isPresentation: NSNumber?
    @NSManaged var timeId: NSNumber?
    @NSManaged var day: NSManagedObject?

}
