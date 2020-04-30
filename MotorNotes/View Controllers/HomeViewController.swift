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
    var carDocumentId = [String]()
    var carSelectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Firestore setup
        db = Firestore.firestore()
        
        // TableView stuff
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadData()
        
        self.putInHamburgerMenu()
    }
    
    // MARK: - Firestore data loading
    @objc func loadData() {
        
        carArray.removeAll()
        
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
                    self.carDocumentId.append(document.documentID)
                    
                    // Debug info
                    print("[HomeViewController] Document ID: \(document.documentID) for car \(carNickname)")
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
            pullOutHamburgerMenu()
        } else {
            putInHamburgerMenu()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The hamburger menu button has been pressed")
        }
    }
    
    func pullOutHamburgerMenu() {
        leadingCon.constant = 150
        trailingCon.constant = -150
        menuOut = true
    }
    
    func putInHamburgerMenu() {
        leadingCon.constant = 0
        trailingCon.constant = 0
        menuOut = false
    }
    
    // MARK: - TableView functions
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        carSelectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: Constants.Storyboard.viewCarSegueIdentifier, sender: self)
    }
    
    // MARK: - Segue Transitioner
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Storyboard.viewCarSegueIdentifier {
            
            if let destVC = segue.destination as? CarViewDetailViewController {
                destVC.carID = carDocumentId[carSelectedRow!]
            }
        }
    }
}
