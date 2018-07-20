//
//  TabbarCustomController.swift
//  framework
//
//  Created by Pitchaorn on 8/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class TabbarCustomController: UITabBarController {
    
    // MARK: Properties
    
    var arrayOfImageNameForUnselectedState = ["LeaveTabAll","LeaveTabApprove"]
    var arrayOfImageNameForSelectedState = ["LeaveTabAllActive","LeaveTabApproveActive"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbar()
    }

    fileprivate func setupTabbar() {
        
        self.tabBar.barTintColor = UIColor.tintGreen()
        
        
        let firstViewController = firstVC()
        firstViewController.view.backgroundColor = .white
        
        let secondViewController = secondVC()
        secondViewController.view.backgroundColor = .yellow
        
        let tabBarList = [firstViewController, secondViewController]
        
        viewControllers = tabBarList
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].title = ""
                self.tabBar.items?[i].imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            }
            
        }
    }

}
