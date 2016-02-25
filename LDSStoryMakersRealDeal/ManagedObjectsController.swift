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
    lazy var userDefaults = NSUserDefaults.standardUserDefaults()
   // let privateManagedContext:NSManagedObjectContext
    
    override init() {
        self.managedContext = ((UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext)!
        //self.privateManagedContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        //self.privateManagedContext.parentContext = self.managedContext
        //self.privateManagedContext.persistentStoreCoordinator = self.managedContext.persistentStoreCoordinator
    }
    
    //BREAKOUT
    func createAndSaveBreakoutObjectFromInfoArray(arrayWithInfoDictionaries:NSArray) {
        let newBreakout = NSManagedObject(entity: NSEntityDescription.entityForName("Breakout", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        var dateDay = ""
        
        if let dictWithBreakoutID = arrayWithInfoDictionaries[0] as? NSDictionary {
            if let id = dictWithBreakoutID.objectForKey("v") as? String {
                newBreakout.setValue(id, forKey: "breakoutID")
            }
        }
        
        if let breakoutDayDate = arrayWithInfoDictionaries[3] as? NSDictionary {
            if let dayDate = breakoutDayDate.objectForKey("f") as? String {
                dateDay = dayDate
            }
        }
        
        if let breakoutIDDict = arrayWithInfoDictionaries[4] as? NSDictionary {
            if let breakId = breakoutIDDict.objectForKey("f") as? String {
                newBreakout.setValue(breakId, forKey: "id")
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
        
        if let itemBreakoutIdDict = arrayWithInfoDicts[3] as? NSDictionary {
            if let idNum = itemBreakoutIdDict.objectForKey("v") as? Int {
                newItemSchedule.setValue(NSNumber(integer: idNum), forKey: "breakout")
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
        
        if let dictionaryWithId = arrayWithInfoDicts[0] as? NSDictionary {
            if let id = dictionaryWithId.objectForKey("v") as? Int {
                newSpeaker.setValue(NSNumber(integer: id), forKey: "speakerId")
            }
        }
        
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
    //PRESENTATIONS
    func createAndSavePresentationManagedObjectFromArrat(arrayWithInfoDicts:NSArray) {
        let newPresentation = NSManagedObject(entity: NSEntityDescription.entityForName("Presentation", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let idDictionary = arrayWithInfoDicts[0] as? NSDictionary {
            if let id = idDictionary.objectForKey("v") as? Int {
                newPresentation.setValue( NSNumber(integerLiteral:id), forKey: "id")
            }
        }
        if let titleDictionary = arrayWithInfoDicts[1] as? NSDictionary {
            if let title = titleDictionary.objectForKey("v") as? String {
                newPresentation.setValue(title, forKey: "title")
            }
        }
        if let descriptionDictionary = arrayWithInfoDicts[2] as? NSDictionary {
            if let descript = descriptionDictionary.objectForKey("v") as? String {
                newPresentation.setValue(descript, forKey: "presentationDescription")
            }
        }
        if let speakerDictionary = arrayWithInfoDicts[3] as? NSDictionary {
            if let speaker = speakerDictionary.objectForKey("v") as? String {
                newPresentation.setValue(speaker, forKey: "speakerName")
            }
        }
        if let speakerIdDictionary =  arrayWithInfoDicts[4] as? NSDictionary {
            if let speakerId = speakerIdDictionary.objectForKey("v") as? Int  {
                newPresentation.setValue(NSNumber(integerLiteral:speakerId), forKey: "speakerId")
            }
        }
        if let presentationKindDictionaty = arrayWithInfoDicts[5] as? NSDictionary {
            if let kind = presentationKindDictionaty.objectForKey("v") as? String {
                if kind == "Yes" {
                    newPresentation.setValue(NSNumber(bool: true), forKey: "isIntensive")
                } else {
                    newPresentation.setValue(NSNumber(bool: false), forKey: "isIntensive")
                }
            }
        }
        if let presentationSection = arrayWithInfoDicts[6] as? NSDictionary {
            if let sect = presentationSection.objectForKey("v") as? Int {
                    newPresentation.setValue(NSNumber(integerLiteral: sect), forKey: "sectionId")
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
    func getAllBreakoutsFromCoreDataByDate() -> [AnyObject] {
        let allbreakoutsRequest = NSFetchRequest(entityName: "Breakout")
        allbreakoutsRequest.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: true)]
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
    
    func getAllPresentationsFromCoreData() -> [AnyObject] {
        let allPresentationsRequest = NSFetchRequest(entityName: "Presentation")
        return fetchRequestExecuter(allPresentationsRequest)
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
    
    
    func createClassScheduledItem(from classPassed:ClassToSchedule, completion:(success:Bool)->Void) {
       // let classToSchedule = NSManagedObject(entity: NSEntityDescription.entityForName("ClassScheduled", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
    }
    
    func createFridayAndSaturday() {
        if (self.userDefaults.objectForKey("fridayAndSaturdayCreated") == nil) {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let friday = NSManagedObject(entity: NSEntityDescription.entityForName("Day", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
            if let fridayDate = formatter.dateFromString("5/6/2016") {
                friday.setValue(fridayDate, forKey: "date")
            }
            let saturday = NSManagedObject(entity: NSEntityDescription.entityForName("Day", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
            if let saturdayDate = formatter.dateFromString("5/7/2016") {
                saturday.setValue(saturdayDate, forKey: "date")
            }
            self.saveToCoreData()
            self.userDefaults.setObject(true, forKey: "fridayAndSaturdayCreated")
            self.userDefaults.synchronize()
        } else {
           // self.getFridayAndSaturdayObjects()
            print("friday and saturday created")
        }
    }
    
    func getFridayAndSaturdayObjects() {
        let daysRequest = NSFetchRequest(entityName: "Day")
        daysRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let array = self.fetchRequestExecuter(daysRequest)
        print(array.count)
    }
    
    
}
