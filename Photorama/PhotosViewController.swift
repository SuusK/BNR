//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Susan Kamies on 16/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    @IBAction func interestingPhotos(_ sender: UIBarButtonItem) {
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Succesfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching intersting photos: \(error)")
            }
        }
    }
    
    
    @IBAction func recentPhotos(_ sender: UIBarButtonItem) {
        store.fetchRecentPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Succesfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching intersting photos: \(error)")
            }
        }
    }
    
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image): self.imageView.image = image
            case let .failure(error): print("Error downloading image \(error)")
            }
        }
    }
}
