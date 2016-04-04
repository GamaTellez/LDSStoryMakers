//
//  Notification+CoreDataProperties.swift
//  
//
//  Created by Gamaliel Tellez on 4/3/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Notification {

    @NSManaged var notificationID: NSNumber?
    @NSManaged var notificationInfo: String?

}
