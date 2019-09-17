//
//  GroupsTableViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/30/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var groupController = GroupController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("you have arrived to Groups, nested in TabBarController\n")
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableView.automaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - "Your Groups" header
        // 1 - YourGroupsCollectionView
        // 2 - "Groups Near You" header
        // 3 - GroupsNearYouCollectionView
        // 4 - "Discover" header
        // 5 - DiscoverCollectionView
        return 6
    }
    
    enum TableCellIdentifiers: String {
        case yourGroupsHeader
        case yourGroupsCollectionVC
        case groupsNearYouHeader
        case groupsNearYouCollectionVC
        case discoverHeader
        case discoverCollectionVC
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.yourGroupsHeader.rawValue, for: indexPath)
            cell.textLabel?.font = UIFont(name: "Heebo-Bold", size: 14)
            cell.textLabel?.text = "YOUR GROUPS"
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.yourGroupsCollectionVC.rawValue, for: indexPath) as! YourGroupsTableViewCell
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.groupsNearYouHeader.rawValue, for: indexPath)
            cell.textLabel?.font = UIFont(name: "Heebo-Bold", size: 14)
            cell.textLabel?.text = "GROUPS NEAR YOU"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.groupsNearYouCollectionVC.rawValue, for: indexPath) as! GroupsNearYouTableViewCell
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.discoverHeader.rawValue, for: indexPath)
            cell.textLabel?.font = UIFont(name: "Heebo-Bold", size: 14)
            cell.textLabel?.text = "DISCOVER"
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.discoverCollectionVC.rawValue, for: indexPath) as! DiscoverTableViewCell
            return cell
        }
        return UITableViewCell()     // this is the default case i assume?
    }
    
    
    // This willDisplay cell forRowAt datasource method allows each TableView Cell to adopt its respective collectionView (see ...CVCell files) and become the datasource for it. It overrides/reloads the TVcell with the collectionView.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            if let cell = cell as? YourGroupsTableViewCell {
                cell.yourGroupsCollectionView.dataSource = self
                cell.yourGroupsCollectionView.delegate = self
                cell.yourGroupsCollectionView.reloadData()
            }
        }
        if indexPath.row == 3 {
            if let cell = cell as? GroupsNearYouTableViewCell {
                cell.groupsNearYouCollectionView.dataSource = self
                cell.groupsNearYouCollectionView.delegate = self
                cell.groupsNearYouCollectionView.reloadData()
            }
        }
        if indexPath.row == 5 {
            if let cell = cell as? DiscoverTableViewCell {
                cell.discoverCollectionView.dataSource = self
                cell.discoverCollectionView.delegate = self
                cell.discoverCollectionView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        // why is this not working for "Your Groups" CV and "Discover" CV?
        case 1:
            return 80.0
        case 3:
            return 179.0
        case 5:
            return 236
        default:
            return UITableView.automaticDimension
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.

        if segue.identifier == "ShowYourGroup" {
            
        }
        if segue.identifier == "ShowAGroupNearYou" {
            let groupTVC = segue.destination as! GROUPTableViewController
            guard let indexPath = sender as? IndexPath else { return }
            
            let groups = groupController.fetch()
            groupTVC.group = groups[indexPath.row]    // is this item or row?
        }
        if segue.identifier == "ShowADiscoverGroup" {
           // do not repeat code here, you can prolly put groupTVC and indexPath above the if statements and get away with just changing the groupController.fetch() type.  for now we'll just repeat the same code 3 times...
//            let groupTVC = segue.destination as! GROUPTableViewController
//            guard let indexPath = sender as? NSIndexPath else { return }
//            
//            let groups = groupController.fetch()
//            groupTVC.group = groups[indexPath.item]
        }
    }
 
}  //end TableView



extension GroupsTableViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // MARK: - CollectionView Data Items
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 1
        case 3:
            return groupController.fetch().count
        default:
            return groupController.fetch().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //sets the correct (of the 3 collectionViews) dequeueResusable IDENTIFIER for the collectionView
        switch collectionView.tag {
            //if tableView is doing cell == 1, then "YourGroupsCell"
            //if ...                cell == 3, then "GroupNearYouCell"
            //if ...                cell == 5, then "DiscoverCell"
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourGroupsCell", for: indexPath) as! YourGroupsCVCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupNearYouCell", for: indexPath) as! GroupsNearYouCVCell

            cell.contentView.layer.cornerRadius = 8.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            cell.layer.shadowRadius = 8.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            cell.layer.backgroundColor = UIColor.clear.cgColor
            
            // Grab full list of all groups, for now, until filtering is implemented
            let groups = groupController.fetch()
            cell.name = groups[indexPath.item].groupName
            
            // use optional conditioning here
            if let image = UIImage(data: groups[indexPath.item].image!) {
                
                cell.image = image
                cell.members = /* groups[indexPath.item].members */ "2 Fans"
            }
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCVCell
            // Grab full list of all groups, for now, until filtering is implemented
            let groups = groupController.fetch()
            cell.name = groups[indexPath.item].groupName
            
            // use optional conditioning here
            if let image = UIImage(data: groups[indexPath.item].image!) {
                
                cell.image = image
                cell.members = /* groups[indexPath.item].members */ "2 Fans"
            }
            return cell
        default:
            return UICollectionViewCell()
        } // switch
    } // cellForItemAt
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            performSegue(withIdentifier: "ShowYourGroup", sender: indexPath)
        case 3:
            performSegue(withIdentifier: "ShowAGroupNearYou", sender: indexPath)
        case 5:
            performSegue(withIdentifier: "ShowADiscoverGroup", sender: indexPath)
        default:
            fatalError()
        }
    }

}
