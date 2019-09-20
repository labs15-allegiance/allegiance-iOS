//
//  UserRepresentation.swift
//  AllegiancePractise
//
//  Created by John Pitts on 9/19/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation


// created this specifically just to make GroupRepresentation Codable-compliant

struct UserRepresenation: Codable {
    
    var id: Int32
    var userId: Int32
    var firstName: String
    var lastName: String
    var userName: String
    var email: String
    var userLocation: String
    // I'm going to cut this short bc I don't need any of this stuff at the moment
}
