//
//  Resturant.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/13/22.
//

import Foundation

class Resturant: Codable {
    let place : Place
    
    enum CodingKeys: String, CodingKey {
        case place
    }
    
    init(_ place: Place){
        self.place = place
    }
}
