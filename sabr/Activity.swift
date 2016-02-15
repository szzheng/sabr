//
//  Activity.swift
//  sabr
//
//  Created by Steven Zheng on 2/12/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import Foundation
import Parse

class Activity {
    
    
    var comment: String!
    var photo: UIImage!
    var date: String!
    var time: Double!
    var location: String!
    var user: PFUser!
    
    
    init (text: String, image: UIImage, user: PFUser) {
        
        // Set comment
        comment = text
        
        // Set photo
        photo = image
        
        // Set date
        let currentDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .ShortStyle
        date = formatter.stringFromDate(currentDate)
        
        // Set time
        time = NSDate().timeIntervalSince1970 * 1000
        
        // Set location
        
        // Set user
        self.user = user
        
        
    }
    
    func getParseObject() -> PFObject {
        let PFActivity = PFObject(className: "Activity")
        
        PFActivity["comment"] = comment
        PFActivity["date"] = date
        PFActivity["time"] = time
        PFActivity["location"] = "Test location"
        
        let imageData = UIImageJPEGRepresentation(photo, 0.50)
        let parseImageFile = PFFile(name: "uploaded_photo.jpeg", data: imageData!)
        PFActivity["photo"] = parseImageFile
        
        PFActivity["createdBy"] = user
        
        return PFActivity
    }
    
    
    
    
}