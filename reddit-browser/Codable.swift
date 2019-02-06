//
//  Codable.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/4/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import Foundation

struct PostResponse: Codable {
    var kind: String
    var data: ResponseData
}


struct ResponseData: Codable {
    var children: [Post]
}


struct Post: Codable {
    var kind: String
    var data: PostDetail
}


struct PostDetail: Codable {
    var title: String
    var author: String
    var url: String
    var post_hint: String?
    var created_utc: Int
    var num_comments: Int
    var post_data: Data?
}
