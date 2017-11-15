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
	
	override func viewWillAppear(_ animated: Bool) {
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
		let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45)
		accessory = UIView(frame: frame)
		accessory.backgroundColor = UIColor.lightGray
		accessory.alpha = 0.6
		accessory.translatesAutoresizingMaskIntoConstraints = false
		
		self.textView.inputAccessoryView = accessory
		
		cancelButton = UIButton(type: .custom)
		cancelButton.setTitle("Cancel", for: .normal)
		cancelButton.setTitleColor(UIColor.red, for: .normal)
		cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
		cancelButton.showsTouchWhenHighlighted = true
		cancelButton.translatesAutoresizingMaskIntoConstraints = false
		
		accessory.addSubview(cancelButton)
		
		let leadingConstraint = NSLayoutConstraint(item: cancelButton,
		                                           attribute: .leading,
		                                           relatedBy: .equal,
		                                           toItem: accessory,
		                                           attribute: .leading,
		                                           multiplier: 1.0,
		                                           constant: 20)
		
		accessory.addConstraint(leadingConstraint)
		
		let yConstraint = NSLayoutConstraint(item: cancelButton,
		                                     attribute: .centerY,
		                                     relatedBy: .equal,
		                                     toItem: accessory,
		                                     attribute: .centerY,
		                                     multiplier: 1.0,
		                                     constant: 0)
		
		accessory.addConstraint(yConstraint)
		
		charactersLeftLabel = UILabel()
		charactersLeftLabel.text = "256"
		charactersLeftLabel.textColor = UIColor.white
		charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
		
		accessory.addSubview(charactersLeftLabel)
		
		let centerXConstraint = NSLayoutConstraint(item: charactersLeftLabel,
		                                           attribute: .centerX,
		                                           relatedBy: .equal,
		                                           toItem: accessory,
		                                           attribute: .centerX,
		                                           multiplier: 1.0,
		                                           constant: 0)
		
		accessory.addConstraint(centerXConstraint)
		
		let centerYConstraint = NSLayoutConstraint(item: charactersLeftLabel,
		                                           attribute: .centerY,
		                                           relatedBy: .equal,
		                                           toItem: accessory,
		                                           attribute: .centerY,
		                                           multiplier: 1.0,
		                                           constant: 0)
		
		accessory.addConstraint(centerYConstraint)
		
		sendButton = UIButton(type: .custom)
		sendButton.setTitleColor(UIColor.red, for: .normal)
		sendButton.setTitle("Send", for: .normal)
		sendButton.setTitleColor(UIColor.white, for: .disabled)
		sendButton.addTarget(self, action: #selector(sendButtonTapped(sender:)), for: .touchUpInside)
		sendButton.showsTouchWhenHighlighted = true
		sendButton.isEnabled = true
		sendButton.translatesAutoresizingMaskIntoConstraints = false
		
		accessory.addSubview(sendButton)
		
		let sendTrailingConstraint = NSLayoutConstraint(item: sendButton,
		                                                attribute: .trailing,
		                                                relatedBy: .equal,
		                                                toItem: accessory,
		                                                attribute: .trailing,
		                                                multiplier: 1.0,
		                                                constant: -20)
		
		accessory.addConstraint(sendTrailingConstraint)
		
		let sendCenterYConstraint = NSLayoutConstraint(item: sendButton,
		                                               attribute: .centerY,
		                                               relatedBy: .equal,
		                                               toItem: accessory,
		                                               attribute: .centerY,
		                                               multiplier: 1.0,
		                                               constant: 0)
		
		accessory.addConstraint(sendCenterYConstraint)
		
	}
	
	func sendButtonTapped(sender: UIButton) {
		self.view.endEditing(true)
	}
	
	func cancelButtonTapped(sender: UIButton) {
		print("Cancel Button Tapped")
	}
	
	func calculateCharacters() {
		let length = textView.text.characters.count
		
		let charsLeft = 256 - length
		self.charactersLeftLabel.text = "\(charsLeft)"
		self.sendButton.isEnabled = charsLeft >= 0 && length > 0
	}
	
	func textViewDidChange(_ textView: UITextView) {
		calculateCharacters()
	}
	
}

