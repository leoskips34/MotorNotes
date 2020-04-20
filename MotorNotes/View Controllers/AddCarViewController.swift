//
//  AddCarViewController.swift
//  MotorNotes
//
//  Created by Neri Garcia on 4/13/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddCarViewController: UIViewController {
    
    @IBOutlet weak var carNicknameTextField: UITextField!
    @IBOutlet weak var carMakeTextField: UITextField!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var carYearTextField: UITextField!
    @IBOutlet weak var carOdometerTextField: UITextField!
    @IBOutlet weak var carLicensePlateTextField: UITextField!
    @IBOutlet weak var carVinTextField: UITextField!
    @IBOutlet weak var carRegistrationDateTextField: UITextField!
    @IBOutlet weak var carColorTextField: UITextField!
    @IBOutlet weak var saveVehicleButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerDesigns()

        // Initial setup
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        // End setup
        db = Firestore.firestore()
    }
    
    // MARK: - View Controller design aspects
    func viewControllerDesigns() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Text field and button designs
        Utilities.styleTextField(carNicknameTextField)
        Utilities.styleTextField(carMakeTextField)
        Utilities.styleTextField(carModelTextField)
        Utilities.styleTextField(carYearTextField)
        Utilities.styleTextField(carOdometerTextField)
        Utilities.styleTextField(carLicensePlateTextField)
        Utilities.styleTextField(carVinTextField)
        Utilities.styleTextField(carRegistrationDateTextField)
        Utilities.styleTextField(carColorTextField)
        Utilities.styleFilledButton(saveVehicleButton)
    }
    
    // MARK: - Form validation
    func validateVehicleFields() -> String? {
        
        // Check that all fields are filled in
        if carNicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carMakeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carModelTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carYearTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carOdometerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carLicensePlateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carVinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carRegistrationDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carColorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    // MARK: - Firestore Create
    func createVehicle() {
        
        // Validate fields
        let error = validateVehicleFields()
        
        if error != nil {
            
            // Something wrong with the fields, show error message
            Utilities.showError(errorLabel, message: error!)
            
        } else {
            
            // Get cleaned versions of data
            let carNickname = carNicknameTextField.text!
            let carMake = carMakeTextField.text!
            let carModel = carModelTextField.text!
            let carYear = carYearTextField.text!
            let carOdometer = carOdometerTextField.text!
            let carLicensePlate = carLicensePlateTextField.text!
            let carVIN = carVinTextField.text!
            let carRegistration = carRegistrationDateTextField.text!
            let carColor = carColorTextField.text!
            
            // Add data to Firebase
            var ref: DocumentReference? = nil
            
            ref = db.collection("users").document(Auth.auth().currentUser!.uid).collection("cars").addDocument(data: [
                "carnickname": carNickname,
                "make": carMake,
                "model": carModel,
                "year": carYear,
                "odometer": carOdometer,
                "licenseplatenumber": carLicensePlate,
                "vinnumber": carVIN,
                "registrationdate": carRegistration,
                "carcolor": carColor,], completion: { (err) in
                    if err != nil {
                        Utilities.showError(self.errorLabel, message: err!.localizedDescription)
                    } else {
                        print("Added vehicle with ID: \(ref!.documentID)")
                    }
            })
        }
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveVehicleTapped(_ sender: Any) {
        createVehicle()
        
        let error = validateVehicleFields()
        
        if error == nil {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
