//
//  ProfileViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/12/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit
import Auth0

class ProfileViewController: UIViewController {
    
    var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
        navigationController?.setTitleForgroundTitleColor(.white)
        
        updateViews()
    }
    
    
    private func updateViews() {
        print("you've reached Profile \n")
        
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        print("User logging out from Profile \n")
        if credentialsManager.clear() {
            performSegue(withIdentifier: "LogoutFromUserProfile", sender: nil)
        }
    }

}

extension UINavigationController {
    func setTitleForgroundTitleColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color]
    }
}
