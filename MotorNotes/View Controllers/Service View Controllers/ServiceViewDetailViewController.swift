//
//  ServiceViewDetailViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/27/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class ServiceViewDetailViewController: UIViewController {
    
    var carID: String = ""
    var serviceID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debug info
        print("[ServiceViewDetailViewController] - Car ID is: \(carID) and Service ID is: \(serviceID)")
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
