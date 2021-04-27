//
//  CommentCell.swift
//  TessafoldTest
//
//  Created by Ali jaber on 26/04/2021.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    var comment: Comment? {
        didSet {
            setUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI() {
        if let comment = comment?.body {
            commentLabel.text = comment
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
