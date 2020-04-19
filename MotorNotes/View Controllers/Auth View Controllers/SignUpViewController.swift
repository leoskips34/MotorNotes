//
//  SignUpViewController.swift
//
//
//  Created by Jonathon Chenvert on 4/11/20.
//
import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    // Check fields and validate data is correct. If correct, returns nil. Otherwise, returns error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        // Check password security
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a number, letter, and a special character."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate fields
        let error = validateFields()
        
        if error != nil {
            
            // Something wrong with the fields, show error message
            Utilities.showError(errorLabel, message: error!)
        } else {
            
            // Create cleaned versions of data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // Error creating a user
                    Utilities.showError(self.errorLabel, message: "Error creating user")
                } else {
                    
                    // User was created successfully; store first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["firstname": firstName, "lastname": lastName]) { (error) in
                        if error != nil {
                            
                            // Show error message
                            Utilities.showError(self.errorLabel, message: "Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeNavigationController) as! UINavigationController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
