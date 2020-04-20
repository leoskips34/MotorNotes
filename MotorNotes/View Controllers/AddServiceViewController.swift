//
//  AddServiceViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/17/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class AddServiceViewController: UIViewController {

    @IBOutlet weak var serviceRecordTitleTextField: UITextField!
    @IBOutlet weak var serviceDateTextField: UITextField!
    @IBOutlet weak var serviceOdometerTextField: UITextField!
    @IBOutlet weak var serviceTypeTextField: UITextField!
    @IBOutlet weak var serviceShopNameTextField: UITextField!
    @IBOutlet weak var serviceShopLocationTextField: UITextField!
    @IBOutlet weak var serviceTotalCostTextField: UITextField!
    @IBOutlet weak var serviceNotesTextView: UITextView!
    @IBOutlet weak var saveServiceRecordButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerDesigns()
    }
    
    // MARK: - View Controller design aspects
    func viewControllerDesigns() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Text field and button designs
        Utilities.styleTextField(serviceRecordTitleTextField)
        Utilities.styleTextField(serviceDateTextField)
        Utilities.styleTextField(serviceOdometerTextField)
        Utilities.styleTextField(serviceTypeTextField)
        Utilities.styleTextField(serviceShopNameTextField)
        Utilities.styleTextField(serviceShopLocationTextField)
        Utilities.styleTextField(serviceTotalCostTextField)
        Utilities.styleTextView(serviceNotesTextView)
        Utilities.styleFilledButton(saveServiceRecordButton)
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveServiceRecordTapped(_ sender: Any) {
    }
}
