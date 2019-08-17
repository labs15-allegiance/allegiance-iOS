//
//  SupportTeamsSignup1VC.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/16/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class SupportTeamsSignup1VC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if (sender.direction == .left)
        {
            print("Swipe Left")
            
            // show the view from the right side
        }
        
        if (sender.direction == .right)
        {
            print("Swipe Right")
            
            // show the view from the left side
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
