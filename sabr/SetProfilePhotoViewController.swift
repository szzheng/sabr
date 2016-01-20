//
//  SetProfilePhotoViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/9/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit

/*
 * View controller to set profile picture
 */
class SetProfilePhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, CropPhotoViewControllerDelegate {

    @IBOutlet var initials: UILabel!            // placeholder initials for profile picture
    @IBOutlet var profilePicture: UIImageView!  // profile picture
    
    var image: UIImage!     // image for profile picture
    
    
    
    /*
     * Action to select photo for profile picture
     */
    @IBAction func choosePhoto(sender: AnyObject) {
        
        let imageChoice = UIImagePickerController()
        imageChoice.delegate = self
        imageChoice.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imageChoice.allowsEditing = false
        
        self.presentViewController(imageChoice, animated: true, completion: nil)
    }
    
    
    /*
     * Pick an image
     * Segues to photo crop scene
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        self.image = image
        
        performSegueWithIdentifier("SegueToCropPhoto", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hi")
        
        initials.text = "SZ"    // placeholder text
        
        
        // Make profile picture circular
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.borderColor = UIColor.darkGrayColor().CGColor
        profilePicture.layer.borderWidth = 0.25
        profilePicture.clipsToBounds = true
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     * Called in CropPhotoViewController to cancel updating profile picture in this view controller
     */
    func cancelPhoto() {
        //profilePicture.image = nil
    }
    
    /*
     * Called in CropPhotoViewController to update profile picture in this view controller
     */
    func sendPhoto(image: UIImage) {
        initials.hidden = true
        self.image = image
        profilePicture.image = self.image
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Segue to crop photo
        if (segue.identifier == "SegueToCropPhoto") {
            
            // Send selected photo to CropPhotoViewController
            let cropPhotoViewController = segue.destinationViewController as! CropPhotoViewController
            cropPhotoViewController.photo = image
            cropPhotoViewController.delegate = self
        }
        
    }


}
