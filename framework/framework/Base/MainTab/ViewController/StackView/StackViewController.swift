//
//  StackViewController.swift
//  framework
//
//  Created by Pitchaorn on 5/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    lazy var titleLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "Showing/hiding views", attributes: attributes)
        
        return label
        
        }()
    
    lazy var detailLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        
        label.text = "Detail"
        
        return label
        
        }()
    
    lazy var detailFurtherLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        
        label.text = "Further Detail"
        
        return label
        
        }()
    
    lazy var footerLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "Footer Label", attributes: attributes)
        
        return label
        
        }()
    
    lazy var addRemoveLabel: UILabel = {
        [unowned self] in
        
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
        
        label.attributedText = NSAttributedString(string: "Add/remove views", attributes: attributes)
        
        return label
        
        }()

    lazy var detailTextfield: UITextField = {
        [unowned self] in
        
        let textfield = UITextField()
        
        textfield.borderStyle = .roundedRect
        
        return textfield
        
        }()
    
    
    lazy var detailFurtherTextfield: UITextField = {
        [unowned self] in
        
        let textfield = UITextField()
        
        textfield.borderStyle = .roundedRect
        
        return textfield
        
        }()
    
    lazy var addDetailButton: UIButton = {
        [unowned self] in
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "stepper_increment")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button.tintColor = .tintBlue()
        
        return button
        
        }()
    
    lazy var removeDetailButton: UIButton = {
        [unowned self] in
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "stepper_decrement")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
         button.tintColor = .tintBlue()
        
        return button
        
        }()
    
    lazy var addViewButton: UIButton = {
        [unowned self] in
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "stepper_increment")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
         button.tintColor = .tintBlue()
        
        return button
        
        }()
    
    lazy var removeViewButton: UIButton = {
        [unowned self] in
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "stepper_decrement")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
         button.tintColor = .tintBlue()
        
        
        
        return button
        
        }()
    
    lazy var furtherDetailStackView: UIStackView = {
        
        [unowned self] in
        
        let stackview = UIStackView()
        
        stackview.axis = .horizontal
        
        return stackview
        
        
    }()
    
    lazy var addRemoveExampleStackView: UIStackView  = {
        
        [unowned self] in
        
        let stackview = UIStackView()
        
        stackview.axis = .vertical
        
        return stackview
        
        
        }()
    
    let maximumArrangedSubviewCount = 3
    
        // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        furtherDetailStackView.isHidden = true
        addDetailButton.isHidden = false
        updateAddRemoveButtons()
    }
    
    //MARK: - Method
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        
        let stackViewTop = UIStackView()
        let stackViewAdd = UIStackView()
        view.addSubview(stackViewTop)
        view.addSubview(stackViewAdd)
        view.addSubview(addRemoveExampleStackView)
        stackViewTop.axis = .vertical
        stackViewTop.addArrangedSubview(titleLabel)
        
        
        let stackViewDetail = UIStackView()
        stackViewDetail.axis = .horizontal
        stackViewTop.addArrangedSubview(stackViewDetail)
        stackViewTop.addArrangedSubview(furtherDetailStackView)
        stackViewTop.addArrangedSubview(footerLabel)
        
        stackViewDetail.addArrangedSubview(detailLabel)
        stackViewDetail.addArrangedSubview(detailTextfield)
        stackViewDetail.addArrangedSubview(addDetailButton)
        
        furtherDetailStackView.addArrangedSubview(detailFurtherLabel)
        furtherDetailStackView.addArrangedSubview(detailFurtherTextfield)
        furtherDetailStackView.addArrangedSubview(removeDetailButton)
        
        
        
        view.addConstraints(with: "H:|-16-[v0]-16-|", to: stackViewTop, constraintCollector: &constraintCollector)
        view.addConstraints(with: "H:|-16-[v0]-16-|", to: stackViewAdd, constraintCollector: &constraintCollector)
        
        addRemoveExampleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [addRemoveExampleStackView.widthAnchor.constraint(equalToConstant: 38),
         addRemoveExampleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)].forEach({ $0.isActive = true })
        
        view.addConstraints(with: "V:|-16-[v0]-20-[v1]-8-[v2]", to: stackViewTop,stackViewAdd,addRemoveExampleStackView, constraintCollector: &constraintCollector)
        
        
        
        stackViewDetail.addConstraints(with: "H:|[v0(110)][v1][v2(42)]", to: detailLabel,detailTextfield,addDetailButton, constraintCollector: &constraintCollector)
        stackViewDetail.addConstraints(with: "V:|-16-[v0(30)]-16-|", to: detailLabel, constraintCollector: &constraintCollector)
        addDetailButton.addTarget(self, action: #selector(showFurtherDetail(_:)), for: .touchUpInside)
        
        
        furtherDetailStackView.addConstraints(with: "H:|[v0(110)][v1][v2(42)]|", to: detailFurtherLabel,detailFurtherTextfield,removeDetailButton, constraintCollector: &constraintCollector)
        furtherDetailStackView.addConstraints(with: "V:|-16-[v0(30)]-16-|", to: detailFurtherLabel, constraintCollector: &constraintCollector)
        removeDetailButton.addTarget(self, action: #selector(hideFurtherDetail(_:)), for: .touchUpInside)
        
        stackViewAdd.axis = .horizontal
        stackViewAdd.addArrangedSubview(addRemoveLabel)
        stackViewAdd.addArrangedSubview(addViewButton)
        stackViewAdd.addArrangedSubview(removeViewButton)
        
        addViewButton.translatesAutoresizingMaskIntoConstraints = false
        [addViewButton.heightAnchor.constraint(equalToConstant: 42),
         addViewButton.widthAnchor.constraint(equalToConstant: 42)].forEach({$0.isActive = true})
        removeViewButton.translatesAutoresizingMaskIntoConstraints = false
        [removeViewButton.heightAnchor.constraint(equalToConstant: 42),
         removeViewButton.widthAnchor.constraint(equalToConstant: 42)].forEach({$0.isActive = true})
        addViewButton.addTarget(self, action: #selector(addArrangedSubviewToStack(_:)), for: .touchUpInside)
        removeViewButton.addTarget(self, action: #selector(removeArrangedSubviewFromStack(_:)), for: .touchUpInside)
        
    }
    
    

    // MARK: - Actions
    
    @objc func showFurtherDetail(_: AnyObject) {
        // Animate the changes by performing them in a `UIViewPropertyAnimator` animation block.
        let showDetailAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: { [weak self] in
            // Reveal the further details stack view and hide the plus button.
            self?.furtherDetailStackView.isHidden = false
            self?.addDetailButton.isHidden = true
        })
        showDetailAnimator.startAnimation()
    }
    
    @objc func hideFurtherDetail(_: AnyObject) {
        // Animate the changes by performing them in a `UIViewPropertyAnimator` animation block.
        let hideDetailAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut, animations: { [weak self] in
            // Reveal the further details stack view and hide the plus button.
            self?.furtherDetailStackView.isHidden = true
            self?.addDetailButton.isHidden = false
        })
        hideDetailAnimator.startAnimation()
    }
    
    @objc func addArrangedSubviewToStack(_: AnyObject) {
        // Create a simple, fixed-size, square view to add to the stack view.
        let newViewSize = CGSize(width: 38, height: 38)
        let newView = UIView(frame: CGRect(origin: CGPoint.zero, size: newViewSize))
        newView.backgroundColor = randomColor()
        [newView.widthAnchor.constraint(equalToConstant: newViewSize.width),
        newView.heightAnchor.constraint(equalToConstant: newViewSize.height),
        ].forEach({ $0.isActive = true})
        
        // Adding an arranged subview automatically adds it as a child of the stack view.
        addRemoveExampleStackView.addArrangedSubview(newView)
        
        updateAddRemoveButtons()
    }
    
    @objc func removeArrangedSubviewFromStack(_: AnyObject) {
        // Make sure there is an arranged view to remove.
        guard let viewToRemove = addRemoveExampleStackView.arrangedSubviews.last else { return }
        
        addRemoveExampleStackView.removeArrangedSubview(viewToRemove)
        
        /**    Calling `removeArrangedSubview` does not remove the provided view from
         the stack view's `subviews` array. Since we no longer want the view
         we removed to appear, we have to explicitly remove it from its superview.
         */
        viewToRemove.removeFromSuperview()
        
        updateAddRemoveButtons()
    }
    
    // MARK: - Convenience
    
    func updateAddRemoveButtons() {
        let arrangedSubviewCount = addRemoveExampleStackView.arrangedSubviews.count
        
        addViewButton.isEnabled = arrangedSubviewCount < maximumArrangedSubviewCount
        removeViewButton.isEnabled = arrangedSubviewCount > 0
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255)) / 255.0
        let green = CGFloat(arc4random_uniform(255)) / 255.0
        let blue = CGFloat(arc4random_uniform(255)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}
