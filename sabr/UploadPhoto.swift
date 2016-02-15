//
//  UploadPhoto.swift
//  sabr
//
//  Created by Steven Zheng on 2/13/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import Foundation
import UIKit

class UploadPhoto: UIViewController, UIImagePickerControllerDelegate {
    
    var image: UIImage!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        self.image = image
    }
}