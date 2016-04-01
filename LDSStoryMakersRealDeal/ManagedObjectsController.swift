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

    let classFromPersonalScheduleDeleted = "classFromPersonalScheduleDeleted"
    lazy var userDefaults = NSUserDefaults.standardUserDefaults()
//    let privateManagedContext:NSManagedObjectContext
    override init() {
        self.managedContext = ((UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext)!        
    }
    
    //BREAKOUT
    func createAndSaveBreakoutObjectFromInfoArray(arrayWithInfoDictionaries:NSArray) {
       let breakoutAlreadyExist = self.checkIfBreakoutExistsAlready(from: arrayWithInfoDictionaries)
        if breakoutAlreadyExist == true {
            //print("breakout already exist")
        } else {
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
            //print(breakoutIDDict)
            if let breakId = breakoutIDDict.objectForKey("v") as? Int {
                newBreakout.setValue(NSNumber(integer:breakId), forKey: "id")
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
        self.saveToCoreData { (succesful) in
        }
        }
    }
    
    func checkIfBreakoutExistsAlready(from arrayWithObjects:NSArray) -> Bool {
        var exists = false
        if let breakoutsInMemory = self.getAllBreakoutsFromCoreDataByDate() as? [Breakout] {
            for item in breakoutsInMemory {
                if let itemID = item.valueForKey("breakoutID") as? String {
                    if let dictWithBreakoutID = arrayWithObjects[0] as? NSDictionary {
                        if let id = dictWithBreakoutID.objectForKey("v") as? String {
                            if itemID == id {
                                exists = true
                                return exists
                            }
                        }
                    }
                }
            }
        }
        
        return exists
    }
    
    //SCHEDULE item
    func createAndSaveScheduleItemObjectFromArray(arrayWithInfoDicts:NSArray) {
        let scheduleAlreadyExist = self.checkIfScheduleExistsAlready(from: arrayWithInfoDicts)
        if scheduleAlreadyExist == true {
            print("schedule already exists")
        } else {
        let newItemSchedule = NSManagedObject(entity: NSEntityDescription.entityForName("ScheduleItem", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let scheduleIdDictionary = arrayWithInfoDicts[0] as? NSDictionary {
            if let schID = scheduleIdDictionary.objectForKey("v") as? Int {
                newItemSchedule.setValue(NSNumber(integer: schID), forKey: "scheduleId")
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
        self.saveToCoreData { (succesful) in
            
        }
    }
    }
    
    func checkIfScheduleExistsAlready(from arrayWithObjects:NSArray) -> Bool {
        var exists = false
        if let schedulesInMemory = self.getAllSchedulesFRomCoreData() as? [ScheduleItem] {
            for item in schedulesInMemory {
                if let itemID = item.valueForKey("presentationTitle") as? String {
                    if let scheduleIdDictionary = arrayWithObjects[1] as? NSDictionary {
                        if let schID = scheduleIdDictionary.objectForKey("v") as? String {
                            if let scheduleBreakoutDictionary = arrayWithObjects[3] as? NSDictionary {
                                if let schedItemBreakout = scheduleBreakoutDictionary.objectForKey("v") as? Int {
                                    if (itemID == schID  && item.valueForKey("breakout") as? Int == schedItemBreakout) {
                                        exists = true
                                        return exists
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        return exists
    }
    
    //SPEAKERS
    func createAndSaveSpeakerManagedObjectFromArray(arrayWithInfoDicts:NSArray) {
       // print(arrayWithInfoDicts)
        let speakerExistAlready = self.checkIfSpeakerExistsAlready(from: arrayWithInfoDicts)
        if speakerExistAlready == true {
            print("speaker already Exists")
        } else {
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
            if let dictionaryWithImageName = arrayWithInfoDicts[3] as? NSDictionary {
                if let imageName = dictionaryWithImageName.objectForKey("v") as? String {
                    newSpeaker.setValue(imageName, forKey: "imageName")
                }
            }
        self.saveToCoreData { (succesful) in
            
            }
        }
    }
    
    func checkIfSpeakerExistsAlready(from arrayWithObjects:NSArray) -> Bool {
        var exists = false
        if let speakersInMemory = self.getAllSpeakersFromCoreData() as? [Speaker] {
            for item in speakersInMemory {
                if let itemName = item.valueForKey("speakerName") as? String {
                    if let dictionaryWithName = arrayWithObjects[1] as? NSDictionary {
                        if let name = dictionaryWithName.objectForKey("v") as? String {
                            if itemName == name {
                                exists = true
                                return exists
                            }
                        }
                    }
                }
            }
        }
        
        return exists
    }

    
    //PRESENTATIONS
    func createAndSavePresentationManagedObjectFromArrat(arrayWithInfoDicts:NSArray) {
        let presentationAlreadyExist = self.checkIfPresentationsrAlready(from: arrayWithInfoDicts)
        if presentationAlreadyExist == true {
            print("presentation already exists")
        } else {
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
        self.saveToCoreData { (succesful) in
            
            }
        }
    }
    
    func checkIfPresentationsrAlready(from arrayWithObjects:NSArray) -> Bool {
        var exists = false
        if let presentationsInMemory = self.getAllPresentationsFromCoreData() as? [Presentation] {
            for item in presentationsInMemory {
                if let itemID = item.valueForKey("id") as? Int {
                    if let idDictionary = arrayWithObjects[0] as? NSDictionary {
                        if let id = idDictionary.objectForKey("v") as? Int {
                            if itemID == id {
                                exists = true
                                return exists
                            }
                        }
                    }

                }
            }
        }
        
        return exists
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
       self.saveToCoreData { (succesful) in
        
        }
    }

    func saveToCoreData(completion:(succesful:Bool) -> Void) {
        do {
            try self.managedContext.save()
            completion(succesful: true)
           // NSNotificationCenter.defaultCenter().postNotificationName(kitemSuccedsfullySaved, object: nil)
        } catch let error as NSError {
            completion(succesful: false)
            print(error.localizedDescription)
        }
    }
    
    func deleteScheduledClass(classInSchedule:ClassScheduled, completion:(succedeed:Bool)->Void)  {
            self.managedContext.deleteObject(classInSchedule)
            self.saveToCoreData({ (succesful) in
                if (succesful == true) {
                    completion(succedeed: true)
                } else {
                    completion(succedeed: false)
                }
            })
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
        allScheduleItemsRquest.sortDescriptors = [NSSortDescriptor(key: "presentationTitle", ascending: true)]
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
    //////
//create classscheduled from classtoschedule
    func createScheduledClass(from clsToSchedule:ClassToSchedule, completion:(succeeded:Bool)->Void) {
        let newClassScheduled = NSManagedObject(entity: NSEntityDescription.entityForName("ClassScheduled", inManagedObjectContext: self.managedContext)!, insertIntoManagedObjectContext: self.managedContext)
        if let breakoutForClass = clsToSchedule.breakout {
            newClassScheduled.setValue(breakoutForClass, forKey: "breakOut")
            breakoutForClass.setValue(newClassScheduled, forKey: "classScheduled")
            if let breakoutId = breakoutForClass.valueForKey("breakoutID") as? String {
                if breakoutId.characters.count > 2 {
                    newClassScheduled.setValue(NSNumber(bool: true), forKey: "isMandatory")
                } else {
                    newClassScheduled.setValue(NSNumber(bool: false), forKey: "isMandatory")
                }
            }
        }
        if let presentationForClass = clsToSchedule.presentation {
            newClassScheduled.setValue(presentationForClass, forKey: "presentation")
            presentationForClass.setValue(newClassScheduled, forKey: "classedScheduled")
        }
        if let scheduleForClass = clsToSchedule.scheduleItem {
            newClassScheduled.setValue(scheduleForClass, forKey:"scheduleItem")
            scheduleForClass.setValue(newClassScheduled, forKey: "classScheduled")
        }
        if let speakerForClass = clsToSchedule.speaker {
            newClassScheduled.setValue(speakerForClass, forKey: "speaker")
            speakerForClass.setValue(newClassScheduled, forKey: "classScheduled")
        }
        
        if let startTime = clsToSchedule.breakout?.startTime {
            newClassScheduled.setValue(startTime, forKey: "startDate")
        }
        self.saveToCoreData { (succesful) in
            if (succesful == true) {
                completion(succeeded: true)
            } else {
                completion(succeeded: false)
            }
            
        }
    }

    func openFeedBackPageForCourse(course:String) {
            if let courseFeedBackFixedPortion = self.userDefaults.objectForKey("CourseLink") as? String {
                if let courseFeedBeforeName = self.userDefaults.objectForKey("Course Feedback") as? String {
                    if let courseEncodedName = course.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
                        let stringURL = courseFeedBackFixedPortion + courseFeedBeforeName + courseEncodedName
                        if (UIApplication.sharedApplication().openURL(NSURL(string: stringURL)!)) {
                        //    print("opening course feed")
                        } else {
                            print("failed to open course feedback page")
                    }
                }
            }
        }
    }
    
    func openConferenceFeedBack() {
                if let conferenceFeedBack = self.userDefaults.objectForKey("ConferenceLink") as? String {
                    if UIApplication.sharedApplication().openURL(NSURL(string: conferenceFeedBack)!) {
                      //  print("opening conference feedback url")
                    } else {
                        print("failed to open conference feedback")
                    }
            }
    }
    
    func openGeneralCourseFeedBack() {
        if let courseFeedBackLink = self.userDefaults.objectForKey("CourseLink") as? String {
            if UIApplication.sharedApplication().openURL(NSURL(string: courseFeedBackLink)!) {
                print("opening course feedback general")
            } else {
                print("failed to open link")
            }
        }
    }
  
    //delete all data except classes scheduled
    func deleteAllDataAndDownloadAgain(completion:(finished:Bool) -> Void) {
        let allSchedulesRequest = NSFetchRequest(entityName: "ScheduleItem")
        if let schedules = self.fetchRequestExecuter(allSchedulesRequest) as? [ScheduleItem] {
            for item in schedules {
                if item.classScheduled == nil {
                    self.managedContext.deleteObject(item)
                }
            }
        }
        let allPresentationsRequest = NSFetchRequest(entityName: "Presentation")
        if let presentations = self.fetchRequestExecuter(allPresentationsRequest) as? [Presentation] {
            for item in presentations {
                if item.classedScheduled == nil {
                    self.managedContext.deleteObject(item)
                }
            }
        }
        let allSpeakersRequest = NSFetchRequest(entityName: "Speaker")
        if let speakers = self.fetchRequestExecuter(allSpeakersRequest) as? [Speaker] {
            for item in speakers {
                if item.classScheduled == nil {
                    self.managedContext.deleteObject(item)
                }
            }
        }
        let allBreakoutsRequest = NSFetchRequest(entityName: "Breakout")
        if let breakouts = self.fetchRequestExecuter(allBreakoutsRequest) as? [Breakout] {
            for item in breakouts {
                if item.classScheduled == nil {
                    self.managedContext.deleteObject(item)
                }
            }
        }
        do {
        try self.managedContext.save()
            completion(finished: true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}




