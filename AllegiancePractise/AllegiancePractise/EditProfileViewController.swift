//
//  EditProfileViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/17/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var changeProfilePhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var personalHashtagTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func changeBackgroundImageButtonTapped(_ sender: Any) {
        
        // call imagePicker
        
    }
    

    
    @IBAction func changeProfilePhotoButtonTapped(_ sender: Any) {
        
        // call camera
        
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // locate user via id, then add new information
        guard let name = nameTextField.text else { return }
        print("code not yet written to save \(name)")
        
        
        // save user
        //        name, hashtag, profile image
        
        
        // segue background image back to profile page
        
        
        
        
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
