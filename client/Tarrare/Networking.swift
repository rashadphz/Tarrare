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
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return "http://localhost:3000/"
        case .ngrok: return "https://b29c-50-234-16-50.ngrok.io/"
        case .prod: return ""
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .userPost:
            return "user"
        case .userGet:
            return "user"
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register, .userPost:
            return .post
        case .userGet:
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
