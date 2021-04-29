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
        }
    }
    var receivedComments: MutableProperty<Bool?> = MutableProperty(nil)
    private (set) var comments: [Comment] = [] {
        didSet {
            receivedComments.value = true
        }
    }
    
    override init() {
        super.init()
    }
    
    /// Mark: getting comments from api and save them locally, also extracting the required
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
    /// Mark: checking if comments exist locally and if not, trigger api call
    func getComments() {
        do {
            try self.comments = localDataManager.loadComments().filter{$0.postId == selectedPost?.id}
            self.receivedComments.value = true
        } catch  {
            print(error.localizedDescription)
            getCommentsFromAPI()
        }
    }
   
    /// Mark: getting number of rows
    func numberOfRows() -> Int {
        return comments.count + 1
    }
    /// Mark: getting comments by index path
    func getCommentByIndex(index: Int) -> Comment {
        return comments[index - 1]
    }
}
