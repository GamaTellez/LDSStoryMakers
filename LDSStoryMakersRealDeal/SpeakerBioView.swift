//
//  SpeakerBioView.swift
//  LDSStoryMakersRealDeal
//
//  Created by Gamaliel Tellez on 2/25/16.
//  Copyright © 2016 Gamaliel Tellez. All rights reserved.
//

import UIKit

class SpeakerBioView: UIViewController, UITextViewDelegate {

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
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeObserverFromNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            let desiredOffset = CGPoint(x: 0, y: -self.bioTextView.contentInset.top)
            self.bioTextView.setContentOffset(desiredOffset, animated: false)
        })
    }
    
    func setUpViews() {
        self.bioTextView.backgroundColor = UIColor.clearColor()
        self.bioTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.bioTextView.textAlignment = NSTextAlignment.Center
        self.activityIndicator.startAnimating()
        self.activityIndicator.alpha = 1
        self.view.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1.00)
    }
    
    func setBackgroundImageView() {
      //  self.backGroundImage.image = UIImage(named: "white-paper-textureBackground")
        //self.view.backgroundColor = UIColor.clearColor()

    }
    
    func setViewContent() {
        if let currentSpeaker = self.speakerSelected {
            if let spakerName = currentSpeaker.speakerName {
                self.title = spakerName
            }
            if let speakerBio = currentSpeaker.speakerBio {
//                let style = NSMutableParagraphStyle()
//                style.lineSpacing = 20
//                style.alignment = NSTextAlignment.Justified
//                self.bioTextView.attributedText = NSAttributedString(string: speakerBio, attributes: [NSParagraphStyleAttributeName: style])
                self.bioTextView.text = speakerBio
                //font size 18
            }
        }
        if let speakerName = self.speakerSelected?.valueForKey("imageName") as? String {
            NSURLSessionController.sharedInstance.getSpeakerPhotoData(speakerName, completion: { (photoData) -> Void in
               dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let imageData = photoData {
                    self.speakerImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                } else {
                    self.imageFetchFailAlert()
                }
               })
            })
        }
    }
    
//    func registerForNotifications() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SpeakerBioView.imageFetchFailAlert), name: failedToFetchTheSpeakerImage, object: nil)
//    }
    
    func imageFetchFailAlert() {
        let imageFailedAlert  = UIAlertController(title: "Error", message: "We apologize, there is no image available", preferredStyle: UIAlertControllerStyle.Alert)
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
}
