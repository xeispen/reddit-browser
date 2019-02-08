//
//  PostDetailViewModel.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/8/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import Foundation
import UIKit

class PostDetailViewModel {
    var post: Post?
    
    func getImage() -> UIImage? {
        if let post = self.post {
            if let data = post.data.post_data {
                return UIImage(data: data)
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    func formatTimeString() -> String {
        
        if let post = post {
            let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
            let nowTime = Int(timeInSeconds)
            let postTime = post.data.created_utc
            let diff = nowTime - postTime
            let hours = diff / (60 * 60)
            return "\(hours) hours ago"
        } else {
            return "-"
        }

    }
    
    func getName() -> String {
        if let post = post {
            return post.data.author
        } else {
            return "-"
        }
    }
    

    func getComment() -> String {
        if let post = post {
            return "\(post.data.num_comments) comments"
        } else {
            return "-"
        }
    }
    
    func getTitle() -> String {
        if let post = post {
            return post.data.title
        } else {
            return "-"
        }
    }
    
}
