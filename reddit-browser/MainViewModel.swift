//
//  MainViewModel.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/4/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import Foundation

class MainViewModel {
    
    var postArray:[Post] = []
    
    
    func requestData(completion: @escaping([Post]) -> Void) {
        let url = URL(string: "https://www.reddit.com/r/all/top/.json?count=50")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                let object = try? JSONDecoder().decode(PostResponse.self, from: data)
                
                if let posts = object?.data.children {
                    self.postArray = posts
                    completion(posts)
                }
            }

        }
        task.resume()
        
    }
    
}
