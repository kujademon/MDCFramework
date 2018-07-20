//
//  CustomToolbarViewController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class CustomToolbarViewController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var toolbar: UIToolbar = {
        [unowned self] in
        
        let toolbar = UIToolbar()
        
        let toolbarBackgroundImage = UIImage(named: "toolbar_background")
        toolbar.setBackgroundImage(toolbarBackgroundImage, forToolbarPosition: .bottom, barMetrics: .default)
        
        let toolbarButtonItems = [
            customImageBarButtonItem,
            flexibleSpaceBarButtonItem,
            customBarButtonItem
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
        
        return toolbar
        
        }()
    
    // MARK: - UIBarButtonItem Creation and Configuration
    
    var customImageBarButtonItem: UIBarButtonItem {
        let customBarButtonItemImage = #imageLiteral(resourceName: "tools_icon")
        
        let customImageBarButtonItem = UIBarButtonItem(image: customBarButtonItemImage,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(CustomToolbarViewController.barButtonItemClicked(_:)))
        
        customImageBarButtonItem.tintColor = .tintPurple()
        
        return customImageBarButtonItem
    }
    
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        // Note that there's no target/action since this represents empty space.
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    var customBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: NSLocalizedString("Button", comment: ""),
                                            style: .plain,
                                            target: self,
                                            action: #selector(CustomToolbarViewController.barButtonItemClicked(_:)))
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.tintPurple()
        ]
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        
        return barButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupView()
    }
    
    fileprivate func setupView(){
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        
        view.addSubview(toolbar)
        
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: toolbar, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:[v0]-bottom-|", to: toolbar, constraintCollector: &constraintCollector)
        
        
    }
    
    // MARK: - Actions
    
    @objc
    func barButtonItemClicked(_ barButtonItem: UIBarButtonItem) {
        print("A bar button item on the custom toolbar was clicked: \(barButtonItem).")
    }


}
