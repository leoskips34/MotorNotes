//
//  FuelListViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class FuelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        // TableView stuff
        tableView.delegate = self
        tableView.dataSource = self

        // Debug info
        print("[FuelListViewController] - Car ID is: \(carID)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadFuelData()
    }
    
    // MARK: - Firestore data loading
    @objc func loadFuelData() {
        
        fuelList.removeAll()
        fuelDocumentID.removeAll()
        
        let fuel = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("fuelrecords")
        
        fuel.getDocuments() { (querySnapsnot, err) in
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapsnot!.documents {
                    
                    let data = document.data()
                    let fuelRecordTitle = data["fuelrecordtitle"] as? String ?? ""
                    let fuelGallonsFilled = data["fuelgallonsfilled"] as? String ?? ""
                    let fuelTotalCost = data["fueltotalcost"] as? String ?? ""
                    
                    let newFuelRecord = [
                        "fuelrecordtitle": fuelRecordTitle,
                        "fuelgallonsfilled": fuelGallonsFilled,
                        "fueltotalcost": fuelTotalCost,
                    ]
                    
                    self.fuelList.append(newFuelRecord)
                    self.fuelDocumentID.append(document.documentID)
                    
                    // Debug info
                    print("[FuelListViewController] Document ID: \(document.documentID) for fuel record \(fuelRecordTitle)")
                    print(self.fuelList)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FuelCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FuelCell else {
            fatalError("The dequeued cell is not an instance of FuelCell")
        }
        
        let fuel = fuelList[indexPath.row]
        
        cell.fuelRecordTitleLabel.text = fuel["fuelrecordtitle"]
        cell.fuelGallonsFilledLabel.text = fuel["fuelgallonsfilled"]
        cell.fuelTotalCostLabel.text = fuel["fueltotalcost"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fuelSelectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: Constants.Storyboard.fuelRecordDetailSegueIdentifier, sender: self)
    }
    
    // MARK: - Segue Transitioner
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Storyboard.fuelRecordDetailSegueIdentifier {
            
            if let destVC = segue.destination as? FuelViewDetailViewController {
                destVC.carID = carID
                destVC.fuelID = fuelDocumentID[fuelSelectedRow!]
            }
        }
    }
}
