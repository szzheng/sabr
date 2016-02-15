//
//  InfoEditViewController.swift
//  sabr
//
//  Created by Steven Zheng on 2/6/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

/*
* Used to pass information back to Info page
*/
protocol InfoEditViewControllerDelegate {
    func sendData(birthday: String, city: String, phoneNumber: String, emailAddress: String)  // send the cropped image back to SetProfileViewContrller
}

class InfoEditViewController: UIViewController {

    var delegate:InfoEditViewControllerDelegate!   // Used to pass information back to Info page
    var currentUser: PFUser!
    
    @IBOutlet var birthday: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var emailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = PFUser.currentUser()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: AnyObject) {
        
        
        if (delegate == nil) {
            print("nil");
        } else {
            delegate.sendData(birthday.text!, city: city.text!, phoneNumber: phoneNumber.text!, emailAddress: emailAddress.text!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
