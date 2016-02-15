//
//  InfoViewController.swift
//  sabr
//
//  Created by Steven Zheng on 2/1/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class InfoViewController: UIViewController, InfoEditViewControllerDelegate {

    @IBOutlet var emailAddress: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var birthday: UILabel!
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var name: UILabel!
    @IBOutlet var initials: UILabel!
    @IBOutlet var profilePicture: ProfilePicture!
    
    var currentUser: PFUser!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBarHidden = true
        navigationBar.barTintColor = self.view.backgroundColor
        
        
        currentUser = PFUser.currentUser()
        
        loadMyProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func edit(sender: AnyObject) {
        performSegueWithIdentifier("editInfoSegue", sender: self)
    }
    
    func loadMyProfile() {
        let image = currentUser["profilePicture"] as! PFFile
        let firstName = currentUser["firstname"] as! String
        let lastName = currentUser["lastname"] as! String
        image.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if (error == nil) {
                self.profilePicture.image = UIImage(data:imageData!)
                self.initials.hidden = true
            } else {
                let index = firstName.startIndex
                self.initials.text = String(firstName[index]).capitalizedString + String(lastName[index]).capitalizedString
                self.initials.hidden = false
            }
        }
        
        name.text = firstName + " " + lastName
        
    }
    
    func sendData(birthday: String, city: String, phoneNumber: String, emailAddress: String) {
        self.birthday.text = birthday
        self.city.text = city
        self.phoneNumber.text = phoneNumber
        self.emailAddress.text = emailAddress
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destinationViewController as! InfoEditViewController
        
        destination.delegate = self
    }


}
