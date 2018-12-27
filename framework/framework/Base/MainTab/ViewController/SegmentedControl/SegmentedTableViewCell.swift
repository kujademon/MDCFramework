//
//  SegmentedTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

protocol SegmentedCellDelegate: class {
    
    func selectedSegmentDidChange(_ segmentedControl: UISegmentedControl)
}

class SegmentedTableViewCell: UITableViewCell {

     // MARK: Properties
    
    weak var delegate: SegmentedCellDelegate?
    
    var constraintCollector = [NSLayoutConstraint]()
    
    let segmented : UISegmentedControl = {
        
        let items = ["Check", "Search", "Tools"]
        
        let segmented = UISegmentedControl(items: items)
        
        
        return segmented
        
    }()
    
    var indexpath: IndexPath = []{
        didSet {
            segmented.addTarget(self,action: #selector(self.selectedSegmentDidChange(_:)),
                                for: .valueChanged)
            switch indexpath.section {
            case 0:
                configureDefaultSegmentedControl()
            case 1:
                configureTintedSegmentedControl()
            case 2:
                configureCustomSegmentsSegmentedControl()
            case 3:
                configureCustomBackgroundSegmentedControl()
            default:
                return
            }
           
            
            setupViews()
        }
    }
    
    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(segmented)
        self.addConstraints(with: "H:|-16-[v0]-16-|", to: segmented, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: segmented, constraintCollector: &constraintCollector)
        
    }
    
    // MARK: - Configuration
    
    func configureDefaultSegmentedControl() {
        
        segmented.setEnabled(false, forSegmentAt: 0)
        
    }
    
    func configureTintedSegmentedControl() {
       
        
        segmented.tintColor = UIColor.tintBlue()
        
        
        segmented.selectedSegmentIndex = 1
        
    }
    
    func configureCustomSegmentsSegmentedControl() {
        let imageToAccessibilityLabelMappings = [
            "checkmark_icon": NSLocalizedString("Done", comment: ""),
            "search_icon": NSLocalizedString("Search", comment: ""),
            "tools_icon": NSLocalizedString("Settings", comment: "")
        ]
        
        // Guarantee that the segments show up in the same order.
        var sortedSegmentImageNames = Array(imageToAccessibilityLabelMappings.keys)
        sortedSegmentImageNames.sort { lhs, rhs in
            return lhs.localizedStandardCompare(rhs) == ComparisonResult.orderedAscending
        }
        
        for (idx, segmentImageName) in sortedSegmentImageNames.enumerated() {
            let image = UIImage(named: segmentImageName)!
            
            image.accessibilityLabel = imageToAccessibilityLabelMappings[segmentImageName]
            
            segmented.setImage(image, forSegmentAt: idx)
        }
        
        segmented.selectedSegmentIndex = 0
        
    }
    
    func configureCustomBackgroundSegmentedControl() {
        segmented.selectedSegmentIndex = 2
        
        // Set the background images for each control state.
        let normalSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background")
        segmented.setBackgroundImage(normalSegmentBackgroundImage, for: .normal, barMetrics: .default)
        
        let disabledSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_disabled")
        segmented.setBackgroundImage(disabledSegmentBackgroundImage, for: .disabled, barMetrics: .default)
        
        let highlightedSegmentBackgroundImage = UIImage(named: "stepper_and_segment_background_highlighted")
        segmented.setBackgroundImage(highlightedSegmentBackgroundImage, for: .highlighted, barMetrics: .default)
        
        // Set the divider image.
        let segmentDividerImage = UIImage(named: "stepper_and_segment_divider")
        segmented.setDividerImage(segmentDividerImage,
                                                         forLeftSegmentState: .normal,
                                                         rightSegmentState: .normal,
                                                         barMetrics: .default)
        
        // Create a font to use for the attributed title (both normal and highlighted states).
        let captionFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .caption1)
        let font = UIFont(descriptor: captionFontDescriptor, size: 0)
        
        
        let normalTextAttributes = [
            
            NSAttributedString.Key.foregroundColor: UIColor.tintPurple(),
            NSAttributedString.Key.font: font
        ]
        segmented.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let highlightedTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.tintGreen(),
            NSAttributedString.Key.font: font
        ]
        segmented.setTitleTextAttributes(highlightedTextAttributes, for: .highlighted)
        
       
    }

    // MARK: - Actions
    
    @objc
    func selectedSegmentDidChange(_ segmentedControl: UISegmentedControl) {
        delegate?.selectedSegmentDidChange(segmentedControl)
    }
}
