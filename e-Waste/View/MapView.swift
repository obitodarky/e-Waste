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
    let sampleTrash = MKPointAnnotation()
    //dictonary for trashcan locations : [latititude: longitute]
    let trashCans: [Double: Double] = [22.292009: 73.122745, 22.294579: 73.123123, 22.291407: 73.119975]
    
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
    
    func setAnnotations(){
        
        // Remove all annotations from map
        self.areaMapView.removeAnnotations(self.areaMapView.annotations)
        
        // Loop trough all trash places and add them to the map
        for (latitutde, longitute) in trashCans {
            let trashLocation = MKPointAnnotation()
            trashLocation.subtitle = "Trash"
            trashLocation.coordinate = CLLocationCoordinate2D(latitude: latitutde, longitude: longitute)
            self.areaMapView.addAnnotation(trashLocation)
        }
        
        
        
    }
    
    func getDirections(to coordinate: CLLocationCoordinate2D){
        
               self.areaMapView.removeOverlays(self.areaMapView.overlays)
        guard let location = locationManager.location?.coordinate else{ return }
        
        let request = createDirectionsRequest(from: location, to: coordinate)
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] (response, error) in
            
            guard let response = response else { return }
            
            
            for route in response.routes {
                
                self.areaMapView.addOverlay(route.polyline)
                self.areaMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
            }
        }
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D, to trash_coordinate: CLLocationCoordinate2D) -> MKDirections.Request{
        
        let destination = trash_coordinate
        let startLocation = MKPlacemark(coordinate: coordinate)
        let destinationLocation = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        return request
        
        
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
        
        if let subtitle = annotation.subtitle , subtitle == "Trash"{
            
            annotationView!.image = UIImage(named: "trash-can")
        }
        annotationView!.canShowCallout = true
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("selected")
        getDirections(to: view.annotation!.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .green
        return renderer
        
    }
    
}


