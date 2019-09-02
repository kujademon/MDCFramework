//
//  MaterialButtonEffect.swift
//
//  Created by Pawarit Phrompuak on 3/29/16.
//  Copyright © 2016 - 2026. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class MaterialButtonEffect: UIButton {
    
    // MARK: - IBInspectable
    
    @IBInspectable public var rippleOverBounds: Bool = false
    @IBInspectable public var onTouchLocation: Bool = false
    @IBInspectable public var shadowRippleEnable: Bool = true
    
    @IBInspectable public var rippleColor: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            rippleView.backgroundColor = rippleColor
        }
    }
    
    @IBInspectable public var rippleBGColor: UIColor = UIColor(white: 0.95, alpha: 1) {
        didSet {
            rippleBGView.backgroundColor = rippleBGColor
        }
    }
    
    @IBInspectable public var buttonCornerRadius: Float = 0 {
        didSet{
            self.layer.cornerRadius = CGFloat(buttonCornerRadius)
        }
    }
    
    
    // MARK: - Properties

    private var areaOfEffect: Float = 0.8 // 1 is 100%
    private var rippleAnimTime: Double = 0.3
    private var touchCentreLocation: CGPoint?
    private var shadowRadius: Float = 1
    private var tempShadowRadius: CGFloat = 0
    private var tempShadowOpacity: Float = 0
    
    private var rippleMask: CAShapeLayer? {
        get {
            if !rippleOverBounds {
                let mask = CAShapeLayer()
                mask.path = UIBezierPath(roundedRect: self.bounds,
                                        cornerRadius: self.layer.cornerRadius).cgPath
                return mask
            } else {
                return nil
            }
        }
    }
    
    let rippleView = UIView()
    let rippleBGView = UIView()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Methods
    
    private func setup() {
        setupRipple()
        
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        
        rippleBGView.backgroundColor = rippleBGColor
        rippleBGView.frame = self.bounds
        self.layer.addSublayer(rippleBGView.layer)
        rippleBGView.layer.addSublayer(rippleView.layer)
        rippleBGView.alpha = 0
    }
    
    private func setupRipple() {
        let width: CGFloat
        
        if self.bounds.width > self.bounds.height * 3 {
            width = self.bounds.width / 2 * CGFloat(areaOfEffect)
        } else {
            width = self.bounds.width * CGFloat(areaOfEffect)
        }
        
        let cornerRadius: CGFloat = width/2
        let x: CGFloat = (self.bounds.width/2) - (width/2)
        let y: CGFloat = (self.bounds.height/2) - (width/2)
        
        rippleView.frame = CGRect(x: x,y: y,width: width,height: width)
        rippleView.backgroundColor = rippleColor
        rippleView.layer.cornerRadius = cornerRadius
    }
    
    public func animateToNormal() {
        // Ripple View On Button Fading
        UIView.animate(withDuration: 0.1, delay: 0, options: [UIView.AnimationOptions.allowUserInteraction], animations: { self.rippleBGView.alpha = 1}, completion: { (success: Bool) -> () in
            UIView.animate(withDuration: self.rippleAnimTime, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: {
                self.rippleBGView.alpha = 0 }, completion: nil) })
        
        // Button Shadow Fading
        UIView.animate(withDuration: 0.4, delay: 0, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.rippleView.transform = .identity
            
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = self.tempShadowRadius
            
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = self.tempShadowOpacity
            
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.4
            groupAnim.fillMode = .forwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            
            self.layer.add(groupAnim, forKey:"buttonShadowFade") }, completion: nil)
    }
    
    
    // MARK: - Events
    
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if onTouchLocation {
            touchCentreLocation = touch.location(in: self)
        } else {
            touchCentreLocation = nil
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: { self.rippleBGView.alpha = 1 }, completion: nil)
        
        rippleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.allowUserInteraction], animations: { self.rippleView.transform =  .identity }, completion: nil)
        
        if shadowRippleEnable {
            tempShadowRadius = layer.shadowRadius
            tempShadowOpacity = layer.shadowOpacity
            
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = shadowRadius
            
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = 1
            
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.4
            groupAnim.fillMode = .forwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            
            self.layer.add(groupAnim, forKey:"buttonShadowOnPress")
        }
        
        return super.beginTracking(touch, with: event)
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        animateToNormal()
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animateToNormal()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        setupRipple()
        
        if let touchLocation = touchCentreLocation {
            rippleView.center = touchLocation
        }
        
        rippleBGView.layer.frame = self.bounds
        rippleBGView.layer.mask = rippleMask
    }
    
}
