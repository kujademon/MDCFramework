//
//  ProgressViewCell.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class ProgressViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    var observer: NSKeyValueObservation?
    
    /**    An `NSProgress` object who's `fractionCompleted` is observed using KVO to update
     the `UIProgressView`s' `progress` properties.
     */
    let progress = Progress(totalUnitCount: 10)
    
    // A repeating timer that, when fired, updates the `NSProgress` object's `completedUnitCount` property.
    var updateTimer: Timer?
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        
        return progressView
    }()

    var indexpath: IndexPath = []{
        didSet {
            switch indexpath.section {
            case 0:
                configureDefaultStyleProgressView()
            case 1:
                configureBarStyleProgressView()
            case 2:
                configureTintedProgressView()
            default:
                return
            }
            
            setupViews()
            
        }
    }
    
    func setupViews(){
        self.removeConstraints(constraintCollector)
        
        self.addSubview(progressView)
        self.addConstraints(with: "H:|-20-[v0]-20-|", to: progressView, constraintCollector: &constraintCollector)
        self.addConstraints(with: "V:|-16-[v0]-16-|", to: progressView, constraintCollector: &constraintCollector)
        
    }
    
    // MARK: - Configuration
    
    func configureDefaultStyleProgressView() {
        progressView.progressViewStyle = .default
    }
    
    func configureBarStyleProgressView() {
        progressView.progressViewStyle = .bar
    }
    
    func configureTintedProgressView() {
        progressView.progressViewStyle = .default
        
        
        progressView.trackTintColor = UIColor.tintBlue()
    
   
        progressView.progressTintColor = UIColor.tintPurple()
        
    }
    
    func update(){
        // Reset the completed progress of the `UIProgressView`s.
        
        progressView.setProgress(0.0, animated: false)
        
        
        /** Reset the `completedUnitCount` of the `NSProgress` object and create
         a repeating timer to increment it over time.
         */
        progress.completedUnitCount = 0
        
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            /** Update the `completedUnitCount` of the `NSProgress` object if it's
             not completed. Otherwise, stop the timer.
             */
            if self.progress.completedUnitCount < self.progress.totalUnitCount {
                self.progress.completedUnitCount += 1
            } else {
                self.updateTimer?.invalidate()
            }
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        })
    }
}
