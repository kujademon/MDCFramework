//
//  NSMutableAttributedString.swift
//  busProject
//
//  Created by Pitchaorn on 6/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
    }
    
}
