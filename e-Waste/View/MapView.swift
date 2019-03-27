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
    let locationRequest = CoreLocationViewController()
    var centralLocation: Double = 1000
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaMapView.delegate = self
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
        locationManager.startUpdatingLocation()
        centerLocation()
        setAnnotations()
        
    }
    
    private func setAnnotations(){
        
        let trashLocation = MKPointAnnotation()
        trashLocation.subtitle =   "Trash"
        trashLocation.coordinate = CLLocationCoordinate2D(latitude: 22.292009, longitude: 73.122745)
        
        areaMapView.addAnnotation(trashLocation)
        
    }
}

extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center , latitudinalMeters: centralLocation, longitudinalMeters: centralLocation)
        
        areaMapView.setRegion(region, animated: true)
        setAnnotations()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = areaMapView.dequeueReusableAnnotationView(withIdentifier: "Annotations")
        
        if annotationView == nil{
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationViews")
        }
        
        if (annotation.subtitle == "Trash"){
            
            annotationView?.image = UIImage(named: "trash-can")
        }
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //code
    }
    
}


