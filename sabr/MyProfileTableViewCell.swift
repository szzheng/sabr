//
//  MyProfileTableViewCell.swift
//  sabr
//
//  Created by Steven Zheng on 1/29/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {

    
    @IBOutlet var profilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Make profile picture circular
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.borderColor = UIColor.darkGrayColor().CGColor
        profilePicture.layer.borderWidth = 0.25
        profilePicture.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
