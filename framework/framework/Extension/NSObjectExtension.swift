//
//  NSObjectExtension.swift
//  framework
//
//  Created by Pitchaorn on 3/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

extension NSObject {
    
    func viewControllerFromString(viewControllerName: String) -> UIViewController? {
        
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
//            print("CFBundleName - \(appName)")
            if let viewControllerType = NSClassFromString("\(appName).\(viewControllerName)") as? UIViewController.Type {
                return viewControllerType.init()
            }
        }
        
        return nil
    }
    
}
