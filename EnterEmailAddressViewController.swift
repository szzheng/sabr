//
//  EnterEmailAddressViewController.swift
//  sabr
//
//  Created by Steven Zheng on 11/9/15.
//  Copyright © 2015 sabr. All rights reserved.
//

import UIKit

class EnterEmailAddressViewController: UIViewController {

    @IBOutlet var emailAddress: UITextField!
    @IBAction func continueWithEmail(sender: AnyObject) {
        
        if (emailAddress.text == "") {
            let alert = UIAlertController(title: "Missing email address", message: "Please fill out email address", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            // continue with email successful
        }

    }
    @IBAction func goBack(sender: AnyObject) {
        performSegueWithIdentifier("fromEnterEmailSegueToEnterName", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
