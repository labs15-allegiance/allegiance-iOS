//
//  GroupSearchViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class GroupSearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var favoriteTeamTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteTeamTextField.delegate = self
        self.zipcodeTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        hideKeyboardWhenTappedAround()
        return true
    }

    
    @IBAction func useLocationButtonTapped(_ sender: Any) {
        
        //authorize user to allow iphone to read location, this will likely require a change in info.plist or file permissions.
        //get the zipcode for the user's current location and enter it into zipcodeTextField.text
        
        
        
        // Future Feature: place the map on the GroupsExist result page and throw down all the different groups onto the map allowing user to press group he wants to join.
        
    }
    
    @IBAction func findGroupsButtonTapped(_ sender: Any) {
        // didn't need this as "Find a Group" button segues via storyboard to GroupsExistVC where back-end call is made with zip and favorite team.  See prepare(for segue:) below
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let groupExistVC = segue.destination as? GroupsExistViewController,
            let zipcode = Int16(zipcodeTextField.text!) {
            
            groupExistVC.favoriteTeam = favoriteTeamTextField.text
            groupExistVC.zipcode = zipcode
        }
    }
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
