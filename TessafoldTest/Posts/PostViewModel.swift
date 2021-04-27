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
    
    func getPosts() {
        do {
            try self.posts = localDataManager.loadPosts()
        } catch {
            print(error.localizedDescription)
            getpostsFromAPI()
        }
    }
    
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
    
    func getNumberOfRows() -> Int {
        return posts.count
    }
    
    func getPostForIndexPath(index: Int) -> Posts {
        return posts[index]
    }
    
}
