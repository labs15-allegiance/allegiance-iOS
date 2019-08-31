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

    @IBOutlet weak var signInButton: UIButton!
    var isAuthenticated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "CowboyBlonde")!)  // "
        signInButton.isHidden = false
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        // This Login call is performed with a background thread, so you must DispatchMain for UI actions directly afterwards
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-iunfzciz.auth0.com/userinfo")
            .start {                                              // background que (closure)
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                    self.isAuthenticated = false
                case .success(let credentials):
                    
                    self.isAuthenticated = true
                    // Do something with credentials e.g.: save them.
                    
                    //userController.createUser(credentials: credentials)
                    print("Credentials: \(credentials)")
                    
                    
                    // Auth0 will automatically dismiss the login page; write code to direct app to advanced view with which the user would interact if he wasn't a newb to the app.
                  }
              }
        if isAuthenticated {
            DispatchQueue.main.async {    // i don't think i need to call main here as it's outside the closure, experiement with this later.
                
                self.signInButton.isHidden = true
                // we will want to segue to Groups or Feed when user isn't a new-register, after logging in
                //self.performSegue(withIdentifier: "UserAlreadyHasLoginCredentials", sender: self)
            }
        }     // else, encourage Registration? or does Auth0 do that for me automatically?
    }
    
    
    
    @IBAction func inviteCodeButtonPressed(_ sender: Any) {
        print("Invite Codes will be implemented in a later release")
    }
}
