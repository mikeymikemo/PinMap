//
//  ConfirmLocationViewController.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/12/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit
import MapKit

class ConfirmLocationViewController: UIViewController {
    
    //==================================================
    // MARK: Outlets
    //==================================================
    
    @IBOutlet weak var mapView: MKMapView!
    
    //==================================================
    // MARK: Lifecycle Functions
    //==================================================


    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUserAnnotation()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //==================================================
    // MARK: Actions
    //==================================================

    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.updateListOfStudentLocations { (success) in
            if success {
                let startingVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController")
                self.present(startingVC!, animated: true, completion: nil)
            }
        }
    }
   
    
    
    
    //==================================================
    // MARK: Functions
    //==================================================

    func addUserAnnotation() {
        
        guard let latitude = Constants.Map.latitude, let longitude = Constants.Map.longitude else { return }
        
        let annotation = MKPointAnnotation()
        annotation.title = Constants.Map.enteredLocation
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        annotation.coordinate = coordinate
        annotation.subtitle = Constants.Map.enteredURL
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotation)
    }
    
    func updateListOfStudentLocations(completionHandlerForUpdatingList: @escaping(_ success: Bool)-> Void) {
        
        addUserAnnotation()
        
        if Constants.Parse.objectID == "" {
            Client.shared.postForParse(urlAsString: Constants.Parse.studentLocationURL, httpMessageBody: Constants.Udacity.httpMessageBodyForUpdatingList, completionHandlerForPost: { (data, error) in
                
                guard error == "" else {
                    //Handle error.
                    return
                }
                
                guard let data = data as? [String : Any] else {
                    return
                }
                
                guard let objectId = data["objectId"] as? String else {
                    return
                }
                
                Constants.Parse.objectID = objectId
                
                Client.shared.getStudentLocationsFromParse(completionHandlerForLocations: { (success, error) in
                    if success {
                        completionHandlerForUpdatingList(true)
                    } else {
                        // handle error
                    }
                })
                
            })
        } else {
            Client.shared.putForParse(urlAsString: Constants.Parse.updateStudentLocationURL, httpMessageBody: Constants.Udacity.httpMessageBodyForUpdatingList , completionHandlerForPut: { (data, error) in
                
                guard error == "" else {
                    // handle error
                    return
                }
                
                guard let data = data as? [String : Any] else {
                    return
                }
                
                Client.shared.getStudentLocationsFromParse(completionHandlerForLocations: { (success, error) in
                    if success {
                        completionHandlerForUpdatingList(true)
                    } else {
                        //handle error
                    }
                })
            })
        }
    }
    
    
}
