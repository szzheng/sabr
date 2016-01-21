//
//  ViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/7/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
    
    var errorMessage = "Please try again"
    
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
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func logIn(sender: AnyObject) {
        
        // bad log in info
        if (username.text == "" || password.text == "") {
            displayAlert("Login error", message: "Please enter username and password")
        // good log in info
        } else {
            displayActivityIndicator()
            
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if (user != nil) {
                    
                    // Login successful
                    self.performSegueWithIdentifier("login", sender: self)
                    
                } else {
                    if let errorString = error!.userInfo["error"] as? String {
                        self.errorMessage = errorString
                    }
                    
                    self.displayAlert("Failed login", message: self.errorMessage)
                }
            })
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("signup", sender: self)
        
   
        // bad sign up info
        if (username.text == "" || password.text == "") {

            displayAlert("Error in signup info", message: "Please enter username and password")
            
        // good sign up info
        } else {
            displayActivityIndicator()
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            user.signUpInBackgroundWithBlock({ (sucess, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if (error == nil) {
                    
                    // Signup successful
                    self.performSegueWithIdentifier("signup", sender: self)
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        self.errorMessage = errorString
                    }
                    
                    self.displayAlert("Failed signup", message: self.errorMessage)
                }
            })
        } 

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.username.delegate = self
        self.password.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        //var currentUser = PFUser.currentUser()
        /*
        if currentUser != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

