//
//  NetworkServiceManager.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import Foundation
import Alamofire

class NetworkServiceManager: NSObject {
    static let sharedInstance: NetworkServiceManager = NetworkServiceManager()
    let sessionManager: Session!
    private override init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.urlCache?.removeAllCachedResponses()
        sessionConfiguration.urlCache = nil
        sessionManager = Session(configuration: sessionConfiguration)
        super.init()
    }
    
    func getPosts(completion: @escaping(Swift.Result<[Posts],ServiceResponseError>) -> ()) {
        self.sessionManager.request(ServiceManager.getPosts).validate().responseJSON { (result) in
            if result.error == nil {
                if let value = result.value as? [[String: Any]] {
                    var postsArray = [Posts]()
                    value.forEach { (post) in
                        let post = Posts.init(with: post)
                        postsArray.append(post)
                    }
                    completion(.success(postsArray))
                }
            }
            else {
                completion(.failure(.init(error: result.error as NSError?)))
            }
        }
    }
    
    func getComments(completion: @escaping(Swift.Result<[Comment],ServiceResponseError>) -> ()) {
        self.sessionManager.request(ServiceManager.getComments).validate().responseJSON { (result) in
            if result.error == nil {
                if let value = result.value as? [[String: Any]] {
                    var commentsArray = [Comment]()
                    value.forEach { (comment) in
                        let post = Comment.init(with: comment)
                        commentsArray.append(post)
                    }
                    completion(.success(commentsArray))
                }
            }
            else {
                completion(.failure(.init(error: result.error as NSError?)))
            }
        }
    }
    
    func getUsers(completion: @escaping(Swift.Result<[User],ServiceResponseError>) -> ()) {
        self.sessionManager.request(ServiceManager.getUsers).validate().responseJSON { (result) in
            if result.error == nil {
                if let value = result.value as? [[String: Any]] {
                    var usersArray = [User]()
                    value.forEach { (user) in
                        let post = User.init(with: user)
                        usersArray.append(post)
                    }
                    completion(.success(usersArray))
                }
            }
            else {
                completion(.failure(.init(error: result.error as NSError?)))
            }
        }
    }
}

enum ServiceResponseError: Error {
    case unknown
    case notConnectedToInternet
    init(error: NSError? = nil) {
        if let error = error{
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorTimedOut,
                     NSURLErrorNetworkConnectionLost,
                     NSURLErrorCannotFindHost,
                     NSURLErrorCannotConnectToHost,
                     NSURLErrorDNSLookupFailed,
                     NSURLErrorDNSLookupFailed,
                     NSURLErrorNotConnectedToInternet,
                     NSURLErrorInternationalRoamingOff:
                    self = .notConnectedToInternet
                default:
                    self = .unknown
                }
            } else {
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }
}

