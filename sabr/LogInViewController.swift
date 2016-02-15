//
//  ViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/7/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var user: PFUser!
    
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
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    
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
        
   
        performSegueWithIdentifier("signUpSegue", sender: self)

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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "signUpSegue") {
            let nextView = segue.destinationViewController as! SignUpViewController
            nextView.newPFUser = user
        }
    }

}

