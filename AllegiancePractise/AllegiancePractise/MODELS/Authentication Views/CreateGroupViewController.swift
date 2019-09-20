//
//  CreateGroupViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/27/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit
import Auth0

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    var groupController = GroupController()
    var userController = UserController()
    let imagePicker = UIImagePickerController()
    var credentials = Credentials()
    var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    var groupPhotoData: Data?
    var users: [User]?

    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sloganTextField: UITextField!
    // privacySetting from checkboxes
    
    var privacySetting: String = "public"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.sloganTextField.delegate = self
        // get creatorCount from server, or you could do it using a didSet above


    }
    
    //allows keyboard to drop when typing return after User enters text
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func createGroupButtonTapped(_ sender: Any) {

        // idToken is the user's bearer token for the app/Auth0, but seems to be nil after login??

        //let creatorId = credentials.idToken // "yetAnotherCreator" // bug: idToken is returning nil even after auth0 authentication credentials.idToken!
        let standbyImageData = (UIImage(named: "allegianceIcon-76")?.pngData())!  // banged bc every app copy will have the app icon in it by default
        let allUsers = userController.fetch()

        // add name and slogan and addPhotoButton.image and isPrivate to a newly created Group
        guard let name = nameTextField.text,
              let creatorId = allUsers[0].id,    /* CoreData is really only storing the iPhone user aka [0] */
              !name.isEmpty else { return }
        
        
        print("create groups will work only if creatorId \(creatorId) exists")
        let group = Group(groupName: name, slogan: sloganTextField.text, timestamp: Date(), privacySetting: privacySetting, location: 19406, id: UUID(), image: groupPhotoData ?? standbyImageData, creatorId: creatorId)
        groupController.put(group: group)
        
        // SEGUE to Tab-Bar-Controller Groups tab
        performSegue(withIdentifier: "TabBarSegue", sender: self)
    }
    
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        //openCamera()
        openPhotoLibrary()
    }
    
    
    
    @IBAction func inviteSnapchattersTapped(_ sender: Any) {
        
        // use Snapkit API? to invite snapchatters to join group by sending them an invite code to press which will open up to SplashSignupViewController and inspire them to click "Got Invite Code?"
    }
    
    
    @IBAction func privateGroupButtonChecked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        // TEST: what happens if user selects both before hitting "create"?
        // answer: the setting will be affected by whatever button user checked last.
        if sender.isSelected {
            privacySetting = "private"
        }
    }
    @IBAction func publicGroupButtonChecked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        // see comment above in privateGroupButtonChecked
        if sender.isSelected {
            privacySetting = "public"
        }
    }
    
    
    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("camera not supported by simulator or this device")
            return
        }
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // in the future, try putting picker.dismiss at the end, to see if it's any quicker.
        defer {
            picker.dismiss(animated: true)
        }
        print(info)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        addPhotoButton.setBackgroundImage(image, for: .normal)  // if doesn't work try setBackgroundImage
        groupPhotoData = image.pngData() // in Core IMage = Binary Data, Foundation: NSData, Data
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        print("imagepicker did cancel")
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TabBarSegue" {
            
            let destinationVC = segue.destination as! UITabBarController
            
            // this is here in case you want to pass some data to Groups view inside TabBarController in the main storyboard
            let groupsTableVC = destinationVC.children[0].children[0] as! GroupsTableViewController
                
            // Pass addPhotoButton.image to GroupsCollectionVC.image
            
        }
    }
}


//
//extension UIImage {
//    func toString() -> String {
//        let data: Data? = self.pngData()
//        return data?.base64EncodedString(options: .endLineWithLineFeed) ?? "Allegiance Background"
//    }
//}

// this is code one can use if not using interface builder to create the segue...
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            guard let groupsCollectionVC = mainStoryboard.instantiateViewController(withIdentifier: "GroupsCollectionViewController") as? GroupsCollectionViewController else { return }
