//
//  PostCell.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/4/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {


    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Takes an instance of Post and sets the UI of the cell
    func setPostData(post: Post) {
        titleLabel.text = post.data.title
        userLabel.text = post.data.author
        commentLabel.text = "\(post.data.num_comments) comments"
        timeLabel.text = formatTimeString(post: post)

        if let data = post.data.post_data {
            previewImageView.image = UIImage(data: data)
        } else {
            previewImageView.image = nil
        }

    }
    
    private func formatTimeString(post: Post) -> String {

        let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
        let nowTime = Int(timeInSeconds)
        let postTime = post.data.created_utc
        let diff = nowTime - postTime
        let hours = diff / (60 * 60)
        return "\(hours) hours ago"

    }

    
    
    
}
