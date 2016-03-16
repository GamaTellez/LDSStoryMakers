//
//  SpeakerBioView.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/25/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerBioView: UIViewController, UITextViewDelegate {

    @IBOutlet var speakerNameLabel: UILabel!
   // @IBOutlet var fillerLabel: UILabel!
    @IBOutlet var speakerImageView: UIImageView!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backGroundImage: UIImageView!
    
    var speakerSelected:Speaker?
    var speakerPhotoData:NSData?
    let failedToFetchTheSpeakerImage = "failedToFetchTheSpeakerImage"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.setViewContent()
        self.setBackgroundImageView()
        self.registerForNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeObserverFromNotifications()
    }
    
    func setUpViews() {
        //self.fillerLabel.backgroundColor = UIColor(red: 0.365, green: 0.365, blue: 0.365, alpha: 1.00)
        self.speakerNameLabel.backgroundColor = UIColor(red: 0.196, green: 0.812, blue: 0.780, alpha: 1.00)
        self.speakerNameLabel.textColor = UIColor.whiteColor()
        self.bioTextView.backgroundColor = UIColor.clearColor()
        self.activityIndicator.startAnimating()
        self.activityIndicator.alpha = 1
    }
    
    func setBackgroundImageView() {
        self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func setViewContent() {
        if let currentSpeaker = self.speakerSelected {
            if let spakerName = currentSpeaker.speakerName {
                self.speakerNameLabel.text = spakerName
            }
            if let speakerBio = currentSpeaker.speakerBio {
                self.bioTextView.text = speakerBio
            }
        }
        if let speakerName = self.speakerSelected?.valueForKey("speakerName") as? String {
            NSURLSessionController.sharedInstance.getSpeakerPhotoData(speakerName, completion: { (photoData) -> Void in
               dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
                self.speakerImageView.image = UIImage(data: photoData)
               })
            })
        }
    }
    
    func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageFetchFailAlert", name: failedToFetchTheSpeakerImage, object: nil)
    }
    
    func imageFetchFailAlert() {
        let imageFailedAlert  = UIAlertController(title: "Error", message: "There was an errror while obtaining the image", preferredStyle: UIAlertControllerStyle.Alert)
        imageFailedAlert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(imageFailedAlert, animated: true) { () -> Void in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.alpha = 0
        }
    }
    
    func removeObserverFromNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
