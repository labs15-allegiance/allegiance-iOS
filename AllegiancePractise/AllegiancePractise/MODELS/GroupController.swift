//
//  GroupController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/30/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import CoreData

class GroupController {
    
    var groups : [Group] = []
    let baseUrl = URL(string: "https://labs15-allegiance-staging.herokuapp.com/api")!
    typealias completionHandler = () -> Void
    
    func put(group: Group) {
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving group to persistent store \(error)")
            return
        }
    }
    
    // optional: you could write a dedicated saveToPersistentStore() throws { function here
    
    func fetch() -> [Group] {
        
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        do {
            let moc = CoreDataStack.shared.mainContext
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching groups from iPhone memory \(error)")
            return []
        }
    }
    
    
    func fetchGroupsMatchingSearch(with groupName: String, andWith zipcode: Int16, completion: @escaping ([GroupRepresentation]?, Error?) -> Void) {

        let zipcodeString = String(zipcode)
        
        do {
            let requestURL = baseUrl.appendingPathComponent("groups").appendingPathComponent("search")
            //var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
            
            let parametersJSON: [String: String] = [
                "column": "group_name",
                "row": "raiders"
            ]
            let jsonData = try JSONSerialization.data(withJSONObject: parametersJSON, options: .prettyPrinted)
            
            print(String(data: jsonData, encoding: String.Encoding.utf8))
 
            var request = URLRequest(url: requestURL)
            request.httpBody = jsonData  //why isn't httpBody auto-completing?
            request.httpMethod = "POST"   // this is what the Web folks said was required
            
            print("networking URL: \n\(request)\n")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    NSLog("error searching for groups on Allegiance back-end \(error)")
                    completion(nil, error)
                }
//                if response != nil {
//                    NSLog("Response code: \n \(String(describing: response))")
//                }
                guard let data = data else {
                    NSLog("Error: no data recieved")
                    completion(nil, error)
                    return
                }
                
                let ourData = String(data: data, encoding: String.Encoding.utf8)
                print(ourData)
                
                do {
                    let decoder = JSONDecoder()
                    let downloadedGroups = try decoder.decode([GroupRepresentation].self, from: data)
                    print("downloadedGroups is this:  \(downloadedGroups)")
                    completion(downloadedGroups, nil)
                } catch let decodingError {
                    NSLog("\n Error decoding matchedGroups to [Group] model: \n \(decodingError) \n")
                    completion(nil, error)
                }
            }.resume()
        } catch {
            NSLog("Error assembling JSONSerialization data -> \(error)")
        }
    }
}


