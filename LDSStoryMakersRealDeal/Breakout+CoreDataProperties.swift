//
//  Breakout+CoreDataProperties.swift
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

extension Breakout {

    @NSManaged var breakoutID: String?
    @NSManaged var endTime: NSDate?
    @NSManaged var id: String?
    @NSManaged var startTime: NSDate?
    @NSManaged var classScheduled: ClassScheduled?

}
