//
//  LoginViewController.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/9/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //==================================================
    // MARK: Outlets
    //==================================================
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    //==================================================
    // MARK: Lifecycle Functions
    //==================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //==================================================
    // MARK: Actions
    //==================================================
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            
            // Present error alert that says please enter email and password fields.
        } else {
            
            let url = Constants.Udacity.sessionURL
            let httpMessageBody = "{\"udacity\": {\"username\": \"\(self.emailTextField.text!)\", \"password\": \"\(self.passwordTextField.text!)\"}}"
            
            Client.shared.postForUdacity(urlAsString: url, httpMessageBody: httpMessageBody, completionHandlerForPost: { (resultsDictionary, error) in
                guard (error == "") else {
                    if error == "The Internet connection appears to be offline" {
                        //PRESENT ALERTCONTROLLER
                        print("Error in post")
                    } else {
                        //PRESENT ALERTCONTROLLER
                        print("Error in post")
                    }
                    
                    return
                }
                
                // Parse data
                guard let data = resultsDictionary as? [String : Any] else {
                    //Present Error.
                    return
                }
                
                guard let session = data["session"] as? [String : Any] else {
                    // Present error.
                    return
                }
                
                guard let sessionID = session["id"] as? String else {
                    //Present error.
                    return
                }
                
                Constants.Udacity.sessionID = sessionID
            
                guard let accountData = data["account"] as? [String : Any] else {
                    // Present Error.
                    return
                }
                
                guard let userID = accountData["key"] as? String else {
                    return
                }
                Constants.Udacity.userID = userID
                
                Client.shared.getForUdacity(urlAsString: Constants.Udacity.userDetailsURL, completionHandlerForGet: { (resultsDictionary, error) in
                    
                    guard (error == "") else {
                        //Present error.
                        return
                    }
                    
                    guard let data = resultsDictionary as? [String : Any] else {
                        // Present error.
                        return
                    }
                    
                    guard let user = data["user"] as? [String : Any] else {
                        return
                    }
                    
                    guard let firstName = user["first_name"] as? String else {
                        return
                    }
                    Constants.Udacity.firstName = firstName
                    
                    guard let lastName = user["last_name"] as? String else {
                        return
                    }
                    Constants.Udacity.lastName = lastName
                    
                    Client.shared.getStudentLocationsFromParse(completionHandlerForLocations: { (success, error) in
                        if success {
                            DispatchQueue.main.async {
                                
                                self.instantiateMapVC()
                            }
                        } else {
                            //Present error
                        }
                    })
                })
            })
        }
    }
    
    
        @IBAction func signUpButtonTapped(_ sender: Any) {
    
    
        }
    
    
    //==================================================
    // MARK: Functions
    //==================================================
    
    func instantiateMapVC() {
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as! UITabBarController
        self.present(destVC, animated: true, completion: nil)
    }
    
}
