//
//  MainTabbarController.swift
//  framework
//
//  Created by Pitchaorn on 10/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaultViewController = DefaultViewController()
        
        defaultViewController.tabBarItem = UITabBarItem(title: "Default", image: nil, tag: 0)
        
        let customViewController = CustomViewController()
        
        customViewController.tabBarItem = UITabBarItem(title: "Custom", image: nil, tag: 1)
        
        
        let tabBarList = [defaultViewController, customViewController]
        
        viewControllers = tabBarList
    }

    

}
