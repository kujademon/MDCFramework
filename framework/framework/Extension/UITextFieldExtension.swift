//
//  UITextFieldExtension.swift
//  smartbeyond
//
//  Created by patchara_suk on 4/19/2561 BE.
//  Copyright © 2561 Freewillsolutions. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    func underlined(){
        let border = CALayer()
        let lineWidth = CGFloat(1)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    //The method is used to cancel the check when use Chinese Pinyin input method.
    //Becuase the alphabet also appears in the textfield when inputting, we should cancel the check.
    func isInputMethod() -> Bool {
        if let positionRange = self.markedTextRange {
            if let _ = self.position(from: positionRange.start, offset: 0) {
                return true
            }
        }
        return false
    }
    
    
    @objc func checkMaxLength(textField: UITextField) {
        
        guard !self.isInputMethod(), let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText[..<maxCharIndex])
        selectedTextRange = selection
    }
    
    
    
    
}
