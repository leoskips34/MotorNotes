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
    var menuOut = false
    
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
            print("The animation is complete!")
        }
        
        
    }
    @IBOutlet weak var trailingCon: NSLayoutConstraint!
    

    
    

    
    @IBAction func addCarbutton(_ sender: Any) {
        print ("Button prssed for add car")
        
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    @IBAction func editCarbutton(_ sender: Any) {
        print ("Button prssed for edit")
               
               self.performSegue(withIdentifier: "editCarSegue", sender: self)
    }
    
    @IBAction func settingsButton(_ sender: Any) {

        self.performSegue(withIdentifier: "settingSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
