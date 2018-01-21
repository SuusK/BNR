//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Susan Kamies on 21/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    @IBOutlet var viewsLabel: UILabel!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
                self.viewsLabel.text = String("Number of views: \(self.photo.views)")

            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        
        }
    }
}
