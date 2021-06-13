//
//  ViewController.swift
//  Layout
//
//  Created by Dennis Parussini on 17-01-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.inputAccessoryView = accessory
        
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var accessory: UIView = {
        let accessoryView = UIView(
            frame: .init(x: 0,
                         y: 0,
                         width: view.bounds.width,
                         height: 45)
        )
        accessoryView.translatesAutoresizingMaskIntoConstraints = false
        
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        
        accessoryView.addSubview(cancelButton)
        accessoryView.addSubview(charactersLeftLabel)
        accessoryView.addSubview(sendButton)
        
        return accessoryView
    }()
    
    private lazy var cancelButton: UIButton = {
        let action = UIAction(title: "Cancel") { [weak self] _ in
            guard let self = self else { return }
            
            self.view.endEditing(true)
        }
        
        let cancelButton = UIButton(type: .custom, primaryAction: action)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.showsTouchWhenHighlighted = true
        
        return cancelButton
    }()
    
    private lazy var charactersLeftLabel: UILabel = {
        let charactersLeftLabel = UILabel()
        charactersLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        charactersLeftLabel.text = "256"
        charactersLeftLabel.textColor = .white
        
        return charactersLeftLabel
        
    }()
    
    private lazy var sendButton: UIButton! = {
        let action = UIAction(title: "Send") { [weak self] _ in
            guard let self = self else { return }
            
            self.view.endEditing(true)
        }
        
        let sendButton = UIButton(type: .custom, primaryAction: action)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.white, for: .disabled)
        sendButton.showsTouchWhenHighlighted = true
        sendButton.isEnabled = true
        
        return sendButton
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateCharacters()
    }
    
    private func calculateCharacters() {
        let length = textView.text.count
        
        let charsLeft = 256 - length
        self.charactersLeftLabel.text = "\(charsLeft)"
        self.sendButton.isEnabled = charsLeft >= 0 && length > 0
    }
}

// MARK: - UITextViewDelegate
extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        calculateCharacters()
    }
}

// MARK: - Configuration
extension ViewController {
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        view.addSubview(accessory)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            cancelButton.leadingAnchor.constraint(equalTo: accessory.leadingAnchor, constant: 20),
            cancelButton.centerYAnchor.constraint(equalTo: accessory.centerYAnchor),
            
            charactersLeftLabel.centerXAnchor.constraint(equalTo: accessory.centerXAnchor),
            charactersLeftLabel.centerYAnchor.constraint(equalTo: accessory.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: accessory.trailingAnchor, constant: -20),
            sendButton.centerYAnchor.constraint(equalTo: accessory.centerYAnchor)
        ])
    }
}
