//
//  TextfieldTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

protocol TextFieldViewCellDelegate: AnyObject {
    
    func returnText(_ value: String)
    
}

class TextfieldTableViewCell: UITableViewCell {

   // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    let textfield : UITextField = {
       
        let textfield = UITextField()
        
        textfield.borderStyle = .roundedRect
        
        
        
        return textfield
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
           
            switch indexpath.section {
            case 0:
                configureTextField()
            case 1:
                configureTintedTextField()
            case 2:
                configureSecureTextField()
            case 3:
                configureSpecificKeyboardTextField()
            case 4:
                configureCustomTextField()
            default:
                return
            }
            
            
            setupViews()
        }
    }
    
    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(textfield)
        self.addConstraints(with: "H:|-50-[v0]-50-|", to: textfield, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0(30)]-16-|", to: textfield, constraintCollector: &constraintCollector)
        
    }
    
    // MARK: - Configuration
    
    func configureTextField() {
        textfield.placeholder = NSLocalizedString("Placeholder text", comment: "")
        textfield.autocorrectionType = .yes
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .never
    }
    
    func configureTintedTextField() {
        textfield.tintColor = .tintBlue()
        textfield.textColor = .tintGreen()
        
        textfield.placeholder = NSLocalizedString("Placeholder text", comment: "")
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .never
    }
    
    func configureSecureTextField() {
        textfield.isSecureTextEntry = true
        
        textfield.placeholder = NSLocalizedString("Placeholder text", comment: "")
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .always
    }
    
    /**    There are many different types of keyboards that you may choose to use.
     The different types of keyboards are defined in the `UITextInputTraits` interface.
     This example shows how to display a keyboard to help enter email addresses.
     */
    func configureSpecificKeyboardTextField() {
        textfield.keyboardType = .emailAddress
        
        textfield.placeholder = NSLocalizedString("Placeholder text", comment: "")
        textfield.returnKeyType = .done
    }
    
    func configureCustomTextField() {
        // Text fields with custom image backgrounds must have no border.
        textfield.borderStyle = .none
        
        textfield.background = UIImage(named: "text_field_background")
        
        /**    Create a purple button that, when selected, turns the custom text field's
         text color to purple.
         */
        let purpleImage = UIImage(named: "text_field_purple_right_view")!
        let purpleImageButton = UIButton(type: .custom)
        purpleImageButton.bounds = CGRect(x: 0, y: 0, width: purpleImage.size.width, height: purpleImage.size.height)
        purpleImageButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        purpleImageButton.setImage(purpleImage, for: .normal)
        purpleImageButton.addTarget(self, action: #selector(self.customTextFieldPurpleButtonClicked), for: .touchUpInside)
        textfield.rightView = purpleImageButton
        textfield.rightViewMode = .always
        
        // Add an empty view as the left view to ensure inset between the text and the bounding rectangle.
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftPaddingView.backgroundColor = UIColor.clear
        textfield.leftView = leftPaddingView
        textfield.leftViewMode = .always
        
        textfield.placeholder = NSLocalizedString("Placeholder text", comment: "")
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .done
    }
    
    // MARK: - Actions
    
    @objc
    func customTextFieldPurpleButtonClicked() {
        textfield.textColor = .tintPurple()
        
        print("The custom text field's purple right view button was clicked.")
    }

    
    
}
