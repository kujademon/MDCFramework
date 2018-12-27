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
}
    

