//
//  ImageViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - Properties
    
    
    lazy var imageView: UIImageView = {
        [unowned self] in
        
        let imageView = UIImageView()
        
        return imageView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view = imageView
        configureImageView()
        
        
    }

    
    
    // MARK: - Configuration
    
    func configureImageView() {
        // The root view of the view controller set in Interface Builder is a UIImageView.
        if let imageView = view as? UIImageView {
            // Fetch the images (each image is of the format Flowers_number).
            imageView.animationImages = (1...5).map { UIImage(named: "Flowers_\($0)")! }
            
            // We want the image to be scaled to the correct aspect ratio within imageView's bounds.
            imageView.contentMode = .scaleAspectFit
            
            /** If the image does not have the same aspect ratio as imageView's bounds,
             then imageView's backgroundColor will be applied to the "empty" space.
             */
            imageView.backgroundColor = UIColor.white
            
            imageView.animationDuration = 5
            imageView.startAnimating()
            
            imageView.isAccessibilityElement = true
            imageView.accessibilityLabel = NSLocalizedString("Animated", comment: "")
        }
    }

}
