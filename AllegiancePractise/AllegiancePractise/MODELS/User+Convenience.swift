//
//  User+Convenience.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/14/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    // bannerImage?
    // bio?
    
    
    
    convenience init(id: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.id = id


        
        // another init might use... , username: String?, email: String?, password: String?, location: Int16 = 19406, image: Data?, bio: String?, bannerImage: Data?,
//        self.username = username
//        self.email = email
//        self.password = password
//        self.location = location
//        self.image = image
//        self.bio = bio
//        self.bannerImage = bannerImage
    }
}
