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
    
    //BREAKOUT
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
    
    //SCHEDULE
    func createAndSaveScheduleItemObjectFromArray(arrayWithInfoDicts:NSArray) {
        let newItemSchedule = NSManagedObject(entity: NSEntityDescription.entityForName("ScheduleItem", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let scheduleIdDictionary = arrayWithInfoDicts[0] as? NSDictionary {
            if let schID = scheduleIdDictionary.objectForKey("v") as? Int {
                newItemSchedule.setValue(NSNumber(integerLiteral: schID), forKey: "scheduleId")
            }
        }
        if let itemPresentationTitleDict = arrayWithInfoDicts[1] as? NSDictionary {
            if let title = itemPresentationTitleDict.objectForKey("v") as? String {
                newItemSchedule.setValue(title, forKey: "presentationTitle")
            }
        }
        if let itemPresentationIdDict = arrayWithInfoDicts[2] as? NSDictionary {
            if let idNum = itemPresentationIdDict.objectForKey("v") as? Int {
                newItemSchedule.setValue(NSNumber(integer: idNum), forKey: "presentationId")
            }
        }
        if let itemSectionDictionary = arrayWithInfoDicts[4] as? NSDictionary {
            if let sect = itemSectionDictionary.objectForKey("v") as? Int {
                newItemSchedule.setValue(sect, forKey: "section")
            }
        }
        //not sure what data type is location goinng to be but most likely string
        if let itemLocationDictionary = arrayWithInfoDicts[5] as? NSDictionary {
            if let location = itemLocationDictionary.objectForKey("v") as? String {
                newItemSchedule.setValue(location, forKey: "location")
            }
        }
        if let itemIsPresentationDictionaty = arrayWithInfoDicts[6] as? NSDictionary {
            if let isPresentation = itemIsPresentationDictionaty.objectForKey("v") as? String {
                if isPresentation == "Yes" {
                    newItemSchedule.setValue(NSNumber(bool: true), forKey: "isPresentation")
                } else {
                    newItemSchedule.setValue(NSNumber(bool: false), forKey: "isPresentation")
                }
            }
        }
        if let itemTimeIdDictionary = arrayWithInfoDicts[7] as? NSDictionary {
            if let timeId = itemTimeIdDictionary.objectForKey("v") as? Int {
                newItemSchedule.setValue(NSNumber(integerLiteral: timeId), forKey: "timeId")
            }
        }
        self.saveToCoreData()
    }
    //SPEAKERS
    func createAndSaveSpeakerManagedObjectFromArray(arrayWithInfoDicts:NSArray) {
        let newSpeaker = NSManagedObject(entity: NSEntityDescription.entityForName("Speaker", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let dictionaryWithName = arrayWithInfoDicts[1] as? NSDictionary {
            if let name = dictionaryWithName.objectForKey("v") as? String {
                newSpeaker.setValue(name, forKey: "speakerName")
            }
        }
        if let dictionaryWithBio = arrayWithInfoDicts[2] as? NSDictionary {
            if let bio = dictionaryWithBio.objectForKey("v") as? String {
                newSpeaker.setValue(bio, forKey: "speakerBio")
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
    //FETC REQUESTS
    func getAllBreakoutsFromCoreData() -> [AnyObject] {
        let allbreakoutsRequest = NSFetchRequest(entityName: "Breakout")
       return self.fetchRequestExecuter(allbreakoutsRequest)
    }

    func getAllSchedulesFRomCoreData() -> [AnyObject] {
        let allScheduleItemsRquest = NSFetchRequest(entityName: "ScheduleItem")
        return self.fetchRequestExecuter(allScheduleItemsRquest)
    }
    
    func getAllSpeakersFromCoreData() -> [AnyObject] {
        let allSpeakersRequest = NSFetchRequest(entityName: "Speaker")
        return self.fetchRequestExecuter(allSpeakersRequest)
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
