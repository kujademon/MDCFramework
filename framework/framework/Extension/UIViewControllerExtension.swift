//
//  UIViewControllerExtension.swift
//  smartbeyond
//
//  Created by patchara_suk on 4/20/2561 BE.
//  Copyright © 2561 Freewillsolutions. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
       
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAroundTableView() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // Do your thang here!
            self.view.endEditing(true)
            for textField in self.view.subviews where textField is UITextField {
                textField.resignFirstResponder()
            }
        }
        sender.cancelsTouchesInView = false
    }
}
