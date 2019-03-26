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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
    }
    
    func setLocation() {
        
        areaMapView.showsUserLocation = true
        
    }
}
