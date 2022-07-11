//
//  MapsAPI.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation
import GooglePlaces

extension APIManager {
    
    func getCurrentPlace(completion: @escaping (Place) -> Void) {
        let placesClient = GMSPlacesClient.shared()
        let placeFields : GMSPlaceField = [.name, .formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields, callback: { [weak self] (placeLikelihoods, error) in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let place = placeLikelihoods?.first?.place else {
                return
            }
            
            completion(Place(place))
        })
    }
    
    func placeFromID(placeID: String, sessionToken: GMSAutocompleteSessionToken, completion: @escaping (Place) -> Void) {
        let placesClient = GMSPlacesClient.shared()
        let placeFields : GMSPlaceField = [.name, .formattedAddress]
        
        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: placeFields, sessionToken: sessionToken, callback: {
            (place: GMSPlace?, error: Error?) in
            
            if let error = error {
                print("Place from ID Error: \(error.localizedDescription)")
            }
            
            if let place = place {
                completion(Place(place))
            }
        })
    }
}
