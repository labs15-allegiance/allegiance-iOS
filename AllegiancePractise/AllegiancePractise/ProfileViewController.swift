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
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        if credentialsManager.clear() {
            performSegue(withIdentifier: "LogoutFromUserProfile", sender: nil)
        }
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

extension UINavigationController {
    func setTitleForgroundTitleColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color]
    }
}
