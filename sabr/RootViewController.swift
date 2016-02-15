//
//  RootViewController.swift
//  sabr
//
//  Created by Steven Zheng on 1/24/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //PFUser.logOut()
        var user = PFUser.currentUser()?.username
        
        if (user != nil) {
            print("user found")
            performSegueWithIdentifier("rootToHomeSegue", sender: self)
        } else {
            print("user not found")
            performSegueWithIdentifier("rootToLogInSegue", sender: self)
        }
        
        //performSegueWithIdentifier("rootToLogInSegue", sender: self)
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
