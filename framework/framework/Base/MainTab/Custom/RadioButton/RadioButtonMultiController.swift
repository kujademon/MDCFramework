//
//  RadioButtonMultiController.swift
//  framework
//
//  Created by Pitchaorn on 30/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class RadioButtonMultiController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    let radioButton1: RadioButton = {
        
        let frame = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        
        let button = RadioButton(frame: frame)
        button.titleLabel!.font = UIFont.systemFont(ofSize:19.0)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.setTitle("Radio 1", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.iconColor = UIColor.tintGreen()
        button.indicatorColor = UIColor.tintGreen()
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.iconSize = 18
        return button
    }()
    
    let radioButton2: RadioButton = {
        
        let frame = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        
        let button = RadioButton(frame: frame)
        button.titleLabel!.font = UIFont.systemFont(ofSize:19.0)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.setTitle("Radio 2", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.iconColor = UIColor.tintGreen()
        button.indicatorColor = UIColor.tintGreen()
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.iconSize = 18
        return button
    }()
    
    let textfield1: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont.systemFont(ofSize:21.0)
        textField.attributedPlaceholder = NSAttributedString(string:"textfield 1", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize:21.0)])
        textField.accessibilityIdentifier = "textfield1"
        
        textField.isUserInteractionEnabled = false
        
        return textField
        
    }()
    
    let textfield2: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont.systemFont(ofSize:21.0)
        textField.attributedPlaceholder = NSAttributedString(string:"textfield 2", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize:21.0)])
        textField.accessibilityIdentifier = "textfield2"
        
        textField.isUserInteractionEnabled = false
        
        return textField
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupViews()
    }
    
    
    // MARK: - Methods
    
    fileprivate func setupViews() {
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        
        view.addSubview(radioButton1)
        view.addSubview(radioButton2)
        view.addSubview(textfield1)
        view.addSubview(textfield2)
        
        [radioButton1,radioButton2].forEach({
            $0.settingMultipleSelectEnabled(true)
        })
        
        
        radioButton1.addTarget(self, action: #selector(RadioButtonMultiController.selectedRadioButton1), for: UIControl.Event.touchUpInside)
        radioButton2.addTarget(self, action: #selector(RadioButtonMultiController.selectedRadioButton2), for: UIControl.Event.touchUpInside)
        
        
        view.addConstraints(with: "H:|-82-[v0]|", to: radioButton1, constraintCollector: &constraintCollector)
        view.addConstraints(with: "H:|-82-[v0]|", to: radioButton2, constraintCollector: &constraintCollector)
        
        view.addConstraints(with: "H:|-82-[v0(\(view.frame.width * 0.3))]", to: textfield1, constraintCollector: &constraintCollector)
        view.addConstraints(with: "H:|-82-[v0(\(view.frame.width * 0.3))]", to: textfield2, constraintCollector: &constraintCollector)
        
        view.addConstraints(with: "V:|-40-[v0]-20-[v1]-20-[v2]-20-[v3]", to: radioButton1,textfield1,radioButton2,textfield2, constraintCollector: &constraintCollector)
        
       
        
        
    }

   
    @objc func selectedRadioButton1(radioButton: RadioButton) {
        
        
        if !radioButton.isSelected {
            
            radioButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            
            self.textfield1.text = ""
            self.textfield1.resignFirstResponder()
            self.textfield1.isUserInteractionEnabled = false
        }
        
        if radioButton.multipleSelectEnabled {
            
            for button in radioButton.selectedButtons() {
                
                button.setTitleColor(UIColor.black, for: .normal)

                
                self.textfield1.isUserInteractionEnabled = true
                self.textfield1.becomeFirstResponder()
            }
            
        } else {
            
            print(String(format: "%@ is selected.\n", radioButton.selectedButton()!.titleLabel!.text!))
        }
    }
    
    @objc func selectedRadioButton2(radioButton: RadioButton) {
        
        
        if !radioButton.isSelected {
            
            radioButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            
            self.textfield2.text = ""
            self.textfield2.resignFirstResponder()
            self.textfield2.isUserInteractionEnabled = false
        }
        
        if radioButton.multipleSelectEnabled {
            
            for button in radioButton.selectedButtons() {
                
                button.setTitleColor(UIColor.black, for: .normal)
                
                
                self.textfield2.isUserInteractionEnabled = true
                self.textfield2.becomeFirstResponder()
            }
            
        } else {
            
            print(String(format: "%@ is selected.\n", radioButton.selectedButton()!.titleLabel!.text!))
        }
    }
}
