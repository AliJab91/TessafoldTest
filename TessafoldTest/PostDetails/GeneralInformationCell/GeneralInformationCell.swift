//
//  GeneralInformationCell.swift
//  TessafoldTest
//
//  Created by Ali jaber on 26/04/2021.
//

import UIKit

class GeneralInformationCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var usersNameLabel: UILabel!
    var post: Posts? {
        didSet {
            setPostUI()
        }
    }
    
    func setPostUI() {
        if let post = post {
            postTitleLabel.text = post.title
            postBodyLabel.text = post.body
            usersNameLabel.text = post.userName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
