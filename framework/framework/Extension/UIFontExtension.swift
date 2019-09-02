//
//  UIFontExtension.swift
//  smartbeyond
//
//  Created by patchara_suk on 5/3/2561 BE.
//  Copyright © 2561 Freewillsolutions. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func RSU(size:CGFloat) -> UIFont {
        let font = UIFont(name: "RSU", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    class func RSUBold(size:CGFloat) -> UIFont {
        let font = UIFont(name: "RSU-Bold", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    class func RSULight(size:CGFloat) -> UIFont {
        let font = UIFont(name: "RSU-Light", size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    /**
     Will return the best approximated font size which will fit in the bounds.
     If no font with name `fontName` could be found, nil is returned.
     */
    static func bestFitFontSize(for text: String, in bounds: CGRect, fontName: String) -> CGFloat? {
        var maxFontSize: CGFloat = 32.0 // UIKit best renders with factors of 2
        guard let maxFont = UIFont(name: fontName, size: maxFontSize) else {
            return nil
        }
        
        let textWidth = text.width(withConstraintedHeight: bounds.height, font: maxFont)
        let textHeight = text.height(withConstrainedWidth: bounds.width, font: maxFont)
        
        // Determine the font scaling factor that should allow the string to fit in the given rect
        let scalingFactor = min(bounds.width / textWidth, bounds.height / textHeight)
        
        // Adjust font size
        maxFontSize *= scalingFactor
        
        return floor(maxFontSize)
    }
    
    public enum KanitType: String {
        case Medium = "-Medium"
        case Black = "-Black"
        case Light = "-Light"
        case SemiBold = "-SemiBold"
        case Regular = "-Regular"
        case ExtraBold = "-ExtraBold"
        case ThinItalic = "-ThinItalic"
        case LightItalic = "-LightItalic"
        case ExtraLightItalic = "-ExtraLightItalic"
        case MediumItalic = "-MediumItalic"
        case Bold = "-Bold"
        case BoldItalic = "-BoldItalic"
        case SemiBoldItalic = "-SemiBoldItalic"
        case ExtraLight = "-ExtraLight"
        case Thin = "-Thin"
        case ExtraBoldItalic = "-ExtraBoldItalic"
        
    }
    
    
    static func Kanit(_ type: KanitType = .Regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Kanit\(type.rawValue)", size: size)!
    }
    
    static func kanitType(_ type:KanitType) -> String {
        return "Kanit\(type.rawValue)"
    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
}
    

