//
//  GroupsExistViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupsExistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var groupsExistCollectionV: UICollectionView!
    
    @IBOutlet weak var groupsFoundLabel: UILabel!
    var favoriteTeam: String?
    var zipcode: Int?
    var groupsMatched: Group? // = example group
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupsExistCollectionV.dataSource = self
        self.groupsExistCollectionV.delegate = self
        updateViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6   // eventually you'll return the groupsMatched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupsExistCell", for: indexPath) as! GroupsExistCELL
        
        if let sampleImage = UIImage(named: "allegianceIcon-76"), //will be groupsMatched[indexPath.row].profilePhoto when data included
            let name = favoriteTeam {
            
            cell.displayCellContent(image: sampleImage, groupName: name, members: "none")  // will be groupsMatched[indexPath.row].name & .count
        }
        
        return cell
    }
    
    
    func updateViews() {
        
        guard let userTeamEntry = favoriteTeam else {print("user entered nil for group search, segue back to previous view?"); return}
        groupsFoundLabel.text = "Check out some \(userTeamEntry) groups near you!"
        groupsExistCollectionV.reloadData()
    }
   
    // not sure this is even needed given the button can be made to segue to Create Groups controller via interface builder drag/drop
    @IBAction func createGroupButton(_ sender: Any) {
        
    }
    
}
