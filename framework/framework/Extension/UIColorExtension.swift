//
//  UIColorExtension.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func tintBlue() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "Tint_Blue_Color")!
        } else {
            // Fallback on earlier versions
            return .blue
        }
    }


    static func tintPurple() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "Tint_Purple_Color")!
        } else {
            // Fallback on earlier versions
            return .purple
        }
    }
    
    static func tintGreen() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "Tint_Green_Color")!
        } else {
            // Fallback on earlier versions
            return .green
        }
    }
    
}
