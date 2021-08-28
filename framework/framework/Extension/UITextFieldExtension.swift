//
//  UITextFieldExtension.swift
//  smartbeyond
//
//  Created by patchara_suk on 4/19/2561 BE.
//  Copyright © 2561 Freewillsolutions. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0
private var numFlag: Bool = false
private var engFlag: Bool = false

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
    
    var numberOnly: Bool {
        get {
            if let flag = objc_getAssociatedObject(self, &numFlag) as? Bool {
                return flag
            } else {
                return false
            }
            
        }
        set {
            objc_setAssociatedObject(self, &numFlag, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkNumber), for: .editingChanged)
        }
    }
    
    @objc func checkNumber(textField: UITextField) {
        guard let prospectiveText = self.text
            else {
                return
        }
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: prospectiveText)
        if allowedCharacters.isSuperset(of: characterSet){
            text = String(prospectiveText)
        }else{
            let newstr = String(prospectiveText.dropLast())
            text = newstr
        }
        
        
    }
    
    var ignoreEng: Bool {
        get {
            if let flag = objc_getAssociatedObject(self, &engFlag) as? Bool {
                return flag
            } else {
                return true
            }
            
        }
        set {
            objc_setAssociatedObject(self, &engFlag, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkEng), for: .editingChanged)
        }
    }
    
    @objc func checkEng(textField: UITextField) {
        guard let prospectiveText = self.text
            else {
                return
        }
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: prospectiveText)
        if !allowedCharacters.isSuperset(of: characterSet){
            text = String(prospectiveText)
        }else{
            let newstr = String(prospectiveText.dropLast())
            text = newstr
        }
        
        
    }
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @objc var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
    
    
}
