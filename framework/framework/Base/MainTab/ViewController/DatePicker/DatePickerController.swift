//
//  DatePickerController.swift
//  framework
//
//  Created by Pitchaorn on 4/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var dateLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        
        return label
        
        
    }()
    
    lazy var datePicker: UIDatePicker = {
        [unowned self] in
        
        let picker = UIDatePicker()
        
        return picker
        
        
        }()
    
    /// A date formatter to format the `date` property of `datePicker`.
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureDatePicker()
        setupView()
    }
    //MARK: - Method
    
    @available(iOS 11.0, *)
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        setupView()
    }
    
    fileprivate func setupView() {
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        
        view.addSubview(datePicker)
        view.addSubview(dateLabel)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        [datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
         datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
         datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
         datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)].forEach({$0.isActive = true})
        
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: dateLabel, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:[v0]-15-[v1]", to: datePicker,dateLabel, constraintCollector: &constraintCollector)
        
        
    }

    // MARK: - Configuration
    
    func configureDatePicker() {
        datePicker.datePickerMode = .date
        
        /** Set min/max date for the date picker. As an example we will limit the date between
         now and 7 days from now.
         */
        let now = Date()
        datePicker.minimumDate = now
        
        var dateComponents = DateComponents()
        dateComponents.day = 7
        
        let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now)
        datePicker.maximumDate = sevenDaysFromNow
        
        datePicker.minuteInterval = 2
        
        datePicker.addTarget(self, action: #selector(DatePickerController.updateDatePickerLabel), for: .valueChanged)
        
        updateDatePickerLabel()
    }
    
    // MARK: - Actions
    
    @objc
    func updateDatePickerLabel() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
}
