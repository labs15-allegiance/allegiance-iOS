//
//  AuthenticationViewController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/23/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerLoginButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var signInType: SignInType = .login

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    enum SignInType {
        case register
        case login
    }

}
