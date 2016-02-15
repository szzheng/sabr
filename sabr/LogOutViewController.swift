//
//  LogOutViewController.swift
//  sabr
//
//  Created by Steven Zheng on 1/24/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class LogOutViewController: UIViewController {
    
    var currentUser: PFUser!
    var parentView: UITabBarController!

    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBarHidden = true
        
        
        currentUser = PFUser.currentUser()

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
