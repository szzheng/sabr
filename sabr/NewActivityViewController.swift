//
//  NewActivityViewController.swift
//  sabr
//
//  Created by Steven Zheng on 2/14/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class NewActivityViewController: UIViewController, UITextViewDelegate {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var newActivity: UIView!
    @IBOutlet var newActivityText: UITextView!
    
    var currentUser: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.newActivityText.delegate = self
        navigationBar.backgroundColor = view.backgroundColor
        
        // get the current user
        currentUser = PFUser.currentUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Cancel new activity
    @IBAction func cancel(sender: AnyObject) {
        textViewShouldReturn(newActivityText)
        dismissViewControllerAnimated(true) { () -> Void in
            print("Cancel new activity")
        }
    }
    
    // Done making new activity
    @IBAction func done(sender: AnyObject) {
        textViewShouldReturn(newActivityText)
        displayActivityIndicator()
        
        // Create new activity, parse object
        let activity = Activity(text: newActivityText.text, image: UIImage(named: "Siberian Husky.jpg")!, user: currentUser)
        let PFActivity = activity.getParseObject()
        
        PFActivity.saveInBackgroundWithBlock { (success, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if (error != nil) {
                print(" New Activity save error")
            } else {
                print(" Saved activity")
                self.dismissViewControllerAnimated(true) { () -> Void in
                    print("Done new activity")
                    
                }
            }
        }
        
        /*
        // Store activity in user activities array
        if (currentUser["activities"] == nil) {
            currentUser["activities"] = [PFActivity]
            print("First activity")
        } else {
            var currentActivites = currentUser["activities"] as! [PFObject]
            currentActivites.append(PFActivity)
            currentUser["activities"] = currentActivites
            print("Appending new activity")
        }

        print("save in background")
        
        currentUser.saveInBackgroundWithBlock { (success, error) -> Void in
            if (error != nil) {
                print("User save error");
            } else {
            }
        }
        print("saved in background")
*/
        
    }
    
    /* Display Activity Indicator */
    func displayActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    /* Resign text field */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    /* Resign text field - End */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
