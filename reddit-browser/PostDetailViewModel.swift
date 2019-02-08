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
    
    
    
}
