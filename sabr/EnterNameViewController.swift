//
//  EnterNameViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/8/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit

class EnterNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!

    // submit name
    @IBAction func continueWithName(sender: AnyObject) {

        // ERROR: blank name field(s)
        if (firstName.text == "" || lastName.text == "") {
            let alert = UIAlertController(title: "Missing name field(s)", message: "Please fill out both first and last names", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        // Good name fields
        } else {
            newUser.setName(firstName.text!, lastName: lastName.text!)
            performSegueWithIdentifier("fromEnterNameSegueToEnterEmail", sender: self)
        }

    }
    
    // Return to login screen
    @IBAction func goBack(sender: AnyObject) {
        performSegueWithIdentifier("fromEnterNameSegueToLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Allow keyboard to return
        self.firstName.delegate = self
        self.lastName.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Allow keyboard to return if outside keyboard is pressed
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Allow keyboard to return if return key is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
