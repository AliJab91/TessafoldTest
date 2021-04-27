//
//  Models.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import Foundation

public class Posts: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    init (with json: [String: Any]) {
        userId = json["userId"] as? Int
        id = json["id"] as? Int
        title = json["title"] as? String
        body = json["body"] as? String
    }
}

public class User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    init(with json: [String: Any]) {
        id = json["id"] as? Int
        name =  json["username"] as? String
        username =  json["username"] as? String
        email =  json["email"] as? String
        if let addressObject = json["address"] as? [String: Any] {
            address = Address.init(with: addressObject)
        } else {
            address = nil
        }
        phone = json["phone"] as? String
        website = json["website"] as? String
    }
}

public class Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipCode: String?
    init(with json: [String: Any]) {
       street = json["street"] as? String
       suite = json["suite"] as? String
       city = json["city"] as? String
       zipCode = json["zipcode"] as? String
    }
}

public class Comment: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
    init(with json: [String: Any]) {
        postId = json["postId"] as? Int
        id = json["id"] as? Int
        name = json["name"] as? String
        email = json["email"] as? String
        body = json["body"] as? String
    }
}
