//
//  ActivityCollectionViewCell.swift
//  sabr
//
//  Created by Steven Zheng on 2/14/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profilePicture: ProfilePicture!
    @IBOutlet var name: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var comment: UILabel!
    @IBOutlet var uploadedPicture: UIImageView!
    @IBOutlet var date: UILabel!
}
