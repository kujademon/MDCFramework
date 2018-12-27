//
//  TextViewCustomController.swift
//  framework
//
//  Created by Pitchaorn on 10/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class TextViewCustomController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    var alreadyPresent = false
    
    lazy var textView:KMPlaceholderTextView  = {
        [unowned self] in
        
        let textview = KMPlaceholderTextView()
        
        textview.isScrollEnabled = true
        textview.placeholder = "ทดสอบ placehoder"
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.red.cgColor
        
        
        return textview
        
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewCustomController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewCustomController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    fileprivate func setupView() {
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        [textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
         textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
         textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)].forEach{
            $0.isActive = true
        }
        addToolBar()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if !alreadyPresent {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 1.5, animations: { self.view.frame.origin.y -= keyboardSize.height / 2 }, completion: nil)
                
                alreadyPresent = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if alreadyPresent {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 1.5, animations: { self.view.frame.origin.y += keyboardSize.height / 2 }, completion: nil)
                
                alreadyPresent = false
            }
        }
    }

    func addToolBar(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(TextViewCustomController.donePressed))

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar
    }
    @objc func donePressed(){
        view.endEditing(true)
    }
    
    
}
