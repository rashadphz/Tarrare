//
//  Conversation.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/19/22.
//

import Foundation
import UIKit

class Conversation: Codable {
    let id : Int
    let memberOneId : Int
    let memberTwoId : Int
    let memberOne : User
    let memberTwo : User
    var messages : [Message]
    
    enum CodingKeys: String, CodingKey {
        case id
        case memberOneId
        case memberTwoId
        case memberOne
        case memberTwo
        case messages
    }
    
    static func fetchConversationsForUserId(_ userId: Int, completion: @escaping([Conversation]?) -> Void) {
        APIManager.shared().call(key: "getUserConversations", query: GetUserConversationsQuery(currentUserId: userId), completion: completion)
    }
    
}

