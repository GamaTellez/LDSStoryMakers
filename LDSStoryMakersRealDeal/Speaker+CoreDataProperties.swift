//
//  Speaker+CoreDataProperties.swift
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

extension Speaker {

    @NSManaged var speakerBio: String?
    @NSManaged var speakerId: NSNumber?
    @NSManaged var speakerName: String?
    @NSManaged var imageName: String?
    @NSManaged var classScheduled: ClassScheduled?

}
