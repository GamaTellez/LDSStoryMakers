//
//  NSURLSessionController.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/8/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class NSURLSessionController: NSObject {

    static let sharedInstance = NSURLSessionController()
    let generalSpreadSheetLink:String = "https://spreadsheets.google.com/tq?key="
    let defaults = NSUserDefaults.standardUserDefaults()
    let session = NSURLSession.sharedSession()
    //getting spreadsheets keys
    func getKeyLinksFromMainGoogleSpreadSheetToUserDefaults() {
        let mainSpreadSheetKey = "1Y8jMldIfTCOdiirkINlMHJNij1C_ura01Ol40AwZxHs"
        let url = NSURL(string: self.generalSpreadSheetLink + mainSpreadSheetKey)

        let dataTask = self.session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                if let dataString = data {
                    let stringFromData = NSString(data: dataString, encoding: NSUTF8StringEncoding)
                    if let dataString = stringFromData {
                       let jsonObject = self.getJsonObjectFromStringFromData(dataString)
                       self.getLinksAndSaveThemToUSerDefaults(from: jsonObject)
                    }
                }
            }
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
                //print(pureJson)
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
        //print(dictionariesInArray)
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
            print(nameKey)
            print(spreadSheetKey)
            self.defaults.setObject(spreadSheetKey, forKey: nameKey!)
            self.defaults.synchronize()
            }
        }
    
    //getting all speakers
    func getAllSpeakersGoogleSpreadSheet(completion:(result:[Speaker]) ->Void) {
        var allSpeakers:[Speaker] = []
        var url:NSURL?
        if let speakersKey = self.defaults.objectForKey("Speakers") as? String {
            url = NSURL(string: self.generalSpreadSheetLink + speakersKey)
           let dataTask = self.session.dataTaskWithURL(url!, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let dataString = data {
                        let stringFromData = NSString(data: dataString, encoding: NSUTF8StringEncoding)
                      if let jsonObject = self.getJsonObjectFromStringFromData(stringFromData!) as? NSDictionary {
                         allSpeakers = self.getSpeakersFromJson(jsonObject)
                        }
                    }
                }
            completion(result: allSpeakers)
            })
        dataTask.resume()
        } else {
            print("no spreadSheet key available for Speakers")
        }
    }
    
    func getSpeakersFromJson(jsonDictionary:NSDictionary) -> [Speaker] {
        var speakers:[Speaker] = []
        if let tableDictionary = jsonDictionary.objectForKey("table") {
            if let rowsDictArray = tableDictionary.objectForKey("rows") as? NSArray {
                for dict in rowsDictArray {
                    if let arrayWithInfoDictionaries = dict.objectForKey("c") {
                 //       print(arrayWithInfoDictionaries)
                        let newSpeaker = Speaker.init(speakerArray: arrayWithInfoDictionaries as! NSArray)
                        speakers.append(newSpeaker)
                        print(newSpeaker.speakerName)
                    }
                }
            }
        }
     return speakers
    }
    
 }







