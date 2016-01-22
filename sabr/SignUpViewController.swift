//
//  SignUpViewController.swift
//  sabr
//
//  Created by Steven Zheng on 1/22/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var newPFUser: PFUser!
    var activityIndicator = UIActivityIndicatorView()
    var errorMessage = "Please try again"
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordConfirm: UITextField!
    
    @IBAction func next(sender: AnyObject) {
        
        // Validate user input
        if (firstName.text == "") {
            displayAlert("Invalid first name", message: "First name cannot be blank")
        } else if (lastName.text == "") {
            displayAlert("Invalid last name", message: "Last name cannot be blank")
        } else if (emailAddress.text == "") {
            displayAlert("Invalid email address", message: "Email address cannot be blank")
        } else if (password.text == "") {
            displayAlert("Invalid password", message: "Password cannot be blank")
        } else if ((passwordConfirm.text == "") || (passwordConfirm.text != password.text)) {
            displayAlert("Invalid password", message: "Passwords must match")
        } else {
            
            displayActivityIndicator()
            
            // Create new user
            newPFUser = PFUser()
            newPFUser.username = emailAddress.text
            newPFUser.password = password.text
            newPFUser.email = emailAddress.text
            // other fields can be set just like with PFObject
            //user["phone"] = "415-392-0202"
            newPFUser["firstname"] = firstName.text
            newPFUser["lastname"] = lastName.text
            
            // Sign user up into Parse database
            newPFUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                // Signup successful
                if (error == nil) {
                    
                    self.performSegueWithIdentifier("setProfilePictureSegue", sender: self)
                    
                    // Signup fail
                } else {
                    
                    // Get fail error
                    if let errorString = error!.userInfo["error"] as? String {
                        self.errorMessage = errorString
                    }
                    
                    // Display error
                    if (self.errorMessage == "username \(self.emailAddress.text!)! already taken") {
                        self.displayAlert("Failed signup", message: "email address \(self.emailAddress.text) already taken")
                    } else {
                        self.displayAlert("Failed signup", message: self.errorMessage)
                    }
                }
            })
        }
        
        
        
    }
    
    
    func displayActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.emailAddress.delegate = self
        self.password.delegate = self
        self.passwordConfirm.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Allow keyboard to return if outside of keyboard is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Allow keyboard to return if return key is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextView = segue.destinationViewController as! SetProfilePhotoViewController
        nextView.user = newPFUser
        nextView.firstName = firstName.text
        nextView.lastName = lastName.text
    }


}
