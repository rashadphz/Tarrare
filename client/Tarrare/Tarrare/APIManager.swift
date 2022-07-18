//
//  APIManager.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/7/22.
//

import Foundation
import Alamofire
import Apollo

import FirebaseAuth

class APIManager {
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://f036-2600-387-c-6c11-00-6.ngrok.io/graphql")!)
    
    private static var sharedAPIManager: APIManager = {
        let apiManager = APIManager()
        return apiManager
    }()
    
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    func processGraphQLResult<T>(key: String?, json: JSONObject?) -> T? where T: Decodable {
        guard let json = json else {
            return nil
        }
        
        let result: JSONObject = json
        var jsonObject: Any = result
        if let key = key, let keyedResult = result[key] {
            guard JSONSerialization.isValidJSONObject(keyedResult) else {
                if let keyedResult = keyedResult as? T {
                    return keyedResult
                }
                return nil
            }
            jsonObject = keyedResult
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let obj = try JSONDecoder().decode(T.self, from: jsonData)
            return obj
        } catch let error {
            print(error)
            return nil
        }
        
    }
    
    // Query
    func call<T: Decodable, Query: GraphQLQuery>(key: String, query: Query, cachePolicy : CachePolicy = .fetchIgnoringCacheCompletely, completion: @escaping(T?) -> Void) {
        
        
        apollo.fetch(query: query, cachePolicy: cachePolicy, resultHandler: {result in
            switch result {
            case .success(let graphQLResult):
                guard let object : T = self.processGraphQLResult(key: key, json: graphQLResult.data?.jsonObject as? JSONObject) else {
                    return
                }
                completion(object)
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    // Mutation
    func call<T: Decodable, Mutation: GraphQLMutation>(key: String, mutation: Mutation, completion: @escaping(T?) -> Void) {
        
        apollo.perform(mutation: mutation, resultHandler: {result in
            switch result {
            case .success(let graphQLResult):
                guard let object : T = self.processGraphQLResult(key: key, json: graphQLResult.data?.jsonObject as? JSONObject) else {
                    return
                }
                completion(object)
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    // Subscription
    func call<T: Decodable, Subscription: GraphQLSubscription>(subscription: Subscription, completion: @escaping(T?) -> Void) {
        // TODO(rashadphil): Handle GraphQL Subscriptions
    }
    
    
    func loginUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authResult, error) in
            guard error == nil else {
                print("Failed to login user: \(error?.localizedDescription)")
                return
            }
            
            self.call(key: "login", mutation: LoginUserMutation(email: email, password: password), completion: completion)
            
        })
    }
    
    func registerUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping(User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
            guard error == nil else {
                print("Failed to register user")
                return
            }
            
            self.call(key: "register", mutation: RegisterUserMutation(firstName: firstName, lastName: lastName, email: email, password: password), completion: completion)
        } )
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

