//
//  BackNavigation.swift
//  busProject
//
//  Created by Pitchaorn on 7/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import UIKit

class BackNavigation: UIView {

    
    let label : UILabel = {
        let label = UILabel()
        label.text = "ย้อนกลับ"
        label.textColor = .white
        label.font = UIFont.Kanit(.Medium, size: 28)
        
        return label
    }()
    
//    let backBtn: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "left"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
//        button.addTarget(self, action: #selector(more), for: .touchUpInside)
//        return button
//    }()
    
    let backBtn:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "left")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        // all the layout code from above
        backgroundColor = UIColor.lightGreen
        addSubview(label)
        addSubview(backBtn)
        let tap = UITapGestureRecognizer(target: self, action: #selector(BackNavigation.more))
        backBtn.addGestureRecognizer(tap)
        
    }
  

    @objc func more(){
        if let parent = parentViewController{
           
            parent.dismissMe(animated: true, completion: {
                if let vc = UIApplication.topViewController() as? ScanQRViewController{
                    vc.tabBarController?.selectedIndex = 0
                }
            })
        }
        
    }
    
    override func layoutSubviews() {
        addConstraintsWithFormat("V:|-(\(frame.height/2))-[v0(25)]", views: backBtn)
        addConstraintsWithFormatAndOptions("H:|-\(frame.width*0.05)-[v0(25)]-20-[v1]|", views: backBtn,label, options: .alignAllCenterY)
    }
}
