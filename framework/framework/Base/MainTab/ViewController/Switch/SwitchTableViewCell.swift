//
//  SwitchTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: Properties

     var constraintCollector = [NSLayoutConstraint]()
    
    let switchControl: UISwitch = {
        
        let switchControl = UISwitch()
        
        return switchControl
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
            switchControl.addTarget(self, action: #selector(self.switchValueDidChange(_:)), for: .valueChanged)
            switch indexpath.section {
            case 0:
                configureDefaultSwitch()
            case 1:
                configureTintedSwitch()
            default:
                return
            }
            
            
            setupViews()
        }
    }

    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(switchControl)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: switchControl, constraintCollector: &constraintCollector)
        
    }
    
    // MARK: - Configuration
    
    func configureDefaultSwitch() {
        switchControl.setOn(true, animated: false)
        
    }
    
    func configureTintedSwitch() {
        switchControl.tintColor = .tintBlue()
        switchControl.onTintColor = .tintGreen()
        switchControl.thumbTintColor = .tintPurple()
        
    }
    
    // MARK: - Actions
    
    @objc
    func switchValueDidChange(_ aSwitch: UISwitch) {
        print("A switch changed its value: \(aSwitch).")
    }
}
