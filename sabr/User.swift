//
//  User.swift
//  sabr
//
//  Created by Steven Zheng on 11/8/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import Foundation
import UIKit

class User {
    var firstName: String
    var lastName: String
    var emailAddress: String
    var profilePicture: UIImage
    
    init() {
        firstName = ""
        lastName = ""
        emailAddress = ""
        profilePicture = UIImage()
    }
    
    func setName (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func setProfilePicture (profilePic: UIImage) {
        profilePicture = profilePic
    }
}
