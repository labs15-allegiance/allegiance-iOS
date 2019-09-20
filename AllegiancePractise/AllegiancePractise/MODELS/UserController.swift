//
//  UserController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/28/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    
    func put(user: User) {
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving the user to persistent store \(error)")
            return
        }
    }
    
    func fetch() -> [User] {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let moc = CoreDataStack.shared.mainContext
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching groups from iPhone memory \(error)")
            return []
        }
    }
    
    func getThisDevicesUserWithLogin(id: String, in context: NSManagedObjectContext) {
        // so CoreData's User model has a method for free called fetchRequest()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as String)
    }
    
    // create a user
    //func createUser(credentials: credentials) {
        
        
    //}
    
    // update a user
    
    // delete a user
}
