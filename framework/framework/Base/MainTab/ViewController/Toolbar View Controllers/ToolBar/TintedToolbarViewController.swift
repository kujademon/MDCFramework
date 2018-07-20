//
//  TintedToolbarViewController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class TintedToolbarViewController: UIViewController {
   
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var toolbar: UIToolbar = {
        [unowned self] in
        
        let toolbar = UIToolbar()
        
        // See the `UIBarStyle` enum for more styles, including `.Default`.
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        
        toolbar.tintColor = .tintGreen()
        toolbar.backgroundColor = .tintBlue()
        
        let toolbarButtonItems = [
            refreshBarButtonItem,
            flexibleSpaceBarButtonItem,
            actionBarButtonItem
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
        
        return toolbar
        
        }()
    
    // MARK: - `UIBarButtonItem` Creation and Configuration
    
    var refreshBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .refresh,
                               target: self,
                               action: #selector(TintedToolbarViewController.barButtonItemClicked(_:)))
    }
    
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        // Note that there's no target/action since this represents empty space.
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                               target: nil,
                               action: nil)
    }
    
    var actionBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .action,
                               target: self,
                               action: #selector(TintedToolbarViewController.barButtonItemClicked(_:)))
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
        print("A bar button item on the tinted toolbar was clicked: \(barButtonItem).")
    }
}
