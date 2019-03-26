//
//  MapView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 26/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapView: ViewController {
    
    
    @IBOutlet var areaMapView: MKMapView!
    
    var centralLocation: Double = 10000
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
    }
    
    func setLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerLocation(){
    
        if let location = locationManager.location?.coordinate{
            
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: centralLocation , longitudinalMeters: centralLocation)
            areaMapView.setRegion(region, animated: true)
        }
    }
    
    func setLocation() {
        
        areaMapView.showsUserLocation = true
        centerLocation()
        
    }
}

extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //code
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //code
    }
    
}
