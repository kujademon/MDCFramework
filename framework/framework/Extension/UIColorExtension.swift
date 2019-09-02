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
    
    @nonobjc
    static var lightGreen = {
        
        return #colorLiteral(red: 0.2117647059, green: 0.7607843137, blue: 0.6274509804, alpha: 1)
    }()
    
    @nonobjc
    static var darkGreen = {
        
        return #colorLiteral(red: 0.2274509804, green: 0.5490196078, blue: 0.5176470588, alpha: 1)
    }()
    
    @nonobjc
    static var lightBlack = {
        
        return #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    }()
    
    @nonobjc
    static var a1Gray = {
        
        return #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
    }()
    
    @nonobjc
    static var yellowBus = {
        
        return #colorLiteral(red: 1, green: 0.6, blue: 0, alpha: 1)
    }()
    
    class func creatImageWithColor(color:UIColor) -> UIImage{
        
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
    
}
