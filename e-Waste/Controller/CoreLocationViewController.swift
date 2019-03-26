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
}
