//
//  User.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/6/22.
//

import Foundation
import FirebaseAuth

class User: Codable {
    let firstName : String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
    }
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
                
            }
        }
    }
    
    static func getCurrent() -> User? {
        let userData = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUser) as? Data
        let user = try? JSONDecoder().decode(User.self, from:userData!)
        return user
    }
    
}

