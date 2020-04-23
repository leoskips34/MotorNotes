//
//  HomeViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/11/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    @IBOutlet weak var trailingCon: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var menuOut = false
    var db: Firestore!
    var carArray = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Firestore setup
        db = Firestore.firestore()
        
        // TableView stuff
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    // MARK: - Firestore data loading
    func loadData() {
        
        db.collection("users").document(Constants.Authentication.user).collection("cars").getDocuments() { (querySnapshot, err) in
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let data = document.data()
                    let carNickname = data["carnickname"] as? String ?? ""
                    let carMake = data["make"] as? String ?? ""
                    let carModel = data["model"] as? String ?? ""
                    let carYear = data["year"] as? String ?? ""
                    let carOdometer = data["odometer"] as? String ?? ""
                    let carLicensePlateNumber = data["licenseplatenumber"] as? String ?? ""
                    let carVin = data["vinnumber"] as? String ?? ""
                    let carRegistrationDate = data["registrationdate"] as? String ?? ""
                    let carColor = data["carcolor"] as? String ?? ""
                    
                    let newCar = [
                        "carnickname": carNickname,
                        "make": carMake,
                        "model": carModel,
                        "year": carYear,
                        "odometer": carOdometer,
                        "licenseplatenumber": carLicensePlateNumber,
                        "vinnumber": carVin,
                        "registrationdate": carRegistrationDate,
                        "carcolor": carColor,
                    ]
                    
                    self.carArray.append(newCar)
                    print(self.carArray)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Hamburger Menu
    @IBAction func menuTapped(_ sender: Any) {
    
        if !menuOut {
            leadingCon.constant = 150
            trailingCon.constant = -150
            menuOut = true
        } else {
            leadingCon.constant = 0
            trailingCon.constant = 0
            menuOut = false
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The hamburger menu button has been pressed")
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CarCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CarCell else {
            fatalError("The dequeued cell is not an instance of CarCell")
        }
        
        let car = carArray[indexPath.row]
        
        cell.carNicknameLabel.text = car["carnickname"]
        cell.carOdometerLabel.text = car["odometer"]
        cell.carRegistrationDateLabel.text = car["registrationdate"]
        
        print("Cell passed")
        return cell
        
    }
}
