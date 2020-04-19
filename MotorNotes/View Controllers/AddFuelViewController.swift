//
//  AddFuelViewController.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/17/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import UIKit

class AddFuelViewController: UIViewController {

    
    @IBAction func backToEditPage(_ sender: Any) {
        self.performSegue(withIdentifier: "backToEditPageSegue", sender: self)
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
