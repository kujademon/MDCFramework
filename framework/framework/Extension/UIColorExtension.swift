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
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
}
