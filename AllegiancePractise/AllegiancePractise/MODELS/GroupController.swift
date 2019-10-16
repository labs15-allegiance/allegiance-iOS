//
//  GroupController.swift
//  AllegiancePractise
//
//  Created by John Pitts on 8/30/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import CoreData
import Auth0

// Auth0 Domain (shared with Web team) = http://dev-uzdmt05n.auth0.com/
// Auth0 Client ID: vW5VFcgIipS8DAXfFd2QK2kJj7txWcTe

class GroupController {
    
    var groups : [Group] = []
    let baseUrl = URL(string: "https://labs15-allegiance.herokuapp.com/api")!
    typealias completionHandler = () -> Void
    var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    let credentials = Credentials()
    

    
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
        
        //let zipcodeString = String(zipcode)
        
        // this code is crap but it's supposed to fetch the credentials stored in the dependency manager files such that it's ready to put into the header for the API back-end call (as accessToken?)
        
        credentialsManager.credentials { error, credentials in
            guard error == nil,
                let credentials = credentials else {   // credentials.accessToken or credentials.idToken will need to be sent in a header for the groups search call below, but sometimes I use a verified token that works for SURE given to me by Web Dev team.
                    if let error = error {
                        NSLog("Credentials have been lost somehow since login/authentication: \(error)")
                    }
                    return   // we exit fetching matched groups to user's search if user has no credentials (This is a Web thing, we really need to have the back-end allow iOS access without verifying auth token, unless it's the user's posting data (not this network call as this is just a group search)
            } // end else-guard, passing thru means user has valid credentials and thus can successfully make the network call, and from Auth0: You now have a valid credentials object, you might want to store this locally for easy access.
            
            
            do {
                let requestURL = self.baseUrl.appendingPathComponent("groups").appendingPathComponent("search")
                //var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
                
                let parametersJSON: [String: String] = [
                    "column": "group_name",
                    "row": groupName
                ]
                let jsonData = try JSONSerialization.data(withJSONObject: parametersJSON, options: .prettyPrinted)
                
                //print(String(data: jsonData, encoding: String.Encoding.utf8)!)
                
                var request = URLRequest(url: requestURL)
                guard let token = credentials.accessToken else {
                    NSLog("network call failed, groups search failed either bc accessToken didn't exist")
                    completion(nil, nil)
                    return }
                
                print("accessToken: \(String(token)) \n")
                print("idToken: \(String(credentials.idToken!)) \n")
                
                // this token given to me by Web Dev team works, and allows real data to be sequestered from the back-end.  Now I just have to figure out how to let "credentials" issue my accessToken to allow me to make network calls.
                //let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ik9EQTRSamhHT1RNMU56ZzVOemhHUVRrNFJEWkNSVGhGTWpjM09EUXpRelU0TVRaRE9Ea3hNUSJ9.eyJpc3MiOiJodHRwczovL2Rldi11emRtdDA1bi5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMDQ2Mzg2ODIxMDY5OTczMDc3MjEiLCJhdWQiOlsiaHR0cHM6Ly9kZXYtdXpkbXQwNW4uYXV0aDAuY29tL2FwaS92Mi8iLCJodHRwczovL2Rldi11emRtdDA1bi5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNTY5NTM2NTg4LCJleHAiOjE1NzIxMjg1ODgsImF6cCI6InZXNVZGY2dJaXBTOERBWGZGZDJRSzJrSmo3dHhXY1RlIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCJ9.oNXA9_DyuFBo1ppsSEnqiO-I5bgrCadT6vz_micWPLIuHxtohRXcNoNiTqTxwNlCdF2WqZHx-en3cCXyI5ZGEh75ZqikbkRvPf_AyEIawu8RD5d5APgilfzH1E7u2rSaxuvcqVb9EYBOTNZtra5cWBRhAGK_nEbZp7t6r6eJ3p1Tr-JgxkDI5WMfnftJg4uVLC13KkmEhMMvl_VBDeb3odQOh2ssb7CDiMaExdV8eRnDRj4R3tzBPdxtkDk70A8D-AkfD5q25CPLXYDPZ8JCbYdnxIzgnNejid_73OS2_Se6drImbwTPK8Z4MmOUahA8lwl3bmfQJqWdphi92taA_Q"
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                request.httpMethod = "POST"   // this is what the Web folks said was required for group search api
                
                print("\n networking URL: \n\(request) \n")
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        NSLog("error searching for groups on Allegiance back-end \(error)")
                        completion(nil, error)
                    }
                    if response != nil {
                        NSLog("Response code: \n \(String(describing: response))")
                    }
                    guard let data = data else {
                        NSLog("Error: no data recieved")
                        completion(nil, error)
                        return
                    }
                    print("if you're here you got back data of some sort \n")
                    let ourData = String(data: data, encoding: String.Encoding.utf8)
                    print(ourData as Any)
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        
                        // I suspect the back-end is still rejecting my credentials.accessToken as a valid
                        
                        
                        let dictionaryOfGroups = try decoder.decode([String: [GroupRepresentation]].self, from: data)
                        print("dictionaryOfGroups's number of returns/count0 is this:  \(dictionaryOfGroups["groupByFilter"]?.count ?? 0)\nb")
                        
                        // now extract the array of returned groups from the dictionary format of the back-end
                        let matchedGroups = dictionaryOfGroups["groupByFilter"]
                        print(matchedGroups![0].groupName)
                        completion(matchedGroups, nil)
                    } catch let decodingError {
                        NSLog("\n Error decoding matchedGroups to [Group] model: \n \(decodingError) \n")
                        completion(nil, error)
                    }
                }.resume()
            } catch {
                NSLog("Error assembling JSONSerialization data -> \(error)")
            }
        } // end closure for credentialsManagaer token call; yes, the brackets are out of alignment-- due to putting whole network call inside credentialsManager closure, bc I can't figure out how to just get credentials.idToken or credentials.accessToken to work.
    }
}


