//
//  FuelViewDetailViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class FuelViewDetailViewController: UIViewController {
    
    // Fuel info labels
    @IBOutlet weak var fuelTitleLabel: UILabel!
    @IBOutlet weak var fuelImageView: UIImageView!
    @IBOutlet weak var fuelDateLabel: UILabel!
    @IBOutlet weak var fuelOdometerLabel: UILabel!
    @IBOutlet weak var fuelGallonsLabel: UILabel!
    @IBOutlet weak var fuelPricePerGallonLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var fuelTotalCostLabel: UILabel!
    @IBOutlet weak var fuelNotesLabel: UILabel!
    
    var carID: String = "" // Selected car from HomeVC
    var fuelID: String = "" // Selected fuel record from FuelListVC
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        loadFuelData()

        // Debug info
        print("[FuelViewDetailViewController] - Car ID is: \(carID) and Fuel ID is: \(fuelID)")
    }
    
    // MARK: - Firestore data loading for selected fuel record
    func loadFuelData() {
        
        let selectedFuelRecord = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("fuelrecords").document(fuelID)
        
        selectedFuelRecord.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                // Create cleaned data from query
                let data = document.data()!
                let fuelTitle = data["fuelrecordtitle"] as? String ?? ""
                let fuelDate = data["fueldate"] as? String ?? ""
                let fuelOdometer = data["fuelodometer"] as? String ?? ""
                let fuelGallons = data["fuelgallonsfilled"] as? String ?? ""
                let fuelPricePerGallon = data["fuelpricepergallon"] as? String ?? ""
                let fuelType = data["fueltype"] as? String ?? ""
                let fuelTotalCost = data["fueltotalcost"] as? String ?? ""
                let fuelNotes = data["fuelnotes"] as? String ?? ""
                
                // Assign label text to cleaned data
                self.fuelTitleLabel.text = fuelTitle
                self.fuelDateLabel.text = fuelDate
                self.fuelOdometerLabel.text = fuelOdometer
                self.fuelGallonsLabel.text = fuelGallons
                self.fuelPricePerGallonLabel.text = fuelPricePerGallon
                self.fuelTypeLabel.text = fuelType
                self.fuelTotalCostLabel.text = fuelTotalCost
                self.fuelNotesLabel.text = fuelNotes
                
                // Debug info
                print("[FuelViewDetailViewController] Fuel Title test: \(fuelTitle)")
                print("[FuelViewDetailViewController] Document data: \(dataDescription)")
            } else {
                print("[FuelViewDetailViewController] Error reading document")
            }
        }
    }
    
    // MARK: - Edit Fuel Record
    @IBAction func editFuelRecord(_ sender: Any) {
    }
    
    // MARK: - Delete Fuel Record
    @IBAction func deleteFuelRecord(_ sender: Any) {
    }
    
}
