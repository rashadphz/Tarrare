//
//  Place.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation

import Foundation
import FirebaseAuth
import GooglePlaces

class Place: Codable {
    let name : String
    let fullAddress: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullAddress
    }
    
    init(_ gmsPlace: GMSPlace){
        self.name = gmsPlace.name!
        self.fullAddress = gmsPlace.formattedAddress!
    }
    
    
}


