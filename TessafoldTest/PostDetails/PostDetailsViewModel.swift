//
//  PostDetailsViewModel.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import Foundation
import ReactiveSwift
class PostDetailsViewModel: NSObject {
    let localDataManager = LocalDataManager()
    var selectedPost: Posts? {
        didSet {
            getComments()
            getUsers()
        }
    }
    var user: User?
    var receivedComments: MutableProperty<Bool?> = MutableProperty(nil)
    var receivedUser: MutableProperty<Bool?> = MutableProperty(nil)
    private (set) var comments: [Comment] = [] {
        didSet {
            receivedComments.value = true
        }
    }
    
    override init() {
        super.init()
    }
    
    func getCommentsFromAPI() {
        NetworkServiceManager.sharedInstance.getComments { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let comments):
                try? self.localDataManager.saveComments(comments: comments)
                self.comments = comments.filter{$0.postId == self.selectedPost?.id}
                self.receivedComments.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getComments() {
        do {
            try self.comments = localDataManager.loadComments().filter{$0.postId == selectedPost?.id}
            self.receivedComments.value = true
        } catch  {
            print(error.localizedDescription)
            getCommentsFromAPI()
        }
    }
    
    func getUsers() {
        do {
            try self.user = localDataManager.loadUser().filter {$0.id == selectedPost?.id}.first
            self.receivedUser.value = true
        } catch {
            print(error.localizedDescription)
            getUserFromAPI()
        }
    }
    
    func getUserFromAPI() {
        NetworkServiceManager.sharedInstance.getUsers { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                try? self.localDataManager.saveUsers(user: users)
                let filteredUser = users.filter {$0.id == self.selectedPost?.id}.first
                self.user = filteredUser
                self.receivedUser.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return comments.count + 1
    }
    
    func getCommentByIndex(index: Int) -> Comment {
        return comments[index - 1]
    }
}
