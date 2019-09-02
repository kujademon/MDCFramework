//
//  Launch.swift
//  busProject
//
//  Created by Pitchaorn on 27/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import UIKit
import DCAnimationKit

class Launch: UIView {

    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "อุ่นใจ"
        label.textAlignment = .center
        label.textColor = .lightGreen
        label.font = UIFont.Kanit(.ExtraBold, size: 100)
        
        return label
    }()
    
    let busLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "school_bus_logo_have_driver")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        
        return logo
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
        
    }
    
    func setUpView(){
        backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "BG (white)"))
        addSubview(titleLabel)
        addSubview(busLogo)
        
        let width = self.frame.width
        busLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busLogo.widthAnchor.constraint(equalToConstant: width * 0.7),
            busLogo.heightAnchor.constraint(equalToConstant: width * 0.7),
            busLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            busLogo.centerYAnchor.constraint(equalTo: centerYAnchor)
            
            ])
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: width),
            titleLabel.heightAnchor.constraint(equalToConstant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: busLogo.topAnchor, constant: -50)
            ])
        layoutIfNeeded()
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.titleLabel.pulse(nil)
            self.busLogo.pulse(nil)
            
        }, completion: nil)
        

    }

    
}
