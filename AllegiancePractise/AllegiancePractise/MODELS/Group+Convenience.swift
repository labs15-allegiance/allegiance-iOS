//
//  Group+Convenience.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/30/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    
    convenience init(groupName: String, slogan: String?, timestamp: Date = Date(), privacySetting: String = "public", location: Int32, id: UUID = UUID(), image: Data, creatorId: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.image = image
        self.groupName = groupName
        self.slogan = slogan
        self.timestamp = timestamp
        self.privacySetting = privacySetting
        self.location = location
        self.id = id
        self.creatorId = creatorId
        
        //self.logo = UIImage(data: data)
    }
        
}
