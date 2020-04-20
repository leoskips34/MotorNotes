//
//  AddFuelViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/17/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class AddFuelViewController: UIViewController {

    @IBOutlet weak var fuelRecordTitleTextField: UITextField!
    @IBOutlet weak var fuelDateEnteredTextField: UITextField!
    @IBOutlet weak var fuelOdometerTextField: UITextField!
    @IBOutlet weak var fuelGallonsFilledTextField: UITextField!
    @IBOutlet weak var fuelPricePerGallonTextField: UITextField!
    @IBOutlet weak var fuelTypeTextField: UITextField!
    @IBOutlet weak var fuelTotalCostTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveFuelRecordButton: UIButton!
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
        Utilities.styleTextField(fuelRecordTitleTextField)
        Utilities.styleTextField(fuelDateEnteredTextField)
        Utilities.styleTextField(fuelOdometerTextField)
        Utilities.styleTextField(fuelGallonsFilledTextField)
        Utilities.styleTextField(fuelPricePerGallonTextField)
        Utilities.styleTextField(fuelTypeTextField)
        Utilities.styleTextField(fuelTotalCostTextField)
        Utilities.styleTextView(notesTextView)
        Utilities.styleFilledButton(saveFuelRecordButton)
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveFuelRecordTapped(_ sender: Any) {
    }
}
