//
//  PostViewModel.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/4/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import Foundation

class PostViewModel {
    var post:Post?
    var data:Data?
    
    var commentString: String {
        if let post = post {
            let num = post.data.num_comments
            return "\(num) comments"
        }
        return "- comments"
    }
    
    var time: String {
        let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
        let nowTime = Int(timeInSeconds)
        if let post = post {
            let postTime = post.data.created_utc
            let diff = nowTime - postTime
            let minutes = diff / 60
            let hours = minutes / 60
            return "\(hours) hours ago"
        }

        return "- ago"
    }
    
    func requestData(completion: @escaping(Data) -> Void) {

        if let post = post {
            let url = URL(string: post.data.url)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if let data = data {
                    self.data = data
                    completion(data)
                }
                
            }
            task.resume()
            
        }

    }
}
