//
//  DiscoverCVCell.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/8/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class DiscoverCVCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image: UIImage! {  // if you don't bang this we have to do initializer
        didSet {
            
            updateViews()
            
            //self.setNeedsLayout()   // rotation of device
        }
    }
    var name: String?
    var members: String?
    
    
    private func updateViews() {
        
        imageView.image = image
        nameLabel.text = name
        membersLabel.text = members
    }
    
}
