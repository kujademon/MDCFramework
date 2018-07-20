//
//  DefaultToolbarViewController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class DefaultToolbarViewController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var toolbar: UIToolbar = {
        [unowned self] in
        
        let toolbar = UIToolbar()
        
        let toolbarButtonItems = [
            trashBarButtonItem,
            flexibleSpaceBarButtonItem,
            customTitleBarButtonItem
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
        
        return toolbar
        
    }()
    
    // MARK: - UIBarButtonItem Creation and Configuration
    
    var trashBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .trash,
                               target: self,
                               action: #selector(DefaultToolbarViewController.barButtonItemClicked(_:)))
    }
    
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                               target: nil,
                               action: nil)
    }
    
    var customTitleBarButtonItem: UIBarButtonItem {
        let customTitle = NSLocalizedString("Action", comment: "")
        return UIBarButtonItem(title: customTitle,
                               style: .plain,
                               target: self,
                               action: #selector(DefaultToolbarViewController.barButtonItemClicked(_:)))
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
        print("A bar button item on the default toolbar was clicked: \(barButtonItem).")
    }

}
