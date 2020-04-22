//
//  HomeViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/11/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    @IBOutlet weak var trailingCon: NSLayoutConstraint!
    
    var menuOut = false
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Firestore setup
        db = Firestore.firestore()
        
        loadData()
    }
    
    // MARK: - Firestore data loading
    func loadData() {
        db.collection("users").document(Constants.Authentication.user).collection("cars").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
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
}
