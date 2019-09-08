//
//  GroupsNearYouCVCell.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/8/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupsNearYouCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {  // if you don't bang this we have to do initializer
        didSet {
            self.imageView.image = image
            //self.setNeedsLayout()   // rotation of device
        }
    }
    
    
}
