//
//  TextViewDefaultController.swift
//  framework
//
//  Created by Pitchaorn on 6/5/18.
//  Copyright © 2018 freewillsolutions. All rights reserved.
//

import UIKit

class TextViewDefaultController: UIViewController {
    
    // MARK: - Properties
    
    var constraintCollector = [NSLayoutConstraint]()
    
    var bottomConstaint: NSLayoutConstraint!
    
    
    lazy var textView: UITextView = {
        [unowned self] in
        
        let textview = UITextView()
        
        textview.text = "This is a UITextView that uses attributed text. You can programmatically modify the display of the text by making it bold, highlighted, underlined, tinted, and more. These attributes are defined in NSAttributedString.h. You can even embed attachments in an NSAttributedString!"
        textview.isScrollEnabled = true
        
        
        return textview
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        configureTextView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen for changes to keyboard visibility so that we can adjust the text view accordingly.
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(TextViewDefaultController.handleKeyboardNotification(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(TextViewDefaultController.handleKeyboardNotification(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


   
    
    // MARK: - Keyboard Event Notifications
    
    @objc
    func handleKeyboardNotification(_ notification: Notification) {
        let userInfo = notification.userInfo!
        
        // Get information about the animation.
        var animationDuration: TimeInterval = 0
        if let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            animationDuration = value.doubleValue
        }
        
        // Convert the keyboard frame from screen to view coordinates.
        var keyboardScreenBeginFrame = CGRect()
        if let value = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue) {
            keyboardScreenBeginFrame = value.cgRectValue
        }
        
        var keyboardScreenEndFrame = CGRect()
        if let value = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) {
            keyboardScreenEndFrame = value.cgRectValue
        }
        
        let keyboardViewBeginFrame = view.convert(keyboardScreenBeginFrame, from: view.window)
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y
        
        // The text view should be adjusted, update the constant for this constraint.
        bottomConstaint.constant -= originDelta
        
        // Inform the view that its autolayout constraints have changed and the layout should be updated.
        view.setNeedsUpdateConstraints()
        
        // Animate updating the view's layout by calling layoutIfNeeded inside a `UIViewPropertyAnimator` animation block.
        let textViewAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeIn, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
        textViewAnimator.startAnimation()
        
        // Scroll to the selected text once the keyboard frame changes.
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    fileprivate func setupView() {
        view.removeConstraints(constraintCollector)
        
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.delegate = self
        
        view.addConstraints(with: "H:|-left-[v0]-right-|", to: textView, constraintCollector: &constraintCollector)
        view.addConstraints(with: "V:|-top-[v0]", to: textView, constraintCollector: &constraintCollector) 
        bottomConstaint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstaint)
        
    }
    
    
    
    // MARK: - Configuration
    
    func configureTextView() {
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body)
        let bodyFont = UIFont(descriptor: bodyFontDescriptor, size: 0)
        
        textView.font = bodyFont
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = true
        
        /** Let's modify some of the attributes of the attributed string.
         You can modify these attributes yourself to get a better feel for what they do.
         Note that the initial text is visible in the storyboard.
         */
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText!)
        
        /** Use NSString so the result of rangeOfString is an NSRange, not Range<String.Index>.
         This will then be the correct type to then pass to the addAttribute method of
         NSMutableAttributedString.
         */
        let text = textView.text! as NSString
        
        // Find the range of each element to modify.
        let boldRange = text.range(of: NSLocalizedString("bold", comment: ""))
        let highlightedRange = text.range(of: NSLocalizedString("highlighted", comment: ""))
        let underlinedRange = text.range(of: NSLocalizedString("underlined", comment: ""))
        let tintedRange = text.range(of: NSLocalizedString("tinted", comment: ""))
        
        /**    Add bold. Take the current font descriptor and create a new font descriptor
         with an additional bold trait.
         */
        let boldFontDescriptor = textView.font!.fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 0)
        attributedText.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)
        
        // Add highlight.
        attributedText.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.tintGreen(), range: highlightedRange)
        
        // Add underline.
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: underlinedRange)
        
        // Add tint.
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tintBlue(), range: tintedRange)
        
        // Add image attachment.
        let textAttachment = NSTextAttachment()
        let image = #imageLiteral(resourceName: "text_view_attachment")
        textAttachment.image = image
        textAttachment.bounds = CGRect(origin: CGPoint.zero, size: image.size)
        
        let textAttachmentString = NSAttributedString(attachment: textAttachment)
        attributedText.append(textAttachmentString)
        
        // Append a space with matching font of the rest of the body text.
        let appendedSpace = NSMutableAttributedString(string: " ")
        appendedSpace.addAttribute(NSAttributedString.Key.font, value: bodyFont, range: NSRange(location: 0, length: 1))
        attributedText.append(appendedSpace)
        textView.font = UIFont.RSU(size: 20)
        textView.attributedText = attributedText
    }
    
    // MARK: - Actions
    
    @objc
    func doneBarButtonItemClicked() {
        // Dismiss the keyboard by removing it as the first responder.
        textView.resignFirstResponder()
        
        navigationItem.setRightBarButton(nil, animated: true)
    }
}
// MARK: - UITextViewDelegate

extension TextViewDefaultController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Provide a "Done" button for the user to select to signify completion with writing text in the text view.
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                target: self,
                                                action: #selector(TextViewDefaultController.doneBarButtonItemClicked))
        
        navigationItem.setRightBarButton(doneBarButtonItem, animated: true)
    }
    
}
