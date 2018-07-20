//
//  SilderTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

protocol SilderCellDelegate: class {
    
     func sliderValueDidChange(_ slider: UISlider)
}

class SilderTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    weak var delegate: SilderCellDelegate?
    
    var constraintCollector = [NSLayoutConstraint]()
    
    let silder: UISlider = {
        
        let silder = UISlider()
        
        return silder
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
            silder.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
            switch indexpath.section {
            case 0:
                configureDefaultSlider()
            case 1:
                configureTintedSlider()
            case 2:
                configureCustomSlider()
            default:
                return
            }
            
            
            setupViews()
        }
    }
    
    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(silder)
        self.addConstraints(with: "H:|-16-[v0]-16-|", to: silder, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: silder, constraintCollector: &constraintCollector)
        
    }

    // MARK: - Configuration
    
    func configureDefaultSlider() {
        silder.minimumValue = 0
        silder.maximumValue = 100
        silder.value = 42
        silder.isContinuous = true
        
    }
    
    func configureTintedSlider() {
        
        silder.minimumTrackTintColor = UIColor.tintBlue()

        silder.maximumTrackTintColor = UIColor.tintPurple()
        silder.minimumValue = 0
        silder.maximumValue = 100
        silder.value = 50
        
        
    }
    
    func configureCustomSlider() {
        let leftTrackImage = UIImage(named: "slider_blue_track")
        silder.setMinimumTrackImage(leftTrackImage, for: .normal)
        
        let rightTrackImage = UIImage(named: "slider_green_track")
        silder.setMaximumTrackImage(rightTrackImage, for: .normal)
        
        let thumbImage = UIImage(named: "slider_thumb")
        silder.setThumbImage(thumbImage, for: .normal)
        
        silder.minimumValue = 0
        silder.maximumValue = 100
        silder.isContinuous = false
        silder.value = 84
        
    }
    
    // MARK: - Actions
    
    @objc
    func sliderValueDidChange(_ slider: UISlider) {
       delegate?.sliderValueDidChange(silder)
    }

}
