//
//  PostModel.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import Foundation
import UIKit
import ReactiveSwift
class PostsViewModel: NSObject {
    let localDataManager = LocalDataManager()
    var users: [User] = []
    private (set) var posts: [Posts] = [] {
        didSet {
            receivedPosts.value = true
        }
    }
    var receivedPosts: MutableProperty<Bool?> = MutableProperty(nil)
    override init() {
        super.init()
        self.getPosts()
    }
    /// Mark: check if posts are saved locally, else load from API
    func getPosts() {
        do {
            try self.posts = localDataManager.loadPosts()
        } catch {
            print(error.localizedDescription)
            getPostsFromAPI()
        }
    }
    
    func getUsers() {
        do {
            try self.users = localDataManager.loadUser()
        } catch {
            print(error.localizedDescription)
            getUsersFromAPI()
        }
    }
    
    func addUserToPost() {
        guard users.count > 0 && posts.count > 0 else { return }
        var updatedPosts: [Posts] = []
        posts.forEach { (post) in
            post.userName = self.users.filter{$0.id == post.id}.first?.name ?? ""
            updatedPosts.append(post)
        }
        try? self.localDataManager.savePosts(posts: updatedPosts)
        self.receivedPosts.value = true
    }
    
 
    // Mark: firing api to get users and save them locally + filtering the required user
    func getUsersFromAPI() {
        NetworkServiceManager.sharedInstance.getUsers { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                try? self.localDataManager.saveUsers(user: users)
                self.users = users
                self.addUserToPost()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Mark: Getting posts from the API, and save them locally
    func getPostsFromAPI() {
        NetworkServiceManager.sharedInstance.getPosts {[weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let posts):
                self.posts = posts
                self.getUsers()
            case .failure(let error):
                print(error)
            }
        }
    }
    /// Mark: getting number of rows
    func getNumberOfRows() -> Int {
        return posts.count
    }
    /// Mark: getting Post object by index path
    func getPostForIndexPath(index: Int) -> Posts {
        return posts[index]
    }
    
    func getUserById(postId: Int) -> User? {
        if let user = users.filter({$0.id == postId}).first {
            return user
        }
        return nil       
    }
    
}
