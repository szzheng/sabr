//
//  ActivityFeedViewController.swift
//  sabr
//
//  Created by Steven Zheng on 2/14/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class ActivityFeedViewController: NavigatedViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Navigation Bar - Activity Feed
    @IBOutlet var navigationBar: UINavigationBar!
    
    // new activity button
    @IBOutlet var newActivityButton: UIButton!
 
    // activity feed collection view
    @IBOutlet var activityCollectionView: UICollectionView!
    
    let reuseIdentifier = "Activity"
    
    var currentUser: PFUser!
    
    var activities = []
    var currentCell: ActivityCollectionViewCell!
    
    override func viewWillAppear(animated: Bool) {
        let activityQuery = PFQuery(className:"Activity")
        activityQuery.orderByDescending("time")
        if let user = PFUser.currentUser() {
            activityQuery.whereKey("createdBy", equalTo: user)
            activityQuery.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    self.activities = objects!
                    self.activityCollectionView.reloadData()
                    print("data reloaded")
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.barTintColor = self.view.backgroundColor
        
        // Style button
        newActivityButton.layer.cornerRadius = 3
        newActivityButton.layer.borderColor = UIColor.blackColor().CGColor
        newActivityButton.layer.borderWidth = 1
        newActivityButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        // get current user
        currentUser = PFUser.currentUser()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Create a new activity
    @IBAction func newActivity(sender: AnyObject) {
        
        performSegueWithIdentifier("New Activity Segue", sender: self)
        
    }
    
    /* Collection View */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(activities.count)
        return activities.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 3.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10), height: (collectionView.frame.height - 10))
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ActivityCollectionViewCell
        currentCell = cell
        /*
        let activityQuery = PFQuery(className:"Activity")
        if let user = PFUser.currentUser() {
            activityQuery.whereKey("createdBy", equalTo: user)
            activityQuery.orderByDescending("time")

            activityQuery.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    // Configure the cell
                    let PFActivity = objects![indexPath.item] as PFObject
                    PFActivity.fetchIfNeededInBackgroundWithBlock { (activity, error) -> Void in
                        
                        if (error == nil) {
                            let user = activity!["createdBy"] as! PFUser
                            let image = user["profilePicture"] as! PFFile
                            image.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                                if (error == nil) {
                                    cell.profilePicture.image = UIImage(data:imageData!)
                                } else {
                                    print("Error getting image")
                                }
                            }
                            cell.comment.text = activity!["comment"] as! String
                            cell.name.text = (user["firstname"] as! String) + " " + (user["lastname"] as! String)
                            cell.date.text = activity!["date"] as! String
                            cell.location.text = activity!["location"] as! String
                            let photo = activity!["photo"] as! PFFile
                            photo.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                                if (error == nil) {
                                    cell.uploadedPicture.image = UIImage(data:imageData!)
                                } else {
                                    print("Error getting image")
                                }
                            }
                            self.currentCell = cell
                            
                        } else {
                            print("Could not fetch")
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
            return currentCell

        }
        
*/
        let PFActivity = activities[indexPath.item] as! PFObject
        let user = PFActivity["createdBy"] as! PFUser
        let image = user["profilePicture"] as! PFFile
        image.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if (error == nil) {
                cell.profilePicture.image = UIImage(data:imageData!)
            } else {
                print("Error getting image")
            }
        }
        cell.comment.text = PFActivity["comment"] as! String
        cell.name.text = (user["firstname"] as! String) + " " + (user["lastname"] as! String)
        cell.date.text = PFActivity["date"] as! String
        cell.location.text = PFActivity["location"] as! String
        let photo = PFActivity["photo"] as! PFFile
        photo.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if (error == nil) {
                cell.uploadedPicture.image = UIImage(data:imageData!)
            } else {
                print("Error getting image")
            }
        }
        
        return cell
    }
    /* Collection View - End */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
