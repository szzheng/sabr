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
    
    @IBAction func continueWithName(sender: AnyObject) {

        if (firstName.text == "" || lastName.text == "") {
            let alert = UIAlertController(title: "Missing name field(s)", message: "Please fill out both first and last names", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            newUser.setName(firstName.text!, lastName: lastName.text!)
            performSegueWithIdentifier("fromEnterNameSegueToEnterEmail", sender: self)
        }

    }
    
    @IBAction func goBack(sender: AnyObject) {
        performSegueWithIdentifier("fromEnterNameSegueToLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
