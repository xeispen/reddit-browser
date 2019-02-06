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
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.darkGray
        self.view.bringSubviewToFront(activityIndicator)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        activityIndicator.startAnimating()
        mainViewModel.requestData() { (response) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.mainViewModel.populateImages() { array in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                
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
        
        if post.data.post_data != nil {
            return UITableView.automaticDimension
        } else {
            return 90
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let post = mainViewModel.postArray[indexPath.row]
//
//        mainViewModel.fetchData(post: post){ data in
//            self.mainViewModel.postArray[indexPath.row].data.post_data = data
//        }
//    }

}

