//
//  YourGroupsCVCell.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/6/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class YourGroupsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var image: UIImage! {  // if you don't bang this we have to do initializer
        didSet {
            
            updateViews()
            
            //self.setNeedsLayout()   // rotation of device
        }
    }
    var name: String?

    
    
    private func updateViews() {
        
        imageView.image = image
        nameLabel.text = name
    }
}
