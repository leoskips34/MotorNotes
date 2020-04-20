//
//  Utilities.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/11/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static let purpleColor = UIColor.init(red: 98/255, green: 26/255, blue: 156/255, alpha: 1)
    
    // MARK: - UITextField Designs
    static func styleTextField(_ textfield: UITextField) {
        
        // Create the bottom layer
        let bottomLine = CALayer()
                
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = purpleColor.cgColor
        
        // Remove border on text field
        textfield.borderStyle = UITextField.BorderStyle.none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
        textfield.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
    }
    
    // MARK: - UIButton Designs
    static func styleFilledButton(_ button: UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = purpleColor
        button.layer.cornerRadius = 15
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 23.0
        button.tintColor = UIColor.black
    }
    
    // MARK: - UITextView Designs
    static func styleTextView(_ textView: UITextView) {
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = purpleColor.cgColor
        textView.layer.cornerRadius = 15
    }
    
    static func showError(_ label: UILabel, message: String) {
        label.text = message
        label.alpha = 1
    }

    // MARK: - Field Validation
    static func isPasswordValid(_ password: String) -> Bool {
        
        // Minimum of 8 characters with at least 1 alphabet character, 1 number, and 1 special character
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        
        return passwordTest.evaluate(with: password)
    }
}
