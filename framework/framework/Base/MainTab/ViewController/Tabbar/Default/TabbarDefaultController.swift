//
//  TabbarDefaultController.swift
//  framework
//
//  Created by Pitchaorn on 7/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class TabbarDefaultController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let base = UIApplication.shared.delegate?.window??.rootViewController,let tab = base as? UITabBarController{
            tab.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        let firstViewController = firstVC()
        firstViewController.view.backgroundColor = .red
        
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController = secondVC()
        secondViewController.view.backgroundColor = .purple
        
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]
        
        viewControllers = tabBarList
    }

   
   

}
