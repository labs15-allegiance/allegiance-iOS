//
//  GroupsTableViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/30/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // now that core data is storing the user-created group you prolly don't need any of this anymore
    var groupNamePassed: String?
    var groupSloganPassed: String?
    var groupImagePassed: UIImage?
    
    private let reuseIdentifier = "GroupsCell"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("you have arrived to Groups, nested in TabBarController\n")
        print("\(groupNamePassed!) with \(groupSloganPassed!)")
        
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
            cell.textLabel?.font = UIFont(name: "SnellRoundhand-Bold", size: 32)
            cell.textLabel?.text = "Your Groups"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.yourGroupsCollectionVC.rawValue, for: indexPath) //as! YourGroupsCVCell
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.groupsNearYouHeader.rawValue, for: indexPath)
            cell.textLabel?.font = UIFont(name: "SnellRoundhand-Bold", size: 32)
            cell.textLabel?.text = "Groups Near Your"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.groupsNearYouCollectionVC.rawValue, for: indexPath) //as! GroupsNearYouCVCell
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.discoverHeader.rawValue, for: indexPath)
            cell.textLabel?.font = UIFont(name: "SnellRoundhand-Bold", size: 32)
            cell.textLabel?.text = "Discover"
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.discoverCollectionVC.rawValue, for: indexPath) //as! DiscoverCVCell
            return cell
        }
        return UITableViewCell()     // this is the default case i assume?
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - CollectionView Data Items

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
     
     }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
     
     }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
