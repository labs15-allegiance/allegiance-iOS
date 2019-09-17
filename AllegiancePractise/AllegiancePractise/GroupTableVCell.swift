//
//  GroupTableVCell.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/16/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupTableVCell: UITableViewCell {


    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var membershipButton: UIButton!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var privacyMembersLabel: UILabel!
    
    var group: Group? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let group = group else { return }   // what is cell equiv. of isViewLoaded?
        if let imageData = group.image {
            let image = UIImage(data: imageData)
            iconImageView.image = image
        }
        groupNameLabel.text = group.groupName
        sloganLabel.text = group.slogan
        privacyMembersLabel.text = "\(group.privacySetting ?? "Public") Group - 2 members"
        
    }
    
    
    
    
}
