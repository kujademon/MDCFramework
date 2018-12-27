//
//  BaseTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 3/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    // MARK: Properties
    
     var constraintCollector = [NSLayoutConstraint]()
    
    var BaseCell: Example? {
        
        didSet {
            
            guard let title = BaseCell?.title, let detail = BaseCell?.subTitle else { return }
            
            let titleAttrString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
            titleLabel.attributedText = titleAttrString
            
            
            let detailAttrString = NSAttributedString(string: detail, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            detailLabel.attributedText = detailAttrString
            
            
            setupViews()
        }
    }
    
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        return label
    }()
    
    let detailLabel: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // MARK: Methods
    
    func setupViews() {
        self.removeConstraints(constraintCollector)
        
        self.clipsToBounds = true
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        
        self.addConstraints(with: "H:|-16-[v0]-16-|", to: titleLabel, constraintCollector: &constraintCollector)
        self.addConstraints(with: "H:|-16-[v0]-16-|", to: detailLabel, constraintCollector: &constraintCollector)
        
        self.addConstraints(with: "V:|-8-[v0]-4-[v1]-8-|", to: titleLabel, detailLabel, constraintCollector: &constraintCollector)
    }

}
