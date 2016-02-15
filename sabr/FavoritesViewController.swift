//
//  FavoritesViewController.swift
//  sabr
//
//  Created by Steven Zheng on 1/24/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myProfileTableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    var myProfile: User!
    
    var user: PFUser!
    
    var profilePic: UIImage!
    var imageWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBarHidden = true
        
        user = PFUser.currentUser()
        loadMyProfile()
        
        //myProfileTableView.layer.borderWidth = 0.5
        //myProfileTableView.layer.borderColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadMyProfile() {
        let image = user["profilePicture"] as! PFFile
        image.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if (error == nil) {
                self.profilePic = UIImage(data:imageData!)
                self.myProfileTableView.reloadData()
                print("hi")
            } else {
                print("but")
            }
        }

    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyProfileTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyProfileTableViewCell
        imageWidth = cell.profilePicture.frame.width
        
        // Fetches the appropriate meal for the data source layout.
        myProfileTableView.separatorInset = UIEdgeInsetsMake(0, imageWidth, 0, 0)
        
        // Configure the cell...
        cell.profilePicture.image = profilePic
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
