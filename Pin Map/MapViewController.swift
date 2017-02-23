//
//  MapViewController.swift
//  Pin Map
//
//  Created by Michael Montoya on 2/9/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    //==================================================
    // MARK: Outlet
    //==================================================
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    var annotations: [MKPointAnnotation] = []
    
    //==================================================
    // MARK: Lifecycle Functions
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLocations()
    }
    
    //==================================================
    // MARK: Actions
    //==================================================
    @IBAction func logOutButtonTapped(_ sender: Any) {
        
        Client.shared.logout { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else if error == "The Internet connection appears to be offline." {
                DispatchQueue.main.async {
                    //present error.
                }
            } else {
                //present error.
            }
        }
    }
    
    
    @IBAction func pinButtonTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        Client.shared.getStudentLocationsFromParse { (success, error) in
            if success {
                self.mapView.removeAnnotations(self.annotations)
                self.loadLocations()
            } else if error == "The Internet connection appears to be offline." {
                DispatchQueue.main.async {
                    //present Error.
                }
            } else {
                // present error
            }
        }
    }
    
    //==================================================
    // MARK: Map Functions
    //==================================================
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        
        if pinView != nil {
            pinView?.annotation = annotation
        } else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let shared = UIApplication.shared
            guard let urlString = view.annotation?.subtitle  else {
                return
            }
            
            let url = URL(string: urlString!)
            shared.canOpenURL(url!)
        }
    }
    
    func loadLocations() {
        guard let locations = Constants.Parse.studentLocations else { return }
        
        for location in locations {
            if let latitude = location["latitude"] as? Double {
                if let longitude = location["longitude"] as? Double {
                    
                    var firstName = "NIL"
                    var lastName  = "NIL"
                    
                    if let first = location["firstName"] as? String {
                        firstName = first
                    }
                    
                    if let last = location["lastName"] as? String {
                        lastName = last
                    }

                    let latDegrees = CLLocationDegrees(latitude)
                    let longDegrees = CLLocationDegrees(longitude)
                    let coordinate = CLLocationCoordinate2D(latitude: latDegrees, longitude: longDegrees)
                    let mediaURL = location["mediaURL"] as! String
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(firstName) \(lastName)"
                    annotation.subtitle = mediaURL
                    annotations.append(annotation)
                }
            }
        }
        
        self.mapView.addAnnotations(annotations)
    }
}
