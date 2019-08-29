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
        
        // This Login call is performed with a background thread, so you must DispatchMain for UI actions directly afterwards
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
                    print("Credentials: \(credentials)")
                    
                    
                    // Auth0 will automatically dismiss the login page; write code to direct app to advanced view with which the user would interact if he wasn't a newb to the app.
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "UserAlreadyHasLoginCredentials", sender: self)
                    }
                  }
              }
    }
    
    
    
    @IBAction func inviteCodeButtonPressed(_ sender: Any) {
        print("Invite Codes will be implemented in a later release")
    }
}
