//
//  AppDelegateExtension.swift
//  framework
//
//  Created by Pitchaorn on 2/9/2562 BE.
//  Copyright © 2562 freewillsolutions. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
//    var rootViewController: RootViewController {
//        return window!.rootViewController as! RootViewController
//    }
}
