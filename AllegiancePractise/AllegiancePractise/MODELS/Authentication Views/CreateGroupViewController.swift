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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
//    @IBAction func createGroupButtonTapped(_ sender: Any) {
//
//        // add nameTextField.text and sloganTextField.text and addPhotoButton.image and isPrivate to a newly created Group
//
//        // SEGUE to Tab-Bar-Controller Groups tab
//        performSegue(withIdentifier: "TabBarSegue", sender: Any?.self)
//    }
    
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
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let groupsCollectionVC = mainStoryboard.instantiateViewController(withIdentifier: "GroupsCollectionViewController") as? GroupsCollectionViewController else { return }
            
//            navigationController?.pushViewController(groupsCollectionVC, animated: true)
        }
        // newVC = storyboard.GroupsCollectionViewController using segue.destination.
        // Pass addPhotoButton.image to GroupsCollectionVC.image
        // Pass nameTextField.text to GroupsCollectionVC.name
        // Pass sloganTextField.text to GroupsCollectionVC.slogan

    }


}
