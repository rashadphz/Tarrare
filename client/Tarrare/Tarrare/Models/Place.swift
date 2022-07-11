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
    
    init(_ gmsPrediction: GMSAutocompletePrediction) {
        self.name = gmsPrediction.attributedPrimaryText.string
        self.fullAddress = gmsPrediction.attributedSecondaryText?.string ?? ""
    }
    
    init(_ name: String, fullAddress: String) {
        self.name = name
        self.fullAddress = fullAddress
    }
    
    // To save Google Maps API Costs when doing UI changes
    static func createDebugPlaces() -> [Place] {
        var places : [Place] = []
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "Howard Street at West Campus, San Francisco, CA, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        places.append(Place("Chipotle Mexican Grill", fullAddress: "West 48th Street, New York, NY, USA"))
        return places
        
    }
    
    
    
    
}


