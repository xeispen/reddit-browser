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
    var postViewController = PostDetailViewController()
    var refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setup subviews
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.darkGray
        self.view.bringSubviewToFront(activityIndicator)
        
        // Configure tableview delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // Configure refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        // Configure tableview
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        
        // Set title for navigation controller
        self.title = ViewControllerTitle.main.rawValue


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

    @objc func refresh() {

        // Show activity indicator while loading posts
        refreshControl.beginRefreshing()
        
        // Request data from ViewModel
        mainViewModel.requestData() { (response) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.post.rawValue) as! PostCell
        let post = mainViewModel.postArray[indexPath.row]
        cell.setPostData(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = mainViewModel.postArray[indexPath.row]
        let storyboard = UIStoryboard(name: StoryBoardID.main.rawValue, bundle: nil)
        let postViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerID.postDetail.rawValue) as! PostDetailViewController
        postViewController.post = post
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    

}

