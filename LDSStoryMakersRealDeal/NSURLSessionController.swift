//
//  NSURLSessionController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/8/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class NSURLSessionController: NSObject {

    let kallObjectsFromGoogleSpreadSheetsInCoreData = "allObjectsFromGoogleSpreadSheetsInCoreData"
    static let sharedInstance = NSURLSessionController()
    let generalSpreadSheetLink:String = "https://spreadsheets.google.com/tq?key="
    lazy var defaults = NSUserDefaults.standardUserDefaults()
    let session = NSURLSession.sharedSession()
    
    //getting spreadsheets keys
    func getKeyLinksFromMainGoogleSpreadSheetToUserDefaults(completion:(finished:Bool)->Void) {
        let mainSpreadSheetKey = "1Y8jMldIfTCOdiirkINlMHJNij1C_ura01Ol40AwZxHs"
        let url = NSURL(string: self.generalSpreadSheetLink + mainSpreadSheetKey)
        let dataTask = self.session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (error != nil) {
                print(error?.localizedDescription)
                completion(finished: false)
            } else {
                if let dataString = data {
                    let stringFromData = NSString(data: dataString, encoding: NSUTF8StringEncoding)
                    if let dataString = stringFromData {
                       let jsonObject = self.getJsonObjectFromStringFromData(dataString)
                       self.getLinksAndSaveThemToUSerDefaults(from: jsonObject)
                    }
                }
            }
            completion(finished: true)
        }
     dataTask.resume()
    }
    
    func getJsonObjectFromStringFromData(stringFromData:NSString) -> AnyObject {
        let indexOfFirstBrace = stringFromData.rangeOfString("{")
        let firstSubstring = stringFromData.substringFromIndex(indexOfFirstBrace.location)
        let stringObject = NSString(string: firstSubstring)
        let indexOfLastBrace = stringObject.rangeOfString("}", options: .BackwardsSearch)
        let jsonString = stringObject.substringToIndex(indexOfLastBrace.location + 1)
        let jsonDataFromJsonString = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if let dataForJason = jsonDataFromJsonString {
            do {
                let pureJson:AnyObject = try NSJSONSerialization.JSONObjectWithData(dataForJason, options: .MutableContainers)
                return pureJson
            } catch let error as NSError {
                print(error.localizedDescription)
                }
            }
        return 0
        }
    
    func getLinksAndSaveThemToUSerDefaults(from jsonObject:AnyObject) {
        if let jsonDictionary = jsonObject as? NSDictionary {
            if let tableDict = jsonDictionary.objectForKey("table") {
                if let rowsArray = tableDict.objectForKey("rows") {
                    self.saveToUserDefaults(rowsArray)
                }
            }
        }
    }
    
    func saveToUserDefaults(arrayOfDictionaries:AnyObject) {
        let dictionariesInArray = arrayOfDictionaries as! [NSDictionary]
        for dictionary in dictionariesInArray {
            var nameKey:String?
            let dictionaryWithObject = dictionary.objectForKey("c")
            if let dictionaryWithNameKey = dictionaryWithObject![1] {
                if let stringName = dictionaryWithNameKey.objectForKey("v") as? String {
                    nameKey = stringName
                }
            }
            var spreadSheetKey:String?
            if let dictionaryWithSpreadSheetKey = dictionaryWithObject![3] {
                if let stringSpreadSheetKey = dictionaryWithSpreadSheetKey.objectForKey("v") as? String {
                    spreadSheetKey = stringSpreadSheetKey
                    }
                }
            self.defaults.setObject(spreadSheetKey, forKey: nameKey!)
            self.defaults.synchronize()
            }
        }
    ///getting a creating managed objects
    func getDataFromSpreadSheetsAndSaveObjectsToCoreDataFor(spreadsheetName:String)  {
        switch  spreadsheetName {
            case "Breakouts":
                self.createManagedObjectsFromSpreadSheetData(spreadsheetName, completion: { (finished) -> Void in
                })
                break
            case "Schedules":
                self.createManagedObjectsFromSpreadSheetData(spreadsheetName, completion: { (finished) -> Void in
                })
                break
            case "Speakers":
                self.createManagedObjectsFromSpreadSheetData(spreadsheetName, completion: { (finished) -> Void in
                })
                break
            case "Presentations":
                self.createManagedObjectsFromSpreadSheetData(spreadsheetName, completion: { (finished) -> Void in
                })
                break
            case "Notifications":
                self.createManagedObjectsFromSpreadSheetData(spreadsheetName, completion: { (finished) -> Void in
                })
        default:
            print("no such key")
            break
        }
    }
    
    func createManagedObjectsFromSpreadSheetData(entityName:String, completion:(finished:Bool) -> Void) {
        if let spreadSheetkeyForObject = self.defaults.objectForKey(entityName) as? String {
            let url = NSURL(string: self.generalSpreadSheetLink + spreadSheetkeyForObject)
            let dataTask = self.session.dataTaskWithURL(url!, completionHandler: { (data:NSData?, responde:NSURLResponse?, error:NSError? ) -> Void in
                if error ==  nil {
                
                    if let dataString = data {
                            let stringFromData = NSString(data: dataString, encoding: NSUTF8StringEncoding)
                            if let stringWithJason = stringFromData {
                                if let jsonObject = self.getJsonObjectFromStringFromData(stringWithJason) as? NSDictionary {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        self.createManagedObjectsOfEntity(entityName, from: jsonObject)
                                    })
                                } else {
                                print("could not get json object")
                            }
                        }
                }
            } else {
                    print(error?.localizedDescription)
                    completion(finished: false)
                }
            completion(finished: true)
            })
            dataTask.resume()
        } else {
            print("no key has been store for %@", entityName)
        }
    }
    
    func createManagedObjectsOfEntity(entityName:String, from jsonDictionary:NSDictionary) {
        if let tableDictionary = jsonDictionary.objectForKey("table") {
            if let rowsDictArray = tableDictionary.objectForKey("rows") as? NSArray {
                switch entityName {
                case "Breakouts":
                         print("getting breakouts")
                    for dict in rowsDictArray {
                        if let arrayWithInfoDictionaries = dict.objectForKey("c") as? NSArray {
                        ManagedObjectsController.sharedInstance.createAndSaveBreakoutObjectFromInfoArray(arrayWithInfoDictionaries)
                        }
                    }
                    break
                case "Schedules":
                    print("getting schedules")
                    for dict in rowsDictArray {
                        if let arrayWithInfoDictionaries = dict.objectForKey("c") as? NSArray {
                            ManagedObjectsController.sharedInstance.createAndSaveScheduleItemObjectFromArray(arrayWithInfoDictionaries)
                        }
                    }
                    break
                case "Speakers":
                    print("getting speakers")
                    for dict in rowsDictArray {
                        if let arrayWithInfoDictionaries = dict.objectForKey("c") as? NSArray {
                            ManagedObjectsController.sharedInstance.createAndSaveSpeakerManagedObjectFromArray(arrayWithInfoDictionaries)
                        }
                    }
                    break
                case "Presentations":
                    print("getting presentations")
                    for dict in rowsDictArray {
                        if let arrayWithInfoDictionaries = dict.objectForKey("c") as? NSArray {
                            ManagedObjectsController.sharedInstance.createAndSavePresentationManagedObjectFromArrat(arrayWithInfoDictionaries)
                        }
                    }
                    break
                case "Notifications":
                    print("need to implement notidications initn and create managed object")
                default:
                    break
                }
            }
        }
    }



    func getKeysAvailableInUserDefaults() {
        if self.defaults.objectForKey("Schedules") == nil || self.defaults.objectForKey("Speakers") == nil || self.defaults.objectForKey("Presentations") == nil || self.defaults.objectForKey("Breakouts") == nil || self.defaults.objectForKey("Notifications") == nil {
        print("no keys have been store in user defaults")
        let completionBlocksWait = dispatch_group_create()
        dispatch_group_enter(completionBlocksWait)
        NSURLSessionController.sharedInstance.getKeyLinksFromMainGoogleSpreadSheetToUserDefaults({ (finished) -> Void in
            dispatch_group_enter(completionBlocksWait)
            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Schedules", completion: { (finished) -> Void in
                if finished == true {
                    print("schedules downloaded")
                    dispatch_group_leave(completionBlocksWait)
                } else {
                    print("something went wrong while getting the schedules")
                    dispatch_group_leave(completionBlocksWait)
                }
            })
            dispatch_group_enter(completionBlocksWait)
            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Speakers", completion: { (finished) -> Void in
                if finished == true {
                    print("speakers downloaded")
                    dispatch_group_leave(completionBlocksWait)
                } else {
                    print("something went wrong while getting the speakers")
                    dispatch_group_leave(completionBlocksWait)
                    
                }
            })
            dispatch_group_enter(completionBlocksWait)
            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Presentations", completion: { (finished) -> Void in
                if finished == true {
                    print("presentations downloaded")
                    dispatch_group_leave(completionBlocksWait)
                } else {
                    print("something went wrong while getting the presentations")
                    dispatch_group_leave(completionBlocksWait)
                }
            })
            dispatch_group_enter(completionBlocksWait)
            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Breakouts", completion: { (finished) -> Void in
                if finished == true {
                    dispatch_group_leave(completionBlocksWait)
                    print("breakouts downloaded")
                    
                } else {
                    print("something went wrong while getting the breakouts")
                    dispatch_group_leave(completionBlocksWait)
                }
            })
            dispatch_group_enter(completionBlocksWait)
            NSURLSessionController.sharedInstance.createManagedObjectsFromSpreadSheetData("Notifications", completion: { (finished) -> Void in
                if finished == true {
                    print("notifications downloaded")
                    dispatch_group_leave(completionBlocksWait)
                } else {
                    print("something went wrong while getting the notifications")
                    dispatch_group_leave(completionBlocksWait)
                }
            })
            dispatch_group_leave(completionBlocksWait)
        })
        dispatch_group_notify(completionBlocksWait, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
             NSNotificationCenter.defaultCenter().postNotificationName(self.kallObjectsFromGoogleSpreadSheetsInCoreData, object: nil)
        }
    } else {
        print("all keys stored in nsuserdefaults")
    }
    }
}

