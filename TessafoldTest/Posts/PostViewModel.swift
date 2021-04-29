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
    private (set) var posts: [Posts] = [] {
        didSet {
            receivedPosts.value = posts
        }
    }
    var receivedPosts: MutableProperty<[Posts]?> = MutableProperty(nil)
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
            getpostsFromAPI()
        }
    }
    
    /// Mark: Getting posts from the API, and save them locally
    func getpostsFromAPI() {
        NetworkServiceManager.sharedInstance.getPosts {[weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let posts):
                try? self.localDataManager.savePosts(comments: posts)
                self.getPosts()
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
    
}
