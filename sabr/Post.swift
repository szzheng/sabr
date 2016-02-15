//
//  Post.swift
//  sabr
//
//  Created by Steven Zheng on 2/8/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse

class Post {
    var comment: String!
    var location: CLLocation!
    var photos: [UIImage]!
    
    init() {
        comment = ""
        location = CLLocation()
        photos = []
    }

    func setComment(comment: String) {
        self.comment = comment
    }
    
    func setLocation(location: CLLocation) {
        self.location = location
    }
    
    func setPhotos(photos: [UIImage]) {
        self.photos = photos
    }
    
    func makePFPost() -> PFObject {

        let PFPost = PFObject(className:"Post")
        PFPost["comment"] = comment
        
        return PFPost
    }
}
