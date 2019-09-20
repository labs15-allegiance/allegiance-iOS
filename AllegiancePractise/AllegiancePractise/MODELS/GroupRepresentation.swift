//
//  GroupRepresentation.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/19/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation

// created to make Group.self Codable compliant for networking purposes.

struct GroupRepresentation: Codable {
    
    var id: Int32
    var groupName: String
    var privacySetting: String
    var location: String
    var creatorId: Int32
    var image: String      // it's a url
    var acronym: String
    var description: String
    var createdAt: String // convert to date
    var updatedAt: String // convert to date
    var members: [UserRepresenation]   // now we prolly need UserRepresentation too.  grimace.
}
