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
    
    @IBOutlet weak var fuelTitleLabel: UILabel!
    @IBOutlet weak var fuelImageView: UIImageView!
    @IBOutlet weak var fuelDateLabel: UILabel!
    @IBOutlet weak var fuelOdometerLabel: UILabel!
    @IBOutlet weak var fuelGallonsLabel: UILabel!
    @IBOutlet weak var fuelPricePerGallonLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var fuelTotalCostLabel: UILabel!
    @IBOutlet weak var fuelNotesLabel: UILabel!
    
    var carID: String = ""
    var fuelID: String = ""
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Debug info
        print("[FuelViewDetailViewController] - Car ID is: \(carID) and Fuel ID is: \(fuelID)")
    }
    
    // MARK: - Firestore data loading for selected fuel record
    func loadFuelData() {
        
    }
    
    // MARK: - Edit Fuel Record
    @IBAction func editFuelRecord(_ sender: Any) {
    }
    
    // MARK: - Delete Fuel Record
    @IBAction func deleteFuelRecord(_ sender: Any) {
    }
    
}
