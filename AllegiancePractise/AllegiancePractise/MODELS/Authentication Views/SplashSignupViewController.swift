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
    var groupController = GroupController()
    var userController = UserController()
    public let icon: String = "FansRejoice"
    var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Allegiance Background")!)  // "
        signInButton.isHidden = false
        
        // This will only occur if the back-end goes bad or its the first time ever the app is run
        if groupController.fetch().isEmpty {
            let image = (UIImage(named: icon)?.pngData())!  //The icon comes with the app
            let group = Group(groupName: "Allegiance Enthusiasts Unite!", slogan: "Bring'em Back!", timestamp: Date(), privacySetting: "public", location: 18925, id: UUID(), image: image, creatorId: "johnpittsisyouroverlord")
            groupController.put(group: group)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
                    
                    if self.credentialsManager.store(credentials: credentials) {
                        
                        
                        guard let id = credentials.idToken else { return }
                        let user = User(id: id)
                        self.userController.put(user: user)
                    }
                    
//                    let defaults = UserDefaults.standard
//                    defaults.set(credentials, forKey: "credentials")
                    print("FUCKING AUTH0 Credentials: \(String(describing: credentials.idToken))")
                    
                    if self.isAuthenticated {
                        DispatchQueue.main.async {    // i don't think i need to call main here as it's outside the closure, experiement with this later.
                            
                            self.signInButton.isHidden = true
                            // we will want to segue to Groups or Feed when user isn't a new-register, after logging in
                            //self.performSegue(withIdentifier: "UserAlreadyHasLoginCredentials", sender: self)
                        }
                    }     // else, encourage Registration? or does Auth0 do that for me automatically?
                    
                    // Auth0 will automatically dismiss the login page; write code to direct app to advanced view with which the user would interact if he wasn't a newb to the app.
                  }
              }
    }
    
    
    
    @IBAction func inviteCodeButtonPressed(_ sender: Any) {
        print("Have an invite code will be implemented in a later release, and be in place of this button")
        
        if credentialsManager.clear() {
            
            DispatchQueue.main.async {
                self.signInButton.isHidden = false
                self.isAuthenticated = false
            }
        }
        
    }
    
}
