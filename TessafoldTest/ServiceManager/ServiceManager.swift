//
//  ServiceManager.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//
import Alamofire
import Foundation
enum ServiceManager: URLRequestConvertible {
    static var baseURL: String {
        return "http://jsonplaceholder.typicode.com/"
    }
    case getPosts
    case getUsers
    case getComments
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .getPosts:
            let url = NSURLComponents(string: "\(ServiceManager.baseURL)\(path)")!
            let request = createBaseRequest(baseUrl: url.url!.absoluteString, method: method)
            return try JSONEncoding.default.encode(request)
        case .getUsers:
            let url = NSURLComponents(string: "\(ServiceManager.baseURL)\(path)")!
            let request = createBaseRequest(baseUrl: url.url!.absoluteString, method: method)
            return try JSONEncoding.default.encode(request)
        case .getComments:
            let url = NSURLComponents(string: "\(ServiceManager.baseURL)\(path)")!
            let request = createBaseRequest(baseUrl: url.url!.absoluteString, method: method)
            return try JSONEncoding.default.encode(request)
        }
    }
    
    var path: String {
        switch self {
        case .getPosts: return "posts"
        case .getUsers: return "users"
        case .getComments: return "comments"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getPosts, .getUsers, .getComments: return .get
        }
    }
    
    func createBaseRequest(baseUrl: String, method: Alamofire.HTTPMethod) -> URLRequest {
        let url = URL(string: baseUrl)!
        var urlRequest = URLRequest(url:url)
        urlRequest.timeoutInterval = 25
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
