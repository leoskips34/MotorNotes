//
//  Constants.swift
//  MotorNotes
//
//  Created by Jonathon Chenvert on 4/11/20.
//  Copyright © 2020 Jonathon Chenvert. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let homeNavigationController = "HomeNavigationVC"
        static let loginNavigationController = "LoginNavigationVC"
    }
    
    static func authPersistence(_ authStatus: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(authStatus, forKey: "usersignedin")
        userDefaults.synchronize()
        
        if authStatus {
            
            // User is logged in
            print("User has signed in.")
        } else {
            
            // User has signed out
            print("User has signed out.")
        }
    }
}
