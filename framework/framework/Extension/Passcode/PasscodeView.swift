//
//  PasscodeView.swift
//  PasscodeView
//
//  Created by Urtaq on {TODAY}.
//  Copyright © 2017 PasscodeView. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension 11.0, *)

public protocol PasscodeInputCompleteProtocol: class {
    func passcodeInputComplete(_ state: Bool)
    func passcodeValid(_ state: Bool)
}
class PasscodeView: UIView {
    enum PasscodeDigitMode: Int {
        case Four = 4
        case Eight = 8
    }

    open weak var delegate: PasscodeInputCompleteProtocol?
    let MarginHorizontal:CGFloat = 50.0
    let MarginHorizontalPasscodeField:CGFloat = 30.0
    let MarginNumberPad:CGFloat = 10.0

    var container: UIView!
    var setNewPin = false
    var defaultPasscode: String = "1111"
    var inputPasscode: String = ""
    var newPasscode: String = ""
    var mode: PasscodeDigitMode = .Four
    var themeColor: UIColor = UIColor.white

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = UIColor.white

        self.configContainer()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white

        self.configContainer()
    }

    private func configContainer() {

        self.container = UIView()
        self.addSubview(self.container)
        self.container.translatesAutoresizingMaskIntoConstraints = false

        self.addConstraint(NSLayoutConstraint(item: self.container!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.container!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        initView(themeColor: themeColor)
    }

    func initView(themeColor: UIColor?) {
        if let color = themeColor {
            self.themeColor = color
        }

        self.configTitle()
        self.configPasscodeField()
        self.configNumberPad()
    }

    private var lbTitle: UILabel!
    private func configTitle() {
        let title = "Enter Passcode"
        self.lbTitle = UILabel()
        self.lbTitle.text = title
        self.lbTitle.textColor = .white
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = UIFont.Kanit(.Regular, size: 24)
//        self.lbTitle.fitTextToBounds()
        self.addSubview(self.lbTitle)

        let height = self.frame.height
        
        self.lbTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.lbTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: height * 0.15),
            self.lbTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.lbTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            
//            self.lbTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    func setTitle(_ title:String){
         self.lbTitle.text = title
//        self.lbTitle.fitTextToBounds()
    }

    private var passcodeField: UIView!
//    private lazy var passcodes: [UIView] = [UIView]()
    private func configPasscodeField() {
        let digit: Int = self.mode.rawValue

        self.passcodeField = UIView()
        self.addSubview(passcodeField)

        let width = self.frame.width
        let passcodeCellWidth: CGFloat = 20.0
        self.passcodeField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.passcodeField.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 50),
                self.passcodeField.centerXAnchor.constraint(equalTo:self.safeAreaLayoutGuide.centerXAnchor),
            
            self.passcodeField.widthAnchor.constraint(equalToConstant: width)
            ])

        self.passcodeField.layoutIfNeeded()
        
        let passcodeAreaWidth = self.passcodeField.bounds.width - passcodeCellWidth * CGFloat(digit)
        for i in 0 ..< digit {
            let view = UIView()
            view.isOpaque = false
            view.backgroundColor = .a1Gray
            self.passcodeField.addSubview(view)

            
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            view.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: (passcodeAreaWidth / CGFloat(digit + 1) * CGFloat(i + 1) + passcodeCellWidth * CGFloat(i))),
            view.centerYAnchor.constraint(equalTo: self.passcodeField.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: passcodeCellWidth),
            view.heightAnchor.constraint(equalToConstant: passcodeCellWidth),
            
            ])

            view.layer.cornerRadius = passcodeCellWidth * 0.5
//            view.layer.borderColor = self.themeColor.cgColor
//            view.layer.borderWidth = 0.6

           
        }
    }

    private func configNumberPad() {
        self.layoutIfNeeded()
        let delete = "\u{232B}"
        let numberPadStrings = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", delete]

        let numberPadWidth = self.bounds.width - CGFloat(MarginHorizontal * 2)
        for (index, name) in numberPadStrings.enumerated() {
            if name == "" { continue }
            let i = index + 1
            let button = URCicleButton()
            button.setTitle(name, for: UIControl.State.normal)

            self.addSubview(button)

            let positionX = i % 3
            let positionY = floor(Double(i - 1) / 3.0)
            let width = Double(numberPadWidth - CGFloat(MarginNumberPad * 3.0)) / 3.0
            if positionX == 1 {

                
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.passcodeField.bottomAnchor, constant: (MarginHorizontal + (CGFloat(width) + MarginNumberPad) * CGFloat(positionY))),
            button.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: MarginHorizontal),
           button.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            button.heightAnchor.constraint(equalToConstant: CGFloat(width))
            ])
            } else if positionX == 2 {

                
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.passcodeField.bottomAnchor, constant: (MarginHorizontal + (CGFloat(width) + MarginNumberPad) * CGFloat(positionY))),
            button.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            button.heightAnchor.constraint(equalToConstant: CGFloat(width))
            
            ])
            } else {
                button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: self.passcodeField.bottomAnchor, constant: (MarginHorizontal + (CGFloat(width) + MarginNumberPad) * CGFloat(positionY))),
                    button.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -MarginHorizontal),
                    button.widthAnchor.constraint(equalToConstant: CGFloat(width)),
                    button.heightAnchor.constraint(equalToConstant: CGFloat(width))
                    
                    ])
            }

            if name == delete {
                button.initView(themeColor: self.themeColor, needBorder: false)
                button.addTarget(self, action: #selector(tapDelete(_:)), for: UIControl.Event.touchUpInside)
            } else {
                button.initView(themeColor: self.themeColor, needBorder: false)
                button.addTarget(self, action: #selector(tapNumberPad(_:)), for: UIControl.Event.touchUpInside)
            }
            
        }

    }

    open func setPasscode(passcode: String) {
        self.defaultPasscode = passcode
    }

    @objc open func tapNumberPad(_ sender: URCicleButton) {
        
        self.inputPasscode.append(sender.titleLabel!.text!)

        self.validatePasscode(passcode: self.inputPasscode)
    }

    @objc open func tapDelete(_ sender: URCicleButton) {
        if !self.inputPasscode.isEmpty{
            self.inputPasscode.removeLast()
        }
        

        self.validatePasscode(passcode: self.inputPasscode)
    }

    fileprivate func wrongPasscode() {
        self.inputPasscode = ""
        self.validatePasscode(passcode: self.inputPasscode)
        self.passcodeField.shake()
    }
    
    open func validatePasscode(passcode: String) {
        let passcodeLength = passcode.count

//        var themeRed: CGFloat = 0.0
//        var themeGreen: CGFloat = 0.0
//        var themeBlue: CGFloat = 0.0
//        var themeAlpha: CGFloat = 0.0
//        _ = self.themeColor.getRed(&themeRed, green: &themeGreen, blue: &themeBlue, alpha: &themeAlpha)
//        let passcodeColorRatio: CGFloat = 0.8
//        let passcodeColor = UIColor(red: themeRed * passcodeColorRatio, green: themeGreen * passcodeColorRatio, blue: themeBlue * passcodeColorRatio, alpha: themeAlpha)

        for i in 0 ..< self.mode.rawValue {
//
            
                if i < passcodeLength {
                    self.passcodeField.subviews[i].backgroundColor = .white
                    
                } else {
                    self.passcodeField.subviews[i].backgroundColor = .a1Gray
                    
                }
            
            
        }
        self.passcodeField.layoutIfNeeded()

        if passcodeLength == self.mode.rawValue {
            if setNewPin{
                if newPasscode == ""{
                    newPasscode = inputPasscode
                    inputPasscode = ""
                    self.validatePasscode(passcode: self.inputPasscode)
                    self.setTitle("ยืนยัน PIN 4 หลัก ของคุณ")
                }else{
                    if newPasscode == inputPasscode{
                        delegate?.passcodeValid(true)
                    }else{
                        wrongPasscode()
                        delegate?.passcodeValid(false)
                    }
                }
                
                
            }else{
                if self.defaultPasscode == passcode {
                    delegate?.passcodeInputComplete(true)
                } else {
                    wrongPasscode()
                    delegate?.passcodeInputComplete(false)
                }
            }
            
        }
    }
}
