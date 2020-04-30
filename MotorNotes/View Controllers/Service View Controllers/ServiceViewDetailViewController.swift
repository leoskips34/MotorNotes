//
//  ServiceViewDetailViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class ServiceViewDetailViewController: UIViewController {
    
    @IBOutlet weak var serviceTitleLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceDateLabel: UILabel!
    @IBOutlet weak var serviceOdometerLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var serviceShopNameLabel: UILabel!
    @IBOutlet weak var serviceShopLocationLabel: UILabel!
    @IBOutlet weak var serviceTotalCostLabel: UILabel!
    @IBOutlet weak var serviceNotesLabel: UILabel!
    
    var carID: String = ""
    var serviceID: String = ""
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        loadServiceData()
        
        // Debug info
        print("[ServiceViewDetailViewController] - Car ID is: \(carID) and Service ID is: \(serviceID)")
    }
    
    // MARK: - Firestore data loading for selected service record
    func loadServiceData() {
        
        let selectedServiceRecord = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("servicerecords").document(serviceID)
        
        selectedServiceRecord.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                // Create cleaned data from query
                let data = document.data()!
                let serviceTitle = data["servicerecordtitle"] as? String ?? ""
                let serviceDate = data["servicedate"] as? String ?? ""
                let serviceOdometer = data["serviceodometer"] as? String ?? ""
                let serviceType = data["servicetype"] as? String ?? ""
                let serviceShopName = data["serviceshopname"] as? String ?? ""
                let serviceShopLocation = data["serviceshoplocation"] as? String ?? ""
                let serviceTotalCost = data["servicetotalcost"] as? String ?? ""
                let serviceNotes = data["servicenotes"] as? String ?? ""
                
                // Assign label text to cleaned data
                self.serviceTitleLabel.text = serviceTitle
                self.serviceDateLabel.text = serviceDate
                self.serviceOdometerLabel.text = serviceOdometer
                self.serviceTypeLabel.text = serviceType
                self.serviceShopNameLabel.text = serviceShopName
                self.serviceShopLocationLabel.text = serviceShopLocation
                self.serviceTotalCostLabel.text = serviceTotalCost
                self.serviceNotesLabel.text = serviceNotes
                
                // Debug info
                print("[ServiceViewDetailViewController] Service Title test: ")
                print("[ServiceViewDetailViewController] Document data: \(dataDescription)")
            } else {
                print("[ServiceViewDetailViewController] Error reading document")
            }
        }
    }
    
    // MARK: - Edit Service Record
    @IBAction func editServiceRecord(_ sender: Any) {
    }
    
    // MARK: - Delete Service Record
    @IBAction func deleteServiceRecord(_ sender: Any) {
    }
}
