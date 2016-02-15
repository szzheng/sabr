//
//  ProfilePicture.swift
//  sabr
//
//  Created by Steven Zheng on 1/31/16.
//  Copyright © 2016 sabr. All rights reserved.
//

import UIKit

class ProfilePicture: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        // Make profile picture circular
        layer.cornerRadius = layer.frame.size.width/2
        layer.borderColor = UIColor.darkGrayColor().CGColor
        layer.borderWidth = 0.25
        clipsToBounds = true
    }

}
