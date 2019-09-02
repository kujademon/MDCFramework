//
//  EmptyBackgroundView.swift
//  busProject
//
//  Created by Pitchaorn on 21/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import UIKit

class EmptyBackgroundView: UIView {
    
    private var topSpace: UIView = {
        let view = UIView()
        return view
        
    }()
    
    private var bottomSpace: UIView = {
        let view = UIView()
        return view
        
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var topLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private var bottomLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let topColor = UIColor.darkGray
    private let topFont = UIFont.boldSystemFont(ofSize: 22)
    private let bottomColor = UIColor.gray
    private let bottomFont = UIFont.systemFont(ofSize: 18)
    
    private let spacing: CGFloat = 10
    private let imageViewHeight: CGFloat = 100
    private let bottomLabelWidth: CGFloat = 300
    
    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(image: UIImage, top: String, bottom: String) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupImageView(image)
        setupLabels(top, bottom: bottom)
    }
    
    func setupViews() {
        
        addSubview(topSpace)
        addSubview(bottomSpace)
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
    }
    
    func setupImageView(_ image: UIImage) {
        imageView.image = image
        imageView.tintColor = topColor
        imageView.setShadow()
    }
    
    func setupLabels(_ top: String, bottom: String) {
        topLabel.text = top
        topLabel.textColor = topColor
        topLabel.font = topFont
        
        bottomLabel.text = bottom
        bottomLabel.textColor = bottomColor
        bottomLabel.font = bottomFont
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .center
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            topSpace.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                topSpace.centerXAnchor.constraint(equalTo: centerXAnchor),
                topSpace.topAnchor.constraint(equalTo: topAnchor),
                topSpace.heightAnchor.constraint(greaterThanOrEqualToConstant: spacing)
                ])
            
        bottomSpace.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomSpace.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomSpace.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSpace.heightAnchor.constraint(equalTo: topSpace.heightAnchor)
            ])
            
            
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topSpace.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: imageViewHeight),
            ])

            
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
            
            
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: spacing),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomSpace.topAnchor),
            bottomLabel.widthAnchor.constraint(equalToConstant: bottomLabelWidth)
            ])

            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}


//func setupEmptyBackgroundView() {
//    let emptyBackgroundView = EmptyBackgroundView(image: #imageLiteral(resourceName: "user icon") , top: "กรุณาเพิ่มบุตรของท่าน", bottom: "")
//    tableView.backgroundView = emptyBackgroundView
//}
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    if child.count == 0 {
//        tableView.separatorStyle = .none
//        tableView.backgroundView?.isHidden = false
//    } else {
//        tableView.separatorStyle = .singleLine
//        tableView.backgroundView?.isHidden = true
//    }
//
//    return child.count
//}
