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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    // Takes an instance of Post and sets the UI of the cell
    func loadData() {

        imageView.image = postDetailViewModel.getImage()


    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
