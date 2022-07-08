//
//  APIManager.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/7/22.
//

import Foundation
import Alamofire

import FirebaseAuth

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
    
    func call<T>(type: EndPointType, params: Parameters? = nil, completion: @escaping(T?) -> Void) where T: Decodable {
        
        self.sessionManager.request(type.url, method: type.httpMethod, parameters: params, encoding: type.encoding, headers: type.headers).validate().responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let user):
                completion(user)
                break
            case .failure(_):
                completion(nil)
                break
            }
            
            
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authResult, error) in
            guard error == nil else {
                print("failed to login user")
                return
            }
            
            // retrive and return user from postgres database
            self.call(type: EndpointItem.login, params: parameters, completion: completion)
        })
    }
    
    func registerUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping(User?) -> Void) {
        let parameters: Parameters = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
            guard error == nil else {
                print("failed to login user")
                return
            }
            
            // store user in postgres
            self.call(type: EndpointItem.register, params: parameters, completion: completion)
        }
        )
    }
    
    func logoutUser(completion: @escaping(Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let signOutError as NSError {
            completion(false)
            print("Error signing out: %@", signOutError)
        }
    }
    
}

