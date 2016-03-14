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
    let kitemSuccedsfullySaved = "itemSuccesfullySaved"
    let itemSuccesFullyDeleted = "itemSuccesFullyDeleted"
    let classFromPersonalScheduleDeleted = "classFromPersonalScheduleDeleted"

    
    lazy var userDefaults = NSUserDefaults.standardUserDefaults()
    
//    let privateManagedContext:NSManagedObjectContext
    
    override init() {
        self.managedContext = ((UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext)!
//        self.privateManagedContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
//        self.privateManagedContext.parentContext = self.managedContext
//        self.privateManagedContext.persistentStoreCoordinator = self.managedContext.persistentStoreCoordinator
        
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
    
    //NOTIFICATIONS
    func createAndSaveNotificationsFromArray(arrayWithInfoDict:NSArray) {
        let newNotification = NSManagedObject(entity: NSEntityDescription.entityForName("Notification", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let idDictionary = arrayWithInfoDict[0] as? NSDictionary {
           if let notificationID = idDictionary.objectForKey("v") as? Int {
             newNotification.setValue(notificationID, forKey: "notificationID")
            }
        }
        if let notificationInfoDict = arrayWithInfoDict[1] as? NSDictionary {
            if let notificationDetails = notificationInfoDict.objectForKey("v") as? String {
                newNotification.setValue(notificationDetails, forKey: "notificationInfo")
            }
        }
        self.saveToCoreData()
    }

    func saveToCoreData() {
        do {
            try self.managedContext.save()
            NSNotificationCenter.defaultCenter().postNotificationName(kitemSuccedsfullySaved, object: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteScheduledClass(classInSchedule:ClassScheduled, fromView:String)  {
        switch fromView {
        case "conferenceSchedule":
            self.managedContext.deleteObject(classInSchedule)
            NSNotificationCenter.defaultCenter().postNotificationName(itemSuccesFullyDeleted, object: nil)
            break
        case "personalSchedule":
            self.managedContext.deleteObject(classInSchedule)
            NSNotificationCenter.defaultCenter().postNotificationName(classFromPersonalScheduleDeleted, object: nil)
        default:
       
        break
        }
        
    }
    //FETC REQUESTS
    
    func getAllScheduledClasses() -> [AnyObject] {
        let allScheduledClassesRequest = NSFetchRequest(entityName: "ClassScheduled")
        allScheduledClassesRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
       return self.fetchRequestExecuter(allScheduledClassesRequest)
        
    }
    
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
    
    //most recent for most recent one, and all for all
    func getNotification(notificationWanted:String) -> [AnyObject] {
        let notificationRequest = NSFetchRequest(entityName: "Notification")
        notificationRequest.sortDescriptors = [NSSortDescriptor(key: "notificationID", ascending: true)]
        switch (notificationWanted) {
            case "mostRecent":
                notificationRequest.fetchLimit = 1
                return self.fetchRequestExecuter(notificationRequest)
            default:
                return self.fetchRequestExecuter(notificationRequest)
        }
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
    
    
    
    //MAndatory breakouts for personal schedule
    func getMandatoryClassesForSchedule() -> [ClassToSchedule] {
        var classesToSchedule:[ClassToSchedule] = []
            var mandatoryBreakouts:[Breakout] = []
            if let allBreakouts = self.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
               mandatoryBreakouts = self.getMandatoryClassesToAttend(from: allBreakouts)
                classesToSchedule = self.createClassToScheduleObjects(from: mandatoryBreakouts)
            }
        
    return classesToSchedule
    }
    
    func getMandatoryClassesToAttend(from allBreakouts:[Breakout]) -> [Breakout] {
        var mandatoryOnes:[Breakout] = []
        for bkout in allBreakouts {
            if let idbkout = bkout.breakoutID {
                if idbkout.characters.count > 2 {
                    mandatoryOnes.append(bkout)
                }
            }
        }
        return mandatoryOnes
    }
    
    func createClassToScheduleObjects(from mandatoryBreakouts:[Breakout]) -> [ClassToSchedule] {
        var allClasses:[ClassToSchedule] = []
        for item in mandatoryBreakouts {
            let classObject = ClassToSchedule()
            classObject.breakout = item
            
            if let allScheduleItems = ManagedObjectsController.sharedInstance.getAllSchedulesFRomCoreData() as? [ScheduleItem] {
                if let itemBreakoutId = item.breakoutID {
                    for itemSchedule in allScheduleItems {
                        if itemBreakoutId == itemSchedule.presentationTitle {
                            classObject.scheduleItem = itemSchedule
                        }
                    }
                }
            }
            if let allPresentations = ManagedObjectsController.sharedInstance.getAllPresentationsFromCoreData() as? [Presentation] {
                if let title = item.breakoutID {
                    for presentation in allPresentations {
                        if title == presentation.title {
                            classObject.presentation = presentation
                        }
                    }
                }
            }
            if let allSpeakers = ManagedObjectsController.sharedInstance.getAllSpeakersFromCoreData() as? [Speaker] {
                if let speakerId = classObject.presentation?.speakerId {
                    for speak in allSpeakers {
                        if speakerId.integerValue == speak.speakerId?.integerValue {
                            classObject.speaker = speak
                        }
                    }
                }
            }
            allClasses.append(classObject)
        }
        return allClasses
    }
    
//create classscheduled from classtoschedule
    func createScheduledClass(from clsToSchedule:ClassToSchedule) {
        let newClassScheduled = NSManagedObject(entity: NSEntityDescription.entityForName("ClassScheduled", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let breakoutForClass = clsToSchedule.breakout {
            newClassScheduled.setValue(breakoutForClass, forKey: "breakOut")
        }
        if let presentationForClass = clsToSchedule.presentation {
            newClassScheduled.setValue(presentationForClass, forKey: "presentation")
        }
        if let scheduleForClass = clsToSchedule.scheduleItem {
            newClassScheduled.setValue(scheduleForClass, forKey:"scheduleItem")
        }
        if let speakerForClass = clsToSchedule.speaker {
            newClassScheduled.setValue(speakerForClass, forKey: "speaker")
        }
        
        if let startTime = clsToSchedule.breakout?.startTime {
            newClassScheduled.setValue(startTime, forKey: "startDate")
        }
        self.saveToCoreData()
    }
    
    
    
}
