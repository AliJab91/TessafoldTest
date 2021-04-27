//
//  PostsViewController.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import UIKit
import ReactiveSwift
class PostsViewController: UIViewController {
    private var postsViewModel: PostsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsViewModel = PostsViewModel()
        setUI()
    }
    
    func setUI() {
        tableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "PostsCell")
        tableView.tableFooterView = UIView()
        postsViewModel.receivedPosts.producer.startWithValues {[weak self] (posts) in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func presentDetailsView(post: Posts) {
        let detailsViewModel = PostDetailsViewModel()
        detailsViewModel.selectedPost = post
        let detailsVC = PostDetailsViewController.create(postDetailsViewModel: detailsViewModel)
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell") as? PostsCell
        cell?.post = postsViewModel.getPostForIndexPath(index: indexPath.row)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = postsViewModel.getPostForIndexPath(index: indexPath.row)
        presentDetailsView(post: selectedPost)
    }
}
