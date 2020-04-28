//
//  AddServiceViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/17/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class AddServiceViewController: UIViewController {

    @IBOutlet weak var serviceRecordTitleTextField: UITextField!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceDateTextField: UITextField!
    @IBOutlet weak var serviceOdometerTextField: UITextField!
    @IBOutlet weak var serviceTypeTextField: UITextField!
    @IBOutlet weak var serviceShopNameTextField: UITextField!
    @IBOutlet weak var serviceShopLocationTextField: UITextField!
    @IBOutlet weak var serviceTotalCostTextField: UITextField!
    @IBOutlet weak var serviceNotesTextView: UITextView!
    @IBOutlet weak var saveServiceRecordButton: UIButton!
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
        print("[AddServiceViewController] - Car ID is: \(carID)")
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
    
    // MARK: - Form Validation
    func validateServiceFields() -> String? {
        
        // Check that all fields are filled in
        if serviceRecordTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceOdometerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceShopNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceShopLocationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceTotalCostTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    // MARK: - Firestore Create
    func createService() {
        
        // Validate fields
        let error = validateServiceFields()
        
        if error != nil {
            
            // Something wrong with the fields, show error message
            Utilities.showError(errorLabel, message: error!)
        } else {
            
            // Get cleaned versions of data
            let serviceRecordTitle = serviceRecordTitleTextField.text!
            let serviceDate = serviceDateTextField.text!
            let serviceOdometer = serviceOdometerTextField.text!
            let serviceType = serviceTypeTextField.text!
            let serviceShopName = serviceShopNameTextField.text!
            let serviceShopLocation = serviceShopLocationTextField.text!
            let serviceTotalCost = serviceTotalCostTextField.text!
            let serviceNotes = serviceNotesTextView.text ?? ""
            
            // Add data to Firestore
            var ref: DocumentReference? = nil
            let serviceCollection = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("servicerecords")
            
            ref = serviceCollection.addDocument(data: [
                "servicerecordtitle": serviceRecordTitle,
                "servicedate": serviceDate,
                "serviceodometer": serviceOdometer,
                "servicetype": serviceType,
                "serviceshopname": serviceShopName,
                "serviceshoplocation": serviceShopLocation,
                "servicetotalcost": serviceTotalCost,
                "servicenotes": serviceNotes,
            ], completion: { (err) in
                if err != nil {
                    Utilities.showError(self.errorLabel, message: err!.localizedDescription)
                } else {
                    print("Added service record with ID: \(ref!.documentID)")
                }
            })
        }
    }
    
    // MARK: - Tap Gesture Recognizer
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveServiceRecordTapped(_ sender: Any) {
        
        createService()
        
        let error = validateServiceFields()
        
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

extension AddServiceViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.serviceImageView.image = image
    }
}
