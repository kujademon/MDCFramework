//
//  PeachViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class PeachViewController: UIViewController {
    
    // MARK: - Properties
    
    
    lazy var imageView: UIImageView = {
        [unowned self] in
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Peach"))
        
        // We want the image to be scaled to the correct aspect ratio within imageView's bounds.
        imageView.contentMode = .scaleAspectFit
        
        /** If the image does not have the same aspect ratio as imageView's bounds,
         then imageView's backgroundColor will be applied to the "empty" space.
         */
        imageView.backgroundColor = UIColor.white
        
        return imageView
        
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = imageView
        self.view.accessibilityIdentifier = "PeachVC"
    }

   

}
