//
//  KeyboardViewDecorator.swift
//  CombineChat
//
//  Created by Niklas Holloh on 07.06.19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import Foundation
import UIKit

class KeyboardViewDecorator {
    
    private let decoratedView: UIView
    private let paddedView: UIView
    private let keyboardView: UIView
    private let minimumPadding: CGFloat
    
    private var heightConstraint: NSLayoutConstraint!
    
    var topAnchor: NSLayoutYAxisAnchor {
        return keyboardView.topAnchor
    }
    
    init(paddedView: UIView, minimumPadding: CGFloat = 32) {
        self.paddedView = paddedView
        
        guard let decoratedView = paddedView.superview else {
            fatalError("Padded view needs to have a superview!")
        }
        
        self.decoratedView = decoratedView
        self.minimumPadding = minimumPadding
        
        keyboardView = UIView()
        
        addAsSubview()
        setupConstraints()
        addNotificationObservers()
    }
    
    private func addAsSubview() {
        decoratedView.addSubview(keyboardView)
    }
    
    private func setupConstraints() {
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.leadingAnchor.constraint(equalTo: decoratedView.leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: decoratedView.trailingAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: decoratedView.bottomAnchor).isActive = true
        heightConstraint = keyboardView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        
        topAnchor.constraint(greaterThanOrEqualTo: paddedView.bottomAnchor, constant: minimumPadding).isActive = true
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
                return
        }
        
        UIView.animate(withDuration: duration.doubleValue) {
            self.heightConstraint.constant = keyboardSize.cgRectValue.height
            self.decoratedView.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
                return
        }
        
        UIView.animate(withDuration: duration.doubleValue) {
            self.heightConstraint.constant = 0
            self.decoratedView.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
