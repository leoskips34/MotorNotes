//
//  ServiceListViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class ServiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var carID: String = ""
    var db: Firestore!
    var serviceList = [[String: String]]()
    var serviceDocumentID = [String]()
    var serviceSelectedRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firestore setup
        db = Firestore.firestore()
        
        // TableView stuff
        tableView.delegate = self
        tableView.dataSource = self
        
        // Debug info
        print("[ServiceListViewController] - Car ID is: \(carID)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadServiceData()
    }
    
    // MARK: - Firestore data loading
    @objc func loadServiceData() {
        
        serviceList.removeAll()
        serviceDocumentID.removeAll()
        
        let service = db.collection("users").document(Constants.Authentication.user).collection("cars").document(carID).collection("servicerecords")
        
        service.getDocuments() { (querySnapsnot, err) in
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapsnot!.documents {
                    
                    let data = document.data()
                    let serviceRecordTitle = data["servicerecordtitle"] as? String ?? ""
                    let serviceType = data["servicetype"] as? String ?? ""
                    let serviceTotalCost = data["servicetotalcost"] as? String ?? ""
                    
                    let newServiceRecord = [
                        "servicerecordtitle": serviceRecordTitle,
                        "servicetype": serviceType,
                        "servicetotalcost": serviceTotalCost,
                    ]
                    
                    self.serviceList.append(newServiceRecord)
                    self.serviceDocumentID.append(document.documentID)
                    
                    // Debug info
                    print("[ServiceListViewController] Document ID: \(document.documentID) for service record \(serviceRecordTitle)")
                    print(self.serviceList)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ServiceCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ServiceCell else {
            fatalError("The dequeued cell is not an instance of ServiceCell")
        }
        
        let service = serviceList[indexPath.row]
        
        cell.serviceRecordTitleLabel.text = service["servicerecordtitle"]
        cell.serviceTypeLabel.text = service["servicetype"]
        cell.serviceTotalCostLabel.text = service["servicetotalcost"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        serviceSelectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: Constants.Storyboard.serviceRecordDetailSegueIdentifier, sender: self)
    }
    

    // MARK: - Segue Transitioner
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Storyboard.serviceRecordDetailSegueIdentifier {
            
            if let destVC = segue.destination as? ServiceViewDetailViewController {
                destVC.carID = carID
                destVC.serviceID = serviceDocumentID[serviceSelectedRow!]
            }
        }
    }
}
