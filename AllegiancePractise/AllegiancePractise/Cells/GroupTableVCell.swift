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
        
        membershipButtonAppearance()
        guard let group = group else { return }   // what is cell equiv. of isViewLoaded?
        if let imageData = group.image {
            let image = UIImage(data: imageData)
            iconImageView.image = image
        }
        groupNameLabel.text = group.groupName
        sloganLabel.text = group.slogan
        privacyMembersLabel.text = "\(group.privacySetting ?? "Public") Group - 1 member"
        
        // TODO: edit button should be hidden for any user who isn't the Group creator
        // membershipButton must check whether user is a member of the group first, then show the appropriate title. Best to check in Core Data for speed.
        
    }
    
    private func membershipButtonAppearance() {
        membershipButton.layer.borderColor = UIColor.blue.cgColor
        membershipButton.layer.opacity = 0.75
    }
    
    @IBAction func membershipButtonTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if !sender.isSelected {
            
            membershipButton.setTitle("join", for: .normal)
            // subtract 1 from group members count
        
        } else {
            membershipButton.setTitle("member", for: .normal)
            // add 1 to group members count
        }
        
    }
    
    
    @IBAction func editGroupButtonTapped(_ sender: Any) {
        
        //
        
    }
    
    
    
}
