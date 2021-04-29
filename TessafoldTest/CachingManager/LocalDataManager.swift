//
//  CachingManager.swift
//  TessafoldTest
//
//  Created by Ali jaber on 26/04/2021.
//

import Foundation
import UIKit
public class LocalDataManager {
    private let usersKey = "users_key"
    private let postKey = "post_key"
    private let commentsKey = "comments_key"
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    public func savePosts(comments: [Posts]) throws {
        let data = try encoder.encode(comments)
        userDefaults.set(data, forKey: postKey)
    }
    
    /// Mark: saving users locally
    public func saveUsers(user: [User]) throws {
        let data = try encoder.encode(user)
        userDefaults.set(data, forKey: usersKey)
    }
    
    /// Mark: get users from local storage, throw an error if issue occured
    public func loadUser() throws -> [User] {
        guard let data = userDefaults.data(forKey: usersKey), let users = try? decoder.decode([User].self, from: data) else {
            throw Error.usersNotFound
        }
        return users
    }
    
    /// Mark: save commetnts locally
    public func saveComments(comments: [Comment]) throws {
        let data = try encoder.encode(comments)
        userDefaults.set(data, forKey: commentsKey)
    }
    
    ////// Mark: get posts saved locally, if issue occured, throw an error
    public func loadComments() throws ->[Comment] {
        guard let data = userDefaults.data(forKey: commentsKey), let comments = try? decoder.decode([Comment].self, from: data) else {
            throw Error.usersNotFound
        }
        return comments
    }
    
    /// Mark: loading posts saved locally, if issue occured, throw an error
    public func loadPosts() throws -> [Posts] {
        guard let data = userDefaults.data(forKey: postKey), let posts = try? decoder.decode([Posts].self, from: data) else {
            throw Error.commentsNotFound
        }
        return posts
    }
    
    public enum Error: String, Swift.Error {
        case PostsNotFound
        case usersNotFound
        case commentsNotFound
    }
}
