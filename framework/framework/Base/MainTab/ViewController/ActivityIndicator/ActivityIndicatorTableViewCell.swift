//
//  ActivityIndicatorTableViewCell.swift
//  framework
//
//  Created by Pitchaorn on 4/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class ActivityIndicatorTableViewCell: UITableViewCell {

    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    var indexpath: IndexPath = []{
         didSet {
            
            if indexpath.section == 0{
                indicator.color =  UIColor.darkGray
            }else{
                
                indicator.color = UIColor.purple
                
            }
             setupViews()
        }
    }
    
    let indicator:UIActivityIndicatorView = {
       
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
        return indicator
        
    }()
    
    
    
    
    
    

    func setupViews(){
         self.removeConstraints(constraintCollector)
        
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         self.addConstraints(with: "V:|-16-[v0]-16-|", to: indicator, constraintCollector: &constraintCollector)
    }
}
