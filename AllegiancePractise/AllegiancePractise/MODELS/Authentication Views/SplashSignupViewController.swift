//
//  SplashSignupViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/20/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit
import Auth0


class SplashSignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "CowboyBlonde")!)  // "
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-iunfzciz.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    
                    // Do something with credentials e.g.: save them.
                    //userController.createUser(credentials: credentials)
                    
                    
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                }
        }
    }
    
    
    
    
}
