//
//  FuelListViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class FuelListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var carID: String = ""
    var db: Firestore!
    var fuelList = [[String: String]]()
    var fuelDocumentID = [String]()
    var fuelSelectedRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firestore setup
        db = Firestore.firestore()

        // Debug info
        print("[FuelListViewController] - Car ID is: \(carID)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Firestore data loading
    func loadData() {
        
    }
    
    // MARK: - TableView Functions
    
    // MARK: - Segue Transitioner

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
