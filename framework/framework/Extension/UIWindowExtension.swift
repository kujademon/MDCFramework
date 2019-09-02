//
//  UIWindowExtension.swift
//  busProject
//
//  Created by Pitchaorn on 15/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot)
        self.addSubview(snapshotImageView)
        
        let dismissCompletion = { () -> Void in // dismiss all modal view controllers
            self.rootViewController = replacementController
            self.bringSubviewToFront(snapshotImageView)
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                }, completion: { (success) -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            }
            else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        if self.rootViewController!.presentedViewController != nil {
            guard let root = rootViewController else{
                return
            }
            root.dismissMe(animated: true, completion: nil)
            dismissCompletion()
        }
        else {
            dismissCompletion()
        }
    }
}
