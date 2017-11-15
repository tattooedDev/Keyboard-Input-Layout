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
	
    var accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = UIColor.lightGray
        accessoryView.alpha = 0.6
        return accessoryView
    }()
    
    var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
    
    var charactersLeftLabel: UILabel = {
        let charactersLeftLabel = UILabel()
        charactersLeftLabel.text = "256"
        charactersLeftLabel.textColor = UIColor.white
        return charactersLeftLabel
        
    }()
    
    var sendButton: UIButton! = {
        let sendButton = UIButton(type: .custom)
        sendButton.setTitleColor(UIColor.red, for: .normal)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(UIColor.white, for: .disabled)
        sendButton.addTarget(self, action: #selector(sendButtonTapped(sender:)), for: .touchUpInside)
        sendButton.showsTouchWhenHighlighted = true
        sendButton.isEnabled = true
        return sendButton
    }()
	
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
        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
				
		self.textView.inputAccessoryView = accessory

        accessory.addSubview(cancelButton)
        accessory.addSubview(charactersLeftLabel)
		accessory.addSubview(sendButton)
		
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: accessory.leadingAnchor, constant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: accessory.centerYAnchor),
        
            charactersLeftLabel.centerXAnchor.constraint(equalTo: accessory.centerXAnchor),
            charactersLeftLabel.centerYAnchor.constraint(equalTo: accessory.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: accessory.trailingAnchor, constant: -20),
            sendButton.centerYAnchor.constraint(equalTo: accessory.centerYAnchor)
            ])
	}
	
	@objc func sendButtonTapped(sender: UIButton) {
		self.view.endEditing(true)
	}
	
	@objc func cancelButtonTapped(sender: UIButton) {
		print("Cancel Button Tapped")
	}
	
	func calculateCharacters() {
		let length = textView.text.count
		
		let charsLeft = 256 - length
		self.charactersLeftLabel.text = "\(charsLeft)"
		self.sendButton.isEnabled = charsLeft >= 0 && length > 0
	}
	
	func textViewDidChange(_ textView: UITextView) {
		calculateCharacters()
	}	
}
