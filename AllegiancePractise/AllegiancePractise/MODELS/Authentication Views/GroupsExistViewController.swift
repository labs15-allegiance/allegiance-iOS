//
//  GroupsExistViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit
import CoreData

class GroupsExistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    var userController = UserController()
    var groupController = GroupController()                     // again, am I allowed to bang this? Instructor says yes.
    
    @IBOutlet weak var groupsExistCollectionV: UICollectionView!
    
    @IBOutlet weak var groupsFoundLabel: UILabel!
    
    var favoriteTeam: String?
    var zipcode: Int16? {
        didSet {
            
        }
    }
    var groupsMatched: [Group]?              // this one is CoreData (for show, thus possibly temporary)
    var groupsMatchedFromServer: [GroupRepresentation]?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Group> = {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "groupName", ascending: true), NSSortDescriptor(key: "location", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "groupName", cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupsExistCollectionV.dataSource = self
        self.groupsExistCollectionV.delegate = self
        
        // get matching groups from the back-end using self.zipcode or keyword self.favoriteTeam
        if let favoriteTeam = favoriteTeam {
            
            groupController.fetchGroupsMatchingSearch(with: favoriteTeam, andWith: zipcode ?? 11111) { (matchingGroups, error) in
                if let error = error {
                    NSLog("Error fetching matching groups, will present full list \(error)")
                    self.groupsMatched = self.groupController.fetch()
                } else {
                    self.groupsMatchedFromServer = matchingGroups
                    print(self.groupsMatchedFromServer![0].groupName, self.groupsMatchedFromServer![0].image)    // if you search for "Dolphins" you can get it to print out "Miami Dolphins Fans"
                    
                }
                self.updateViews()
            }
        }
    }
    
    
    func updateViews() {
        
        guard let userTeamEntry = favoriteTeam else {print("user entered nil for group search, segue back to previous view?"); return}
        DispatchQueue.main.async {
            
            self.groupsFoundLabel.text = "Check out some \(userTeamEntry) groups near you!"
            self.groupsExistCollectionV.reloadData()
        }
    }
    
    
    //MARK: COLLECTIONVIEW DATASOURCES:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupsMatchedFromServer?.count ?? 0 //fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupsExistCell", for: indexPath) as! GroupsExistCELL
        
        //let group = fetchedResultsController.object(at: indexPath)
        //print(group!)

//        getImageFromCloudinary(urlString: (groupsMatchedFromServer?[indexPath.item].image)!) { (dataOfImage, error) in
//            if let error = error {
//                NSLog("Error attempting to get photo from Cloudinary, no data returned \(error)")
//            }
//
//        }  // end of image-call
        
        let dataOfImage = getImageFromCloudinary(urlString: groupsMatchedFromServer![indexPath.item].image!)
        
        // Group images from back-end are strings-- of a URL; must make a new network call here to load the image from the internet.  If you get it into data format, then your guard let statement below will work.
        guard let name = self.groupsMatchedFromServer?[indexPath.item].groupName,
              let image = UIImage(data: dataOfImage) else { return cell }
        //let members = group.users.numberOfObjects   // this must be changed to a groupsMatchedFromServer[indexPath.item].members.count
        
        cell.displayCellContent(image: image, groupName: name, members: "1")  // will be groupsMatched[indexPath.row].name & .count
        
        return cell
    }
   
    // not sure this is even needed given the button can be made to segue to Create Groups controller via interface builder drag/drop
    @IBAction func createGroupButton(_ sender: Any) {
        
    }
    
    
    //MARK: - NSFetchedResultsControllerDelegate methods.  You can most likely drop these after all the groups above are fed with networked calls from Web's back-end.
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        groupsExistCollectionV.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        groupsExistCollectionV.
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            groupsExistCollectionV.insertSections(IndexSet(integer: sectionIndex))
        case .delete:
            groupsExistCollectionV.deleteSections(IndexSet(integer: sectionIndex))
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            groupsExistCollectionV.insertItems(at: [newIndexPath])
        case .update:
            guard let indexPath = indexPath else {return}
            groupsExistCollectionV.reloadItems(at: [indexPath])
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else {return}
            groupsExistCollectionV.deleteItems(at: [oldIndexPath])
            groupsExistCollectionV.insertItems(at: [newIndexPath])
        case .delete:
            guard let indexPath = indexPath else {return}
            groupsExistCollectionV.deleteItems(at: [indexPath])
        default:
            break
        }
    }
    
    
    func getImageFromCloudinary(urlString: String) -> Data {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) {
            return data
        } else { return Data.init() }
    }
    
    
    
    
//    func getImageFromCloudinary(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
//
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let data = try Data.init(contentsOf: URL.init(string: urlString)!)
//                completion(data, nil)
//                return
//            } catch {
//                NSLog("Error getting image data from Cloudinary URL: \(error)")
//                completion(nil, error)
//            }
//        }
//    }
    
}
