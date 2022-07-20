//
//  Message.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/18/22.
//

import Foundation
import MessageKit
import UIKit

class Message: Codable {
    let id : Int
    let recieverId : Int
    let recieverUser : User
    let senderId : Int
    let senderUser : User
    let text : String
    let createdAt : Date
    let convoId : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case recieverId
        case recieverUser = "reciever"
        case senderId
        case senderUser = "sender"
        case text
        case createdAt
        case convoId
    }
    
    static func getConversation(recieverId: Int, senderId: Int, completion: @escaping([Message]?) -> Void) {
        APIManager.shared().call(key: "getConversation", query:GetConversationQuery(senderId: senderId, recieverId: recieverId) , completion: completion)
    }
    
    static func createMessage(text: String, recieverId: Int, senderId: Int, completion: @escaping(Message?) -> Void) {
        
        APIManager.shared().call(key: "createMessage", mutation: CreateMessageMutation(text: text, senderId: senderId, recieverId: recieverId), completion: completion)
    }
    
    static func messageListenForUserId(_ userId: Int, completion: @escaping(Message?) -> Void) {
        APIManager.shared().call(key: "newMessage", subscription: MessageListenSubscription(recieverId: userId), completion: completion)
    }
    
}


public struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}


extension Message: MessageType {
    var sender: SenderType {
        
        return Sender(senderId: String(senderId), displayName: senderUser.firstName)
    }
    
    var messageId: String {
        return String(id)
    }
    
    var sentDate: Date {
        return createdAt
    }
    
    var kind: MessageKind {
        return .text(text)
    }
    
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text && lhs.id == rhs.id
    }
}
