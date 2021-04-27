//
//  PostsCell.swift
//  TessafoldTest
//
//  Created by Ali jaber on 25/04/2021.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postIdLabel: UILabel!
    var post: Posts? {
        didSet {
            fillUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillUI() {
        if let post = post, let id = post.id, let title = post.title {
            postIdLabel.text = "Post id: \(String(id))" 
            postTitleLabel.text = title
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
