//
//  Networking.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/7/22.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: String {get}
    var path: String {get}
    var url : URL {get}
    var httpMethod : HTTPMethod {get}
    var encoding: ParameterEncoding {get}
    var headers: HTTPHeaders? {get}
}

enum EndpointItem {
    case login
    case register
    case userPost
    case userGet
    case placePost
    case placeGet
    case deliveryPost
    case deliveryGet
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return "http://localhost:62528/"
        case .ngrok: return "https://2ead-163-114-132-128.ngrok.io/"
        case .prod: return ""
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .userPost, .userGet:
            return "user"
        case .placePost, .placeGet:
            return "place"
        case .deliveryPost, .deliveryGet:
            return "delivery"
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register, .userPost, .placePost, .deliveryPost:
            return .post
        case .userGet, .placeGet, .deliveryGet:
            return .get
            
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest"]
        }
    }
    
}

enum NetworkEnvironment {
    case dev
    case prod
    case ngrok
}
