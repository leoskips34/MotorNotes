//
//  AddFuelViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/17/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class AddFuelViewController: UIViewController {

    @IBOutlet weak var fuelRecordTitleTextField: UITextField!
    @IBOutlet weak var fuelImageView: UIImageView!
    @IBOutlet weak var fuelDateEnteredTextField: UITextField!
    @IBOutlet weak var fuelOdometerTextField: UITextField!
    @IBOutlet weak var fuelGallonsFilledTextField: UITextField!
    @IBOutlet weak var fuelPricePerGallonTextField: UITextField!
    @IBOutlet weak var fuelTypeTextField: UITextField!
    @IBOutlet weak var fuelTotalCostTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveFuelRecordButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var carID: String = "" // Selected car from CarViewDetailVC
    var db: Firestore!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerDesigns()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        // Initial setup
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        // Firestore db setup
        db = Firestore.firestore()
        
        // Debug info
        print("[AddFuelViewController] - Car ID is: \(carID)")
        
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
    
    // MARK: - Form Validation
    func validateFuelFields() -> String? {
        
        // Check that all fields are filled in
        if fuelRecordTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelDateEnteredTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelOdometerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelGallonsFilledTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelPricePerGallonTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fuelTotalCostTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    // MARK: - Firestore Create
    func createFuel() {
        
        // Validate fields
        let error = validateFuelFields()
        
        if error != nil {
            
            // Something wrong with the fields, show error message
            Utilities.showError(errorLabel, message: error!)
        } else {
            
            // Get cleaned versions of data
            let fuelRecordTitle = fuelRecordTitleTextField.text!
            let fuelDate = fuelDateEnteredTextField.text!
            let fuelOdometer = fuelOdometerTextField.text!
            let fuelGallonsFilled = fuelGallonsFilledTextField.text!
            let fuelPricePerGallon = fuelPricePerGallonTextField.text!
            let fuelType = fuelTypeTextField.text!
            let fuelTotalCost = fuelTotalCostTextField.text!
            let fuelNotes = notesTextView.text ?? ""
            
            // Add data to Firestore
            var ref: DocumentReference? = nil
            let fuelCollection = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("fuelrecords")
            
            ref = fuelCollection.addDocument(data: [
                "fuelrecordtitle": fuelRecordTitle,
                "fueldate": fuelDate,
                "fuelodometer": fuelOdometer,
                "fuelgallonsfilled": fuelGallonsFilled,
                "fuelpricepergallon": fuelPricePerGallon,
                "fueltype": fuelType,
                "fueltotalcost": fuelTotalCost,
                "fuelnotes": fuelNotes,
            ], completion: { (err) in
                if err != nil {
                    Utilities.showError(self.errorLabel, message: err!.localizedDescription)
                } else {
                    print("Added fuel record with ID: \(ref!.documentID)")
                }
            })
        }
        
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveFuelRecordTapped(_ sender: Any) {
        createFuel()
        
        let error = validateFuelFields()
        
        if error == nil {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Camera alert
    @IBAction func onCameraButton(_ sender: UITapGestureRecognizer) {
        self.imagePicker.present(from: sender.view!)
    }
}

extension AddFuelViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.fuelImageView.image = image
    }
}
