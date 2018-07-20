//
//  ButtonTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 4/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    
    func buttonDidTouch(_ sender: UIButton)
}

class ButtonTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    
    var constraintCollector = [NSLayoutConstraint]()
    
    var button: UIButton = {
        
        let button = UIButton()
        
        return button
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
            
            button.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
            switch indexpath.section {
                case 0:
                 configureSystemTextButton()
                case 1:
                 configureSystemContactAddButton()
                case 2:
                 configureSystemDetailDisclosureButton()
                case 3:
                configureImageButton()
                case 4:
                configureAttributedTextSystemButton()
                default:
                return
            }
            
            setupViews()
        }
    }

    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.addConstraints(with: "V:|-16-[v0(30)]-16-|", to: button, constraintCollector: &constraintCollector)
        
    }
    
    // MARK: - Actions
    
    @objc
    func buttonClicked(_ sender: UIButton) {
        
        delegate?.buttonDidTouch(sender)
        
    }

    // MARK: - Configuration
    
    func configureSystemTextButton() {
        
        button = UIButton(type: .system)
        
        let buttonTitle = NSLocalizedString("Button", comment: "")
        
        button.setTitle(buttonTitle, for: .normal)
        
        
    }
    
    func configureSystemContactAddButton() {
        button.backgroundColor = UIColor.clear
        button = UIButton(type: .contactAdd)
    }
    
    func configureSystemDetailDisclosureButton() {
        button.backgroundColor = UIColor.clear
        button = UIButton(type: .detailDisclosure)
        
    }
    
    func configureImageButton() {
        // To create this button in code you can use `UIButton.init(type: .system)`.
        
        // Remove the title text.
        button.setTitle("", for: .normal)
        
       
        button.tintColor = UIColor.tintPurple()
        
        
        let imageButtonNormalImage = #imageLiteral(resourceName: "x_icon")
        button.setImage(imageButtonNormalImage, for: .normal)
        
        // Add an accessibility label to the image.
        button.accessibilityLabel = NSLocalizedString("X Button", comment: "")
        
    }
    
    func configureAttributedTextSystemButton() {
        let buttonTitle = NSLocalizedString("Button", comment: "")
        
        // Set the button's title for normal state.
        
        let normalTitleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.foregroundColor: UIColor.tintBlue(),
            NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue
        ]
        
        let normalAttributedTitle = NSAttributedString(string: buttonTitle, attributes: normalTitleAttributes)
        button.setAttributedTitle(normalAttributedTitle, for: .normal)
        
        // Set the button's title for highlighted state.
        let highlightedTitleAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.green,
            NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleThick.rawValue
            ] as [NSAttributedStringKey : Any]
        let highlightedAttributedTitle = NSAttributedString(string: buttonTitle, attributes: highlightedTitleAttributes)
        button.setAttributedTitle(highlightedAttributedTitle, for: .highlighted)
        
        
    }
    
    
}
