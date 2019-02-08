//
//  Classes.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/7/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import Foundation


enum PostType: String {
    case image = "image"
}

enum CellID: String {
    case post = "post-cell"
}

enum ViewControllerID: String {
    case postDetail = "post-detail-vc"
}

enum StoryBoardID: String {
    case main = "Main"
}

enum ViewControllerTitle: String {
    case main = "/r/all"
}

struct Endpoint {
    static let posts = "https://www.reddit.com/r/all/top/.json?limit=50"
}

