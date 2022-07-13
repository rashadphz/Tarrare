//
//  Place.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation
import FirebaseAuth
import GooglePlaces
import Alamofire

class Place: Codable {
    var id : Int = 0
    var name : String = ""
    var fullAddress: String = ""
    var state: String = ""
    var city: String = ""
    var zipcode: Int = 0
    var googlePlaceId: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullAddress
        case state
        case city
        case zipcode
        case googlePlaceId
    }
    
    func setAddressComponents(_ addressComponents: [GMSAddressComponent]?) {
        for component in addressComponents! {
            let type = component.type
            if type == "locality" {
                self.city = component.name
            } else if type == "administrative_area_level_1" {
                self.state = component.name
            } else if type == "postal_code" {
                self.zipcode = Int(component.name) ?? 0
            }
        }
        
    }
    
    init(_ gmsPlace: GMSPlace){
        self.name = gmsPlace.name!
        self.fullAddress = gmsPlace.formattedAddress!
        setAddressComponents(gmsPlace.addressComponents)
        self.googlePlaceId = gmsPlace.placeID!
    }
    
    init(_ gmsPrediction: GMSAutocompletePrediction) {
        self.name = gmsPrediction.attributedPrimaryText.string
        self.fullAddress = gmsPrediction.attributedSecondaryText?.string ?? ""
    }
    
    init(_ name: String, fullAddress: String) {
        self.name = name
        self.fullAddress = fullAddress
    }
    
    static func setCurrent(_ place: Place, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(place) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentPlace)
                
            }
        }
    }
    
    static func getCurrent() -> Place? {
        let placeData = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentPlace) as? Data
        if let placeData = placeData {
            let place = try? JSONDecoder().decode(Place.self, from:placeData)
            return place
        }
        return nil
    }
    
    // send the place to database
    func createPlace(completion: @escaping(Place?) -> Void) {
        let parameters: Parameters = [
            "name" : self.name,
            "fullAddress" : self.fullAddress,
            "state" : self.state,
            "city" : self.city,
            "zipcode" : self.zipcode,
            "googlePlaceId" : self.googlePlaceId,
        ]
        APIManager.shared().call(type: EndpointItem.placePost, params: parameters, completion: completion)
    }
    
}


