//
//  AuthenticationViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/23/19.
//  Copyright © 2019 johnpitts. All rights reserved.

// NOTES:
//OpenID Connect (OIDC**) is an authentication layer on top of OAuth 2.0, an authorization framework. The standard is controlled by the OpenID Foundation

// These are deprecated Auth0 domain/clientID, switched to versions in Auth0.plist to match Web Dev's Auth0 account so user's can go cross-platform
// Auth0 clientID =  mZFvU0TMKMpEi6lUkNTCxUuz986y4luR called "Default App" GENERIC

// Logout URL was:   com.lambdaSchool.AllegiancePractise.jtaylor://dev-iunfzciz.auth0.com/ios/com.lambdaSchool.AllegiancePractise.jtaylor/callback

import UIKit
import Auth0

// DEPRECATED viewController, also see AppDelegate and SplashSignupViewController
class AuthenticationViewController: UIViewController {
    
    // This login page has been DEPRECATED,but it's left here to use in case Auth0 is mercifully cut out of the project.  Auth0 sucks, so they SHOULD be cut out of the project.
    
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerLoginButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var signInType: SignInType = .login
    var credentials: Credentials?                            // assuming this is still needed even tho Credentials seems to be a public variable (whole project)
    var userController = UserController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // This code was copied and pasted to display Auth0's HOSTED login page, not sure it's in the right spot actually
//        Auth0
//            .webAuth()
//            .audience("https://dev-iunfzciz.auth0.com/userinfo")
//            .start { result in
//                switch result {
//                case .success(let credentials):
//                    print("Obtained credentials: \(credentials)")
//                case .failure(let error):
//                    print("Failed with \(error)")
//                }
//                // snipped above "sets the audience to ensure OIDC** responses.
//                
//        }
        //var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        //credentialsManager.enableBiometrics(withTitle: "Touch to Login")
        //credentialsManager.store(credentials: credentials)

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BaseballNight")!)
    }
    
    
    @IBAction func registerOrLoginSelected(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            signInType = .register
            registerLoginButton.setTitle("Register", for: .normal)
        } else {
            signInType = .login
            registerLoginButton.setTitle("Log In", for: .normal)
        }
    }

    
    
    enum SignInType {
        case register
        case login
    }

}
