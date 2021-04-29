//
//  PostDetailsViewController.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import UIKit

class PostDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var postDetailsViewModel : PostDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    static func create(postDetailsViewModel: PostDetailsViewModel) -> PostDetailsViewController {
        let sb = UIStoryboard(name: "Posts", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PostDetailsViewController") as! PostDetailsViewController
        vc.postDetailsViewModel = postDetailsViewModel
        return vc
    }
    
    /// screen back button tapped
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /// Mark: setting UI configurations
    func setUI() {
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.register(UINib(nibName: "GeneralInformationCell", bundle: nil), forCellReuseIdentifier: "GeneralInformationCell")
        tableView.tableFooterView = UIView()
        postDetailsViewModel.receivedUser.producer.startWithValues { [weak self] (value) in
            guard let self = self else { return }
            switch value {
            case true: self.tableView.reloadData()
            default: print("Error Message")
            }
        }
        postDetailsViewModel.receivedComments.producer.startWithValues { [weak self] (value) in
            guard let self = self else { return }
            switch value {
            case true: self.tableView.reloadData()
            default: print("Error Message")
            }
        }
    }
}

/// Mark: tableView data source and delefate functions
extension PostDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDetailsViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentCell
        let generalInfoCell = tableView.dequeueReusableCell(withIdentifier: "GeneralInformationCell") as? GeneralInformationCell
        cell?.selectionStyle = .none
        generalInfoCell?.selectionStyle = .none
        switch indexPath.row {
        case 0:
            generalInfoCell?.post = postDetailsViewModel.selectedPost
            generalInfoCell?.user = postDetailsViewModel.user
            return generalInfoCell!
        default:
            cell?.comment = postDetailsViewModel.getCommentByIndex(index: indexPath.row)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
