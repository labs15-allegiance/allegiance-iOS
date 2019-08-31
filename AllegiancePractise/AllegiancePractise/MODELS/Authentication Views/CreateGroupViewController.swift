//
//  CreateGroupViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/27/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sloganTextField: UITextField!
    // privacySetting from checkboxes
    
    var privacySetting: Bool = false
    var creatorCount: Int32 = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //allows keyboard to drop when typing return after User enters text
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func createGroupButtonTapped(_ sender: Any) {
        
        // Get the total Group/Creator count for overall App, and assign an sequential id
        creatorCount += 1
        let creatorId = creatorCount
        let moc = CoreDataStack.shared.mainContext

        // add nameTextField.text and sloganTextField.text and addPhotoButton.image and isPrivate to a newly created Group
        guard let name = nameTextField.text, !name.isEmpty else { return }
        let group = Group(groupName: name, slogan: sloganTextField.text, privacySetting: privacySetting, location: 11111, creatorId: creatorId, context: moc)
        
        
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }

        // SEGUE to Tab-Bar-Controller Groups tab
        performSegue(withIdentifier: "TabBarSegue", sender: self)
    }
    
    @IBAction func inviteSnapchattersTapped(_ sender: Any) {
        
        // use Snapkit API? to invite snapchatters to join group by sending them an invite code to press which will open up to SplashSignupViewController and inspire them to click "Got Invite Code?"
    }
    
    
    @IBAction func privateGroupButtonChecked(_ sender: Any) {
        
        // make sure publicGroupButtonChecked is cleared of image
        // make isPrivate true
        // else make isPrivate false
    }
    
    @IBAction func publicGroupButtonChecked(_ sender: Any) {
        // do the opposite of private above
    }
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TabBarSegue" {
            
            let destinationVC = segue.destination as! UITabBarController
            let groupsTableVC = destinationVC.children[0].next as! GroupsTableViewController
                
                groupsTableVC.groupNamePassed = nameTextField.text
                groupsTableVC.groupSloganPassed = sloganTextField.text
            
        }
        // newVC = storyboard.GroupsCollectionViewController using segue.destination.
        // Pass addPhotoButton.image to GroupsCollectionVC.image
    }
}

// this is code one can use if not using interface builder to create the segue...
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            guard let groupsCollectionVC = mainStoryboard.instantiateViewController(withIdentifier: "GroupsCollectionViewController") as? GroupsCollectionViewController else { return }
