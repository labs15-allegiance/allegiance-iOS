//
//  AppDelegate.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/8/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    var userController = UserController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Auth0 directions:   When the user opens your application, check for valid credentials. If they exist, you can log the user in automatically and redirect them to the app's main flow without any additional login steps.  First, you check if the credentials manager has valid credentials:
        print("Valid Credentials were found from last time?  \(credentialsManager.hasValid())")
        guard credentialsManager.hasValid() else {
            
            // This opens Registration/Login page
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "SignupVC")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            return true
        }
        // retrieve the credentials
        credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                NSLog("Error: \(error)")
                return
            }
            // You now have a valid credentials object, you might want to store this locally for easy access.
            // You will use this later to retrieve the user's profile
            
            // me: create a user here, or you can just wait to create the user in Profile when they are ready to reveal more information about themselves.  There you can search to see if the user already exists in the database.
            
            print("why am i bothering with credentialsManager? i already should have the credentials so what's teh point?")
        }

        //Opens to TabBar Controller "Groups" tab (aka tab 0)
        return true
    }
    
    
    //This function allows Auth0 to handle authentication callbacks: (a suggested fix was implemented related to deprecation of the key below which is now UIApplication.OpenURLOptionsKey
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return Auth0.resumeAuth(url, options: options)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

