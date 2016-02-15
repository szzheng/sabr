//
//  MeViewController.swift
//  sabr
//
//  Created by Steven Zheng on 1/24/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit
import Parse

class MeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var initials: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var currentUser: PFUser!
    
    var options = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = self.view.backgroundColor
        navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        
        currentUser = PFUser.currentUser()
        initials.hidden = true
        loadMyProfile()
        loadOptions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadOptions() {

        
        let option1 = Option(name: "My Profile")!
        let option2 = Option(name: "Friends")!
        let option3 = Option(name: "Groups")!
        let option4 = Option(name: "Settings")!
        let option5 = Option(name: "Log Out")!
     
        options += [option1, option2, option3, option4, option5]

    }
    
    func loadMyProfile() {
        let image = currentUser["profilePicture"] as! PFFile
        let firstName = currentUser["firstname"] as! String
        let lastName = currentUser["lastname"] as! String
        image.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            if (error == nil) {
                self.picture.image = UIImage(data:imageData!)
                self.initials.hidden = true
            } else {
                let index = firstName.startIndex
                self.initials.text = String(firstName[index]).capitalizedString + String(lastName[index]).capitalizedString
                self.initials.hidden = false
            }
        }
        
        name.text = firstName + " " + lastName
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MeCell
        
        // Configure the cell...
        let option = options[indexPath.row]
        cell.option.text = option.name
  
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(options.count)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MeCell
        
        
        switch (cell.option.text!) {
        case ("My Profile"):
            print("My Profile")
            performSegueWithIdentifier("segueToPage", sender: self)
        case ("Friends"):
            print("Friends")
        case("Groups"):
            print("Groups")
        case("Settings"):
            print("Settings")
        case ("Log Out"):
            PFUser.logOut()
            self.navigationController!.popToRootViewControllerAnimated(true)
            print("Log Out")
        default:
            print("Default")
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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
