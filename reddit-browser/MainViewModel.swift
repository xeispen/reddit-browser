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

        let url = URL(string: "https://www.reddit.com/r/all/top/.json?limit=50")
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
    
    func populateImages(completion: @escaping([Post]) -> Void) {
        for (index, post) in postArray.enumerated() {
            self.fetchData(post: post){ data in
                self.postArray[index].data.post_data = data
            }
            if index == self.postArray.count - 1 {
                completion(self.postArray)
            }
        }
       
    }
    
    func fetchData(post: Post, completion: @escaping(Data) -> Void) {
        if post.data.post_data != nil || post.data.post_hint != "image" {
            return
        }

        let url = URL(string: post.data.url)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                completion(data)
            }
            
        }
        task.resume()
            

    }
    
}
