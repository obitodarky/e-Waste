//
//  CoreLocationViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 26/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class CoreLocationViewController: ViewController {
    
    var locationManager: CLLocationManager?
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @IBAction func startLocationManager(_ sender: UIButton)
    {
        
        if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            
            activateLocationServices()
        } else {
            
            locationManager?.requestWhenInUseAuthorization()
        }
        
    }
    
    private func activateLocationServices(){
        
        locationManager?.startUpdatingLocation()
    }
    
    
}

extension CoreLocationViewController: CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            
            activateLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(previousLocation == nil){
            
            previousLocation =  locations.first
        }
        
        else {
            
            guard let latestLocation = locations.first else { return }
            
            let distanceInMeters = previousLocation?.distance(from: latestLocation) ?? 0
            
            print("distance : \(distanceInMeters)")
            
            previousLocation = latestLocation
        } 
    }
}
