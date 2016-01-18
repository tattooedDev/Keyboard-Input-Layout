//
//  ViewController.swift
//  Layout
//
//  Created by Dennis Parussini on 17-01-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    
    var accessory: UIView!
    var cancelButton: UIButton!
    var charactersLeftLabel: UILabel!
    var sendButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        addAccessory()
        calculateCharacters()
    }

    func addAccessory() {
        let frame = CGRectMake(0, 0, self.view.frame.width, 45)
        accessory = UIView(frame: frame)
        accessory.backgroundColor = UIColor.lightGrayColor()
        accessory.alpha = 0.6
        accessory.translatesAutoresizingMaskIntoConstraints = false
        
        self.textView.inputAccessoryView = accessory
        
        cancelButton = UIButton(type: .Custom)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        cancelButton.addTarget(self, action: "cancelButtonTapped:", forControlEvents: .TouchUpInside)
        cancelButton.showsTouchWhenHighlighted = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        accessory.addSubview(cancelButton)
        
        let leadingConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Leading, relatedBy: .Equal, toItem: accessory, attribute: .Leading, multiplier: 1.0, constant: 20)
        
        accessory.addConstraint(leadingConstraint)

        let yConstraint = NSLayoutConstraint(item: cancelButton, attribute: .CenterY, relatedBy: .Equal, toItem: accessory, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        accessory.addConstraint(yConstraint)
        
        charactersLeftLabel = UILabel()
        charactersLeftLabel.text = "256"
        charactersLeftLabel.textColor = UIColor.whiteColor()
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        accessory.addSubview(charactersLeftLabel)
        
        let centerXConstraint = NSLayoutConstraint(item: charactersLeftLabel, attribute: .CenterX, relatedBy: .Equal, toItem: accessory, attribute: .CenterX, multiplier: 1.0, constant: 0)
        
        accessory.addConstraint(centerXConstraint)
        
        let centerYConstraint = NSLayoutConstraint(item: charactersLeftLabel, attribute: .CenterY, relatedBy: .Equal, toItem: accessory, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        accessory.addConstraint(centerYConstraint)
        
        sendButton = UIButton(type: .Custom)
        sendButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        sendButton.addTarget(self, action: "sendButtonTapped:", forControlEvents: .TouchUpInside)
        sendButton.showsTouchWhenHighlighted = true
        sendButton.enabled = true
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        accessory.addSubview(sendButton)
        
        let sendTrailingConstraint = NSLayoutConstraint(item: sendButton, attribute: .Trailing, relatedBy: .Equal, toItem: accessory, attribute: .Trailing, multiplier: 1.0, constant: -20)
        
        accessory.addConstraint(sendTrailingConstraint)
        
        let sendCenterYConstraint = NSLayoutConstraint(item: sendButton, attribute: .CenterY, relatedBy: .Equal, toItem: accessory, attribute: .CenterY, multiplier: 1.0, constant: 0)
        
        accessory.addConstraint(sendCenterYConstraint)
        
    }
    
    func sendButtonTapped(sender: UIButton) {
        print("Send Button Tapped")
    }
    
    func cancelButtonTapped(sender: UIButton) {
        print("Cancel Button Tapped")
    }
    
    func calculateCharacters() {
        let length = textView.text.characters.count
        
        let charsLeft = 256 - length
        self.charactersLeftLabel.text = "\(charsLeft)"
        self.sendButton.enabled = charsLeft >= 0 && length > 0
    }
    
    func textViewDidChange(textView: UITextView) {
        calculateCharacters()
    }

}

