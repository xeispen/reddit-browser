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
    
    // Request data from reddit
    // TODO: Move this into a networking class and inject as dependency
    func requestData(completion: @escaping([Post]) -> Void) {

        let url = URL(string: Endpoint.posts)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Did not receive posts response")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Response code from server \(httpResponse.statusCode)")
                    return
                }
            }

            do {
                guard let postsResponse = try? JSONDecoder().decode(PostResponse.self, from: responseData) else {
                    print("Could not encode post responses")
                    return
                }
                
                self.postArray = postsResponse.data.children
                
                self.populateImages() { array in
                    completion(array)
                }

            }

        }
        task.resume()
        
    }
    
    // Loop through array and fetch images where applicable
    func populateImages(completion: @escaping([Post]) -> Void) {
        
        let dispatch = DispatchGroup()
        
        // Loop through array of posts to retrieve image
        for (index, post) in postArray.enumerated() {
            // Fetch data if it does not exists AND the post is an image
            if post.data.post_data == nil && post.data.post_hint == PostType.image.rawValue {
                dispatch.enter()

                // Fetch data for individual post
                self.fetchData(post: post){ data in
                    self.postArray[index].data.post_data = data
                    dispatch.leave()
                }
            }

        }
        
        // Call closure when all async calls have finished
        dispatch.notify(queue: .main) {
            print("Finished all requests.")
            completion(self.postArray)
        }
       
    }
    
    // Takes a post as input and returns imagedata as closure
    func fetchData(post: Post, completion: @escaping(Data) -> Void) {
        let url = URL(string: post.data.url)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Did not receive image data")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Response code from server \(httpResponse.statusCode)")
                    return
                }
            }
            
            completion(responseData)
        }
        task.resume()
            

    }
    
}
