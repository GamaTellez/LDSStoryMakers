//
//  Breakout+CoreDataProperties.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/23/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
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

}
