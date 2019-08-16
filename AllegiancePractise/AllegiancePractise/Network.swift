//
//  Network.swift
//  AllegiancePractise
//
//  Created by Michael Flowers on 8/16/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation

class Network {
    //base url
    private let baseURL = URL(string: "https://labs15-allegiance.herokuapp.com")!
    
    func fetch(completion: @escaping (Error?) -> Void){
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("This is the status code response: \(response.statusCode)")
            }
            
            if let error = error {
                print("Error making network call: \(error)")
                return
            }
            
        }.resume()
    }
}
