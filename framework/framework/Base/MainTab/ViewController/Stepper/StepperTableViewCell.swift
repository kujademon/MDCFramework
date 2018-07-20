//
//  StepperTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {

    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    let stepper : UIStepper = {
       
        let stepper = UIStepper()
        
        return stepper
        
    }()
    
    let stepperLabel : UILabel = {
        
        let label = UILabel()
        
        label.text = "0"
        label.textAlignment = .right
        
        return label
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
            stepper.addTarget(self, action: #selector(self.stepperValueDidChange(_:)), for: .valueChanged)
            switch indexpath.section {
            case 0:
                configureDefaultStepper()
            case 1:
                configureTintedStepper()
            case 2:
                configureCustomStepper()
            default:
                return
            }
            
            
            setupViews()
        }
    }
    
    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(stepper)
        self.addSubview(stepperLabel)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.addConstraints(with: "H:[v0(97)]-16-|", to: stepperLabel, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: stepper, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: stepperLabel, constraintCollector: &constraintCollector)
        
    }
    
    
    // MARK: - Configuration
    
    func configureDefaultStepper() {
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        
        stepperLabel.text = "\(Int(stepper.value))"
        
    }
    
    func configureTintedStepper() {
        stepper.tintColor = .tintBlue()
        
        stepperLabel.text = "\(Int(stepper.value))"
        
    }
    
    func configureCustomStepper() {
        // Set the background image.
        let stepperBackgroundImage = UIImage(named: "stepper_and_segment_background")
        stepper.setBackgroundImage(stepperBackgroundImage, for: .normal)
        
        let stepperHighlightedBackgroundImage = UIImage(named: "stepper_and_segment_background_highlighted")
        stepper.setBackgroundImage(stepperHighlightedBackgroundImage, for: .highlighted)
        
        let stepperDisabledBackgroundImage = UIImage(named: "stepper_and_segment_background_disabled")
        stepper.setBackgroundImage(stepperDisabledBackgroundImage, for: .disabled)
        
        /** Set the image which will be painted in between the two stepper segments
         (depends on the states of both segments).
         */
        let stepperSegmentDividerImage = UIImage(named: "stepper_and_segment_divider")
        stepper.setDividerImage(stepperSegmentDividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal)
        
        // Set the image for the + button.
        let stepperIncrementImage = UIImage(named: "stepper_increment")
        stepper.setIncrementImage(stepperIncrementImage, for: .normal)
        
        // Set the image for the - button.
        let stepperDecrementImage = UIImage(named: "stepper_decrement")
        stepper.setDecrementImage(stepperDecrementImage, for: .normal)
        
        stepperLabel.text = "\(Int(stepper.value))"
        
    }
    
    // MARK: - Actions
    
    @objc
    func stepperValueDidChange(_ stepper: UIStepper) {
        print("A stepper changed its value: \(stepper).")
        
        // A mapping from a stepper to its associated label.
        
        
        stepperLabel.text = "\(Int(stepper.value))"
    }

}
