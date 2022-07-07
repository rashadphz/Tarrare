//
//  APIManager.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/7/22.
//

import Foundation
import Alamofire

class APIManager {
    
    private let sessionManager: Session
    static let networkEnvironment: NetworkEnvironment = .dev
    
    
    private static var sharedAPIManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        return apiManager
    }()
    
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping(T?) -> ()) where T: Codable {
        
        self.sessionManager.request(type.url, method: type.httpMethod, parameters: params, encoding: type.encoding, headers: type.headers).validate().responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(_):
                print(response)
                break
            case .failure(_):
                handler(nil)
                break
            }
            
            
        }
    }
    
    // backend endpoints
    func loginUser(email: String, password: String) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        self.call(type: EndpointItem.login, params: parameters, handler: {
            (success: String?) in
            
        } )
    }
    
    func registerUser(firstName: String, lastName: String, email: String, password: String) {
        let parameters: Parameters = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
        self.call(type: EndpointItem.register, params: parameters, handler: {
            (success: String?) in
            
        } )
    }
    
}

