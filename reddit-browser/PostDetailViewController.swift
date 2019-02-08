//
//  PostDetailViewController.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/6/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    var postDetailViewModel = PostDetailViewModel()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    // Sets UI from the ViewModel
    func loadData() {

        imageView.image = postDetailViewModel.getImage()
        timeLabel.text = postDetailViewModel.formatTimeString()
        userLabel.text = postDetailViewModel.getName()
        commentLabel.text = postDetailViewModel.getComment()
        titleLabel.text = postDetailViewModel.getTitle()
        
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
