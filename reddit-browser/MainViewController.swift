//
//  ViewController.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/4/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var mainViewModel = MainViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setup subviews
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.darkGray
        self.view.bringSubviewToFront(activityIndicator)
        
        // Configure tableview delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // Configure tableview attributes
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 175

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadData()
    }
    
    func loadData() {
        // Show activity indicator while loading posts
        activityIndicator.startAnimating()
        
        // Request data from ViewModel
        mainViewModel.requestData() { (response) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post-cell") as! PostCell
        let post = mainViewModel.postArray[indexPath.row]
        cell.setPostData(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = mainViewModel.postArray[indexPath.row]
        
        // If the post has no image data to display, we display a smaller cell
        if post.data.post_data != nil {
            return 250
        } else {
            return 100
        }
    }
    

}

