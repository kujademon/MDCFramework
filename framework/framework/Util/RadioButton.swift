//
//  RadioButton.swift
//
//  Created by Pawarit Phrompuak on 8/16/16.
//  Copyright © 2016 - 2026. All rights reserved.
//

import UIKit

private let defaultIconSize: CGFloat = 15.0
private let defaultMarginWidth: CGFloat = 5.0
private let defaultAnimationDuration: CFTimeInterval = 0.3
private let generatedIconName = "GeneratedIcon"

public class RadioButton: UIButton {
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initRadioButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initRadioButton()
    }
    
    
    // MARK: - Properties
    
    public var iconSize: CGFloat = defaultIconSize
    public var iconColor = UIColor.blue
    public var iconStrokeWidth: CGFloat = defaultIconSize / 9.0
    public var indicatorSize: CGFloat = defaultIconSize * 0.5
    public var indicatorColor = UIColor.blue
    public var marginWidth: CGFloat = defaultMarginWidth
    public var iconOnRight = false
    public var iconSquare = false
    public var multipleSelectEnabled = false
    public var animationDuration: CFTimeInterval = defaultAnimationDuration
    
    public var otherButtons = [RadioButton]()
    
    public var icon: UIImage? {
        didSet {
            
            self.setImage(self.icon, for: .normal)
        }
    }
    
    public var selectedIcon: UIImage? {
        didSet {
            
            self.setImage(self.selectedIcon, for: .selected)
            
            self.setImage(self.selectedIcon, for: UIControlState.selected.union(.highlighted))
        }
    }
    
    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        
        set {
            
            if self.multipleSelectEnabled || (newValue != self.isSelected && (self.icon?.accessibilityIdentifier?.compare(generatedIconName) == .orderedSame) && (self.selectedIcon?.accessibilityIdentifier?.compare(generatedIconName) == .orderedSame)) {
                
                let animation = CABasicAnimation(keyPath: "contents")
                animation.duration = self.animationDuration
                
                animation.fromValue = self.isSelected ? self.selectedIcon?.cgImage : self.icon?.cgImage
                
                animation.toValue = self.isSelected ? self.icon?.cgImage : self.selectedIcon?.cgImage
                
                self.imageView?.layer.add(animation, forKey: "icon")
            }
            
            
            if self.multipleSelectEnabled {
                
                super.isSelected = !self.isSelected
                
            } else {
                
                super.isSelected = newValue
                
                if newValue {
                    
                    self.deselectOtherButtons()
                }
            }
        }
    }
    
    
    // MARK: - Methods
    
    public override func prepareForInterfaceBuilder() {
        self.initRadioButton()
        
        self.drawButton()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawButton()
    }
    
    /// *NOTE* - Only set on firstButton
    public func settingOtherButtons() {
        
        for button in self.otherButtons {
            
            let others = NSMutableArray.init(array: self.otherButtons)
            
            others.add(self)
            others.remove(button)
            
            button.otherButtons = others.copy() as! [RadioButton]
        }
    }
    
    /// *NOTE* - Only set on firstButton
    public func settingMultipleSelectEnabled(_ enable: Bool) {
        
        self.multipleSelectEnabled = enable
        
        if self.otherButtons.count != 0 {
            
            for button in self.otherButtons {
                
                button.multipleSelectEnabled = enable
            }
        }
    }
    
    /// *NOTE* - Only set on firstButton
    public func settingAnimationDuration(duration: CFTimeInterval) {
        
        self.animationDuration = duration
        
        if self.otherButtons.count != 0 {
            
            for button in self.otherButtons {
                
                button.animationDuration = duration
            }
        }
    }
    
    public func drawButton() {
        
        if self.icon == nil && self.selectedIcon == nil {
            
            self.icon = self.drawIconWith(selection: false)
            self.selectedIcon = self.drawIconWith(selection: true)
        }
        
        let marginWidth = self.marginWidth
        
        var layoutRightToLeft = false
        
        layoutRightToLeft = UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == UIUserInterfaceLayoutDirection.rightToLeft
        
        if self.iconOnRight {
            
            self.imageEdgeInsets = layoutRightToLeft ? UIEdgeInsetsMake(0, 0, 0, self.frame.size.width - (self.icon?.size.width)!) : UIEdgeInsetsMake(0, self.frame.size.width - (self.icon?.size.width)!, 0, 0)
            
            self.titleEdgeInsets = layoutRightToLeft ? UIEdgeInsetsMake(0, marginWidth + (self.icon?.size.width)!, 0, -(self.icon?.size.width)!) : UIEdgeInsetsMake(0, -(self.icon?.size.width)!, 0, marginWidth + (self.icon?.size.width)!)
            
        } else {
            
            if layoutRightToLeft {
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0)
                
            } else {
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0)
            }
        }
    }
    
    public func drawIconWith(selection: Bool) -> UIImage {
        
        let iconSize = self.iconSize
        let iconStrokeWidth = self.iconSize / 9.0
        let indicatorSize = self.iconSize * 0.5
        
        let rect = CGRect.init(x: 0.0, y: 0.0, width: iconSize, height: iconSize)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIGraphicsPushContext(context!)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        // Draw an Icon
        var iconPath = UIBezierPath()
        
        let iconRect = CGRect.init(x: iconStrokeWidth / 2, y: iconStrokeWidth / 2, width: iconSize - iconStrokeWidth, height: iconSize - iconStrokeWidth)
        
        if self.iconSquare {
            
            iconPath = UIBezierPath.init(rect: iconRect)
            
        } else {
            
            iconPath = UIBezierPath.init(ovalIn: iconRect)
        }
        
        iconColor.setStroke()
        
        iconPath.lineWidth = iconStrokeWidth
        iconPath.stroke()
        
        context!.addPath(iconPath.cgPath)
        
        
        // Draw an Indicator
        if selection {
            
            var indicatorPath = UIBezierPath()
            
            let indicatorRect = CGRect.init(x: (iconSize - indicatorSize) / 2, y: (iconSize - indicatorSize) / 2, width: indicatorSize, height: indicatorSize)
            
            if self.iconSquare {
                
                indicatorPath = UIBezierPath.init(rect: indicatorRect)
                
            } else {
                
                indicatorPath = UIBezierPath.init(ovalIn: indicatorRect)
            }
            
            indicatorColor.setFill()
            indicatorPath.fill()
            
            context!.addPath(indicatorPath.cgPath)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsPopContext()
        UIGraphicsEndImageContext()
        
        image?.accessibilityIdentifier = generatedIconName
        
        return image!
    }
    
    @objc public func touchUpInside() {
        self.isSelected = true
    }
    
    public func initRadioButton() {
        
        super.addTarget(self, action: #selector(RadioButton.touchUpInside), for: .touchUpInside)
    }
    
    public func selectedButton() -> RadioButton? {
        
        if !self.multipleSelectEnabled {
            
            if self.isSelected {
                
                return self
                
            } else {
                
                for button in self.otherButtons {
                    
                    if button.isSelected {
                        
                        return button
                    }
                }
            }
        }
        
        return nil
    }
    
    public func selectedButtons() -> [RadioButton] {
        
        var selectedButtons = [RadioButton]()
        
        if self.isSelected {
            
            selectedButtons.append(self)
        }
        
        for button in self.otherButtons {
            
            if button.isSelected {
                
                selectedButtons.append(button)
            }
        }
        
        return selectedButtons
    }
    
    public func deselectOtherButtons() {
        
        for button in self.otherButtons {
            
            button.isSelected = false
        }
    }
    
}
