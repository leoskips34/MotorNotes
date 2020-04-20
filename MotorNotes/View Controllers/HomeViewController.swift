//
//  HomeViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/11/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var leadingCon: NSLayoutConstraint!
    @IBOutlet weak var trailingCon: NSLayoutConstraint!
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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

    @IBAction func addCarbutton(_ sender: Any) {
        print ("Button pressed to add a car")
        
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    @IBAction func editCarbutton(_ sender: Any) {
        print ("Button pressed to edit a car")
               
        self.performSegue(withIdentifier: "editCarSegue", sender: self)
    }
}
