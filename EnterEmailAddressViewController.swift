//
//  EnterEmailAddressViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/9/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit
import Parse

var user = PFUser()

class EnterEmailAddressViewController: UIViewController, UITextFieldDelegate {
    
    let temporaryPassword = "abc123"
    var activityIndicator = UIActivityIndicatorView()
    var errorMessage = "Please try again"
    
    @IBOutlet var emailAddress: UITextField!
    
    // submit email
    @IBAction func continueWithEmail(sender: AnyObject) {
        
        // ERROR: blank email
        if (emailAddress.text == "") {
            let alert = UIAlertController(title: "Missing email address", message: "Please fill out email address", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        // Non-blank email
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            // Create new user
            user = PFUser()
            user.username = emailAddress.text
            user.password = temporaryPassword
            user.email = emailAddress.text
            // other fields can be set just like with PFObject
            //user["phone"] = "415-392-0202"
            user["firstname"] = newUser.firstName
            user["lastname"] = newUser.lastName
            
            // Sign user up into Parse database
            user.signUpInBackgroundWithBlock({ (sucess, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                // Signup successful
                if (error == nil) {
                    
                    self.performSegueWithIdentifier("continueWithEmail", sender: self)
                  
                // Signup fail
                } else {
                    
                    // Get fail error
                    if let errorString = error!.userInfo["error"] as? String {
                        self.errorMessage = errorString
                    }
                    
                    // Display error
                    if (self.errorMessage == "username \(self.emailAddress.text!)! already taken") {
                        let alert = UIAlertController(title: "Failed signup", message: "email address \(self.emailAddress.text) already taken", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Failed signup", message:self.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })

        }

    }
    
    // Return to "Enter name" view
    @IBAction func goBack(sender: AnyObject) {
        performSegueWithIdentifier("fromEnterEmailSegueToEnterName", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.emailAddress.delegate = self  // Allow keyboard to return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismiss keyboard when view outside keyboard is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Dismiss keyboard when pressing return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
