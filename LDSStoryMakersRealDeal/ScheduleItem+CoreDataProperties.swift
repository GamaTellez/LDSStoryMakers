//
//  ScheduleItem+CoreDataProperties.swift
//  
//
//  Created by Gamaliel Tellez on 3/30/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ScheduleItem {

    @NSManaged var breakout: NSNumber?
    @NSManaged var isPresentation: NSNumber?
    @NSManaged var location: String?
    @NSManaged var presentationId: NSNumber?
    @NSManaged var presentationTitle: String?
    @NSManaged var scheduleId: NSNumber?
    @NSManaged var section: NSNumber?
    @NSManaged var timeId: NSNumber?
    @NSManaged var classScheduled: ClassScheduled?

}
