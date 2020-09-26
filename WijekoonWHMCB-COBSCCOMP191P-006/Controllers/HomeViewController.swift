//
//  HomeViewController.swift
//  WijekoonWHMCB-COBSCCOMP191P-006
//
//  Created by Chathura Wijekoon on 9/18/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation
import LocalAuthentication

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceID()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
        let locationManager = CLLocationManager()
                
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.tabBarController?.tabBar.isHidden = true
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                locationManager.stopUpdatingLocation()
                
                render(location)
            }
        }
        
        func render(_ location: CLLocation) {
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
        }
    
    func faceID()  {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        let ac = UIAlertController(title: "Authentication success", message: "Well Done", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Happy", style: .default))
                        self?.present(ac, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

