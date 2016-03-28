//
//  ClassScheduled+CoreDataProperties.swift
//  
//
//  Created by Gamaliel Tellez on 3/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ClassScheduled {

    @NSManaged var isMandatory: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var breakOut: Breakout?
    @NSManaged var presentation: Presentation?
    @NSManaged var scheduleItem: ScheduleItem?
    @NSManaged var speaker: Speaker?

}
