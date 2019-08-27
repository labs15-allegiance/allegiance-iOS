//
//  GroupsExistViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupsExistViewController: UIViewController {
    
    @IBOutlet weak var groupsFoundLabel: UILabel!
    var favoriteTeam: String?
    var zipcode: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    
    func updateViews() {
        
        guard let userTeamEntry = favoriteTeam else {print("user entered nil for group search, segue back to previous view?"); return}
        groupsFoundLabel.text = "Check out some \(userTeamEntry) groups near you!"
    }
   
    // not sure this is even needed given the button can be made to segue to Create Groups controller via interface builder drag/drop
    @IBAction func createGroupButton(_ sender: Any) {
        
    }
    
}
