//
//  ChoosePasswordViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/9/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit

class ChoosePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var password: UITextField!
    var activityIndicator = UIActivityIndicatorView()
    
    // submit password
    @IBAction func continueWithPassword(sender: AnyObject) {
        
        // ERROR: blank password
        if (password.text == "") {
            let alert = UIAlertController(title: "Missing password", message: "Please fill out password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        // Good Password
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            // Update user password
            user.password = password.text
            
            activityIndicator.stopAnimating()
            
            performSegueWithIdentifier("continueWithPassword", sender: self)
        }
    }
    
    // Return to "Enter email" view, delete the create user from previous email submission
    @IBAction func goBack(sender: AnyObject) {
        user.deleteInBackground()
        performSegueWithIdentifier("fromChoosePasswordSegueToEnterEmail", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Allow keyboard to return
        self.password.delegate = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
