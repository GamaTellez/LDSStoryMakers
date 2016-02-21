//
//  ManagedObjectsController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/20/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit
import CoreData

class ManagedObjectsController: NSObject {
    static let sharedInstance = ManagedObjectsController()
    let managedContext:NSManagedObjectContext
    
    override init() {
        self.managedContext = ((UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext)!
    }
    
    //Speaker objects
    func createAndSaveBreakoutObjectFromInfoArray(arrayWithInfoDictionaries:NSArray) {
        let newBreakout = NSManagedObject(entity: NSEntityDescription.entityForName("Breakout", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        var dateDay = ""
        
        if let dictWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let id = dictWithBreakoutID.objectForKey("v") as? String {
                newBreakout.setValue(id, forKey: "id")
            }
        }
        
        if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
            if let dayDate = breakoutDayDate.objectForKey("f") as? String {
                dateDay = dayDate
            }
        }
        
        if let dictionayWithBreakoutStartTime = arrayWithInfoDictionaries[1] as? NSDictionary {
            if let stringStartTime = dictionayWithBreakoutStartTime.objectForKey("f") as? String {
                let fullStartTimeString = String(format: "%@ %@", dateDay, stringStartTime)
                if let startDate = dateFormatter.dateFromString(fullStartTimeString) {
                    newBreakout.setValue(startDate, forKey: "startTime")
                } else {
                    print("no startDate")
                }
            }
        }
        
        if let dictionaryWithBreakoutEndTime = arrayWithInfoDictionaries[2] as? NSDictionary {
            if let stringEndTime = dictionaryWithBreakoutEndTime.objectForKey("f") as? String {
                let fullEndTimeString = String(format: "%@ %@", dateDay, stringEndTime)
                if let endDate = dateFormatter.dateFromString(fullEndTimeString) {
                    newBreakout.setValue(endDate, forKey: "endTime")
                } else {
                    print("no end date")
                }
            }
        }
        self.saveToCoreData()
    }
    
    func saveToCoreData() {
        do {
            try self.managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func getAllBreakoutsFromCoreData() -> [AnyObject] {
        var allBreakouts:[AnyObject] = []
        let allbreakoutsRequest = NSFetchRequest(entityName: "Breakout")
       allBreakouts = self.fetchRequestExecuter(allbreakoutsRequest)
        return allBreakouts
    }

    func fetchRequestExecuter(request:NSFetchRequest) ->[AnyObject] {
        var requestResults:[AnyObject] = []
        do {
            requestResults = try self.managedContext.executeFetchRequest(request)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return requestResults
    }
    
    
    
    
    
}
