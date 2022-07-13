//
//  Delivery.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/12/22.
//

import Foundation
import Alamofire

enum Status: String, Codable {
    case placed
    case matched
    case complete
    case cancelled
    
}

class Delivery: Codable {
    var id : Int = 0
    var orderStatus : String
    var user : User
    var userId : Int = 0
    var resturant: Resturant?
    var resturantPlaceId: Int
    var deliveryBuilding: DeliveryBuilding?
    var deliveryBuildingPlaceId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case orderStatus
        case user
        case resturant
        case resturantPlaceId
        case deliveryBuilding
        case deliveryBuildingPlaceId
    }
    
    
    init(user: User, resturant: Place, deliveryBuilding: Place) {
        self.orderStatus = "placed"
        self.user = user
        self.userId = user.id
        self.resturant = Resturant(resturant)
        self.resturantPlaceId = resturant.id
        self.deliveryBuilding = DeliveryBuilding(deliveryBuilding)
        self.deliveryBuildingPlaceId = deliveryBuilding.id
    }
    
    // send delivery to database
    func createDelivery(completion: @escaping(Delivery?) -> Void) {
        let parameters: Parameters = [
            "userId" : self.userId,
            "resturantPlaceId" : self.resturantPlaceId,
            "deliveryBuildingPlaceId" : self.deliveryBuildingPlaceId,
        ]
        APIManager.shared().call(type: EndpointItem.deliveryPost, params: parameters, completion: completion)
        
    }
    
    static func getAllPlacedDeliveries(completion: @escaping([Delivery]?) -> Void) {
        APIManager.shared().call(type: EndpointItem.deliveryGet, params: nil, completion: completion)
    }
    
}


