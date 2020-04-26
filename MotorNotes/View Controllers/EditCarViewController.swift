//
//  EditCarViewController.swift
//  MotorNotes
//
//  Created by Neri Garcia on 4/13/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class EditCarViewController: UIViewController {
    
    // TODO: Create labels & connect to VC
    
    var carID: String = "" // Selected car from HomeVC
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        db = Firestore.firestore()
                
        loadCarData()
    }
    
    // MARK: - Firestore data loading for selected car
    func loadCarData() {
        
        let selectedCar = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID)
        
        selectedCar.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                // TODO: Create cleaned data from query
                
                // TODO: Assign label text to cleaned data
                
                print("Document data: \(dataDescription)")
            } else {
                print("Error reading document")
            }
        }
    }
    
    // TODO: Function to transition to AddFuelVC and AddServiceVC, passing the carID
}
