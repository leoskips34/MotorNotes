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
        
        // Debug info
        print("[ServiceViewDetailViewController] - Car ID is: \(carID) and Service ID is: \(serviceID)")
    }
    
    // MARK: - Firestore data loading for selected service record
    func loadServiceData() {
        
    }
    
    // MARK: - Edit Service Record
    @IBAction func editServiceRecord(_ sender: Any) {
    }
    
    // MARK: - Delete Service Record
    @IBAction func deleteServiceRecord(_ sender: Any) {
    }
}
