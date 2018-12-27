//
//  RadioButtonSelectedController.swift
//  framework
//
//  Created by Pitchaorn on 15/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class RadioButtonSelectedController: UIViewController {
    
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
        
        
        radioButton1.addTarget(self, action: #selector(RadioButtonSelectedController.selectedRadioButton), for: UIControl.Event.touchUpInside)
        radioButton2.addTarget(self, action: #selector(RadioButtonSelectedController.selectedRadioButton), for: UIControl.Event.touchUpInside)
        
        
        view.addConstraints(with: "H:|-82-[v0]|", to: radioButton1, constraintCollector: &constraintCollector)
        view.addConstraints(with: "H:|-82-[v0]|", to: radioButton2, constraintCollector: &constraintCollector)
        
        view.addConstraints(with: "V:|-40-[v0]-20-[v1]", to: radioButton1,radioButton2, constraintCollector: &constraintCollector)
        
    }
    
     @objc func selectedRadioButton(radioButton: RadioButton) {
        
       [radioButton1,radioButton2].forEach{
            $0.isSelected = false
        }
        
        radioButton.isSelected = true
        
    }

}
