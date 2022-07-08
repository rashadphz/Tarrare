//
//  User.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/6/22.
//

import Foundation

struct User: Decodable {
    let firstName : String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
    }
    
}

