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
    var selectedPost: Posts?
    var user: User?
    var receivedComments: MutableProperty<Bool?> = MutableProperty(nil)
    var receivedUser: MutableProperty<Bool?> = MutableProperty(nil)
    var rowHeight: CGFloat = 60.0
    private (set) var comments: [Comment] = [] {
        didSet {
            receivedComments.value = true
        }
    }

    override init() {
        super.init()
        getComments()
        getUsers()
    }
    
    func getComments() {
        NetworkServiceManager.sharedInstance.getComments { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let comments):
                self.comments = comments.filter{$0.postId == self.selectedPost?.id}
                self.receivedComments.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUsers() {
        do {
            try self.user = localDataManager.loadUser().filter {$0.id == selectedPost?.id}.first
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
    
    func generateGeneralInformationCell() -> (Posts?, User?) {
        return (selectedPost, user)
    }
}
