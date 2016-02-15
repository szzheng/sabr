//
//  PostViewController.swift
//  sabr
//
//  Created by Steven Zheng on 2/8/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class PostViewController: UIViewController, UITextViewDelegate {
    
    var currentUser: PFUser! // current user
    
    var newPost: Post!  // new post
    
    // post option


    // user input
    var loc: CLLocation!
    @IBOutlet var comment: UITextView!
    
    // title bar
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let screenWidth = view.frame.width
        //let optionWidth = (screenWidth - 40) / 3
       /*
        album.frame = CGRectMake((screenWidth / 2) - (optionWidth / 2), album.frame.origin.y, optionWidth, optionWidth)
        photo.frame = CGRectMake(album.frame.origin.x - 10 - optionWidth, photo.frame.origin.y, optionWidth, optionWidth)
        map.frame = CGRectMake(album.frame.origin.x + 10 + optionWidth, map.frame.origin.y, optionWidth, optionWidth)
        */
        
        // Do any additional setup after loading the view.
        
        currentUser = PFUser.currentUser()
        
        // hide navigation controlller and configure title navigation bar
        navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBarHidden = true
        
        // Create a new post
        newPost = Post()
        
        self.comment.delegate = self
        
        self.comment.layer.borderWidth = 1
        self.comment.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Done - post
    @IBAction func done(sender: AnyObject) {
        self.view.endEditing(true)
        
        if (comment.text != nil) {
            newPost.setComment(comment.text)
        }
        
        
        // Make PFObject for post
        let newPFPost = newPost.makePFPost()
        
        // Save and submit new post
        newPFPost.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved post")
            } else {
                print("Saved post failed")
            }
        }
        
        if (currentUser["posts"] != nil) {
            var posts = currentUser["posts"] as! [PFObject]
            posts.append(newPFPost)
            currentUser["posts"] = posts
        } else {
            currentUser["posts"] = [newPFPost]
        }
        
        currentUser.saveInBackgroundWithBlock { (success, error) -> Void in
            if (success) {
                print("saved user with post")
            } else {
                print("saved user with post failed")
            }
        }
    }
    
    // Allow keyboard to return if outside of keyboard is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Allow keyboard to return if return key is pressed
    func textFieldShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
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
