//
//  PostDetailViewController.swift
//  reddit-browser
//
//  Created by Peisen Xue on 2/6/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    var post: Post?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setImage()
    }
    
    // Takes an instance of Post and sets the UI of the cell
    func setImage() {

        if let post = self.post {
            if let data = post.data.post_data {
                imageView.image = UIImage(data: data)
            } else {
                imageView.image = nil
            }
        }

    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
