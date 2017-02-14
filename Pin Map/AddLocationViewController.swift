//
//  AddLocationViewController.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/12/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddLocationViewController: UIViewController {
    
    //==================================================
    // MARK: Outlets
    //==================================================
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    //==================================================
    // MARK: Lifecycle functions
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func findLocationButtonTapped(_ sender: Any) {
        if locationTextField.text != "" && websiteTextField.text != "" {
            
            findUserLocation(completionHandlerForFindUserLocation: { (success) in
                if success {
                    self.performSegue(withIdentifier: "addLocationToDetailView", sender: self)
                }
            })
            
        }
    }
    
    //==================================================
    // MARK: Functions
    //==================================================
    
    func findUserLocation(completionHandlerForFindUserLocation: @escaping(_ success: Bool)-> Void) {
        
        
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text!, completionHandler: { (placeMarkArray, error) in
            guard (error == nil) else {
                let errorString = error?.localizedDescription
                
                if errorString == "The operation couldn't be completed. (kCLErrorDomain error 2.)" {
                    //present error
                } else if errorString == "The operation couldn't be completed. (kCLErrorDomain error 8.)" {
                    //present error
                }
                
                return
            }
            
            guard let placeMarks = placeMarkArray else {
                return
            }
            
            guard let latitude = placeMarks.first?.location?.coordinate.latitude else {
                return
            }
            guard let longitude = placeMarks.first?.location?.coordinate.longitude else {
                return
            }
            
            Constants.Map.enteredLocation = self.locationTextField.text
            Constants.Map.enteredURL = self.websiteTextField.text
            Constants.Map.latitude = latitude
            Constants.Map.longitude = longitude
            completionHandlerForFindUserLocation(true)
        })
    }
}
