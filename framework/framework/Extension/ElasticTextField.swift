//
//  ElasticTextField.swift
//
//  Created by Pawarit Phrompuak on 4/28/16.
//  Copyright © 2016 - 2026. All rights reserved.
//

import UIKit

class ElasticTextField: UITextField {

    // MARK: - Properties
    
    private let movingAmount: CGFloat = 10
    private var animFlag = false
    private let topControlPointView = UIView()
    private let leftControlPointView = UIView()
    private let bottomControlPointView = UIView()
    private let rightControlPointView = UIView()
    private let elasticShape = CAShapeLayer()
    
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(ElasticTextField.updateLoop))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        
        return displayLink
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // MARK: - Methods
    
    func setupView() {
        
        self.borderStyle = .none
        
        setupComponents()
    }
    
    private func setupComponents() {
        
        elasticShape.fillColor = self.backgroundColor?.cgColor
        elasticShape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15).cgPath
        layer.addSublayer(elasticShape)
        
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        
        for controlPoint in [ topControlPointView, leftControlPointView,
                              bottomControlPointView, rightControlPointView ] {
                                
                                addSubview(controlPoint)
                                controlPoint.frame = CGRect(x: 0.0, y: 0.0, width: 5.0, height: 5.0)
        }
        
        positionControlPoints()
    }
    
    private func positionControlPoints() {
        
        topControlPointView.center = CGPoint(x: bounds.midX, y: 0.0)
        leftControlPointView.center = CGPoint(x: 0.0, y: bounds.midY)
        bottomControlPointView.center = CGPoint(x: bounds.midX, y: bounds.maxY)
        rightControlPointView.center = CGPoint(x: bounds.maxX, y: bounds.midY)
    }
    
    private func bezierPathForControlPoints() -> CGPath {
        
        let path = UIBezierPath()
        
        let top = topControlPointView.layer.presentation()!.position
        let left = leftControlPointView.layer.presentation()!.position
        let bottom = bottomControlPointView.layer.presentation()!.position
        let right = rightControlPointView.layer.presentation()!.position
        
        let width = frame.size.width
        let height = frame.size.height
        
        path.move(to: left)
        
        path.addQuadCurve(to: CGPoint(x: 23,y: height), controlPoint: CGPoint(x: 0,y: height))
        
        path.addQuadCurve(to: CGPoint(x: width - 23,y: height), controlPoint: bottom)
        
        path.addQuadCurve(to: right, controlPoint: CGPoint(x: width,y: height))
        
        path.addQuadCurve(to: CGPoint(x: width - 23,y: 0), controlPoint: CGPoint(x: width,y: 0))
        
        path.addQuadCurve(to: CGPoint(x: 23,y: 0), controlPoint: top)
        
        path.addQuadCurve(to: left, controlPoint: CGPoint(x: 0,y: 0))
        
        path.close()
        
        return path.cgPath
    }
    
    @objc func updateLoop() {
        elasticShape.path = bezierPathForControlPoints()
    }
    
    private func startUpdateLoop() {
        displayLink.isPaused = false
    }
    
    private func stopUpdateLoop() {
        displayLink.isPaused = true
    }
    
    func animateControlPoints() {
        
        let movingAmount: CGFloat = self.movingAmount
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
            
            self.animFlag = true
            
            self.topControlPointView.center.y -= movingAmount
            self.leftControlPointView.center.x -= movingAmount
            self.bottomControlPointView.center.y += movingAmount
            self.rightControlPointView.center.x += movingAmount
            
            }, completion: { (success: Bool) in
                
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
                    
                    self.positionControlPoints()
                    
                    }, completion: { (success: Bool) in
                        
                        self.stopUpdateLoop()
                        
                        self.animFlag = false
                })
        })
    }
    
    override func becomeFirstResponder() -> Bool {
        if animFlag == false {
            startUpdateLoop()
            animateControlPoints()
        }
        super.becomeFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if animFlag == false {
            startUpdateLoop()
            animateControlPoints()
        }
        super.touchesBegan(touches, with: event)
    }

}
