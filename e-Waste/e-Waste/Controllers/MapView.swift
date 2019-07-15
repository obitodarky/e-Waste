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
import Firebase 
class MapView: UIViewController {
    
    @IBOutlet var areaMapView: MKMapView!
    let locationRequest = CoreLocationViewController()
    var centralLocation: Double = 1000
    let locationManager = CLLocationManager()
    let sampleTrash = MKPointAnnotation()
    var ref: DatabaseReference!
    //dictonary for trashcan locations : [latititude: longitute]
    var trashCan1 = CLLocationCoordinate2DMake(22.292009, 73.122745)
    var trashCan2 = CLLocationCoordinate2DMake(22.293309, 73.122941)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        areaMapView.delegate = self
        fetchData()
        setLocation()
    }
    
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerLocation() {
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
    
    func setAnnotations() {
        //self.areaMapView.removeAnnotations(self.areaMapView.annotations)
            let trashLocation = MKPointAnnotation()
            trashLocation.subtitle = "Trash"
            trashLocation.title = "Vasna"
            trashLocation.coordinate = trashCan1
            self.areaMapView.addAnnotation(trashLocation)
        
            let location2 = MKPointAnnotation()
            location2.coordinate = trashCan2
            location2.subtitle = "Trash"
            location2.title = "Vasna"
            self.areaMapView.addAnnotation(location2)
        
    }
    
    func getDirections(to coordinate: CLLocationCoordinate2D) {
        guard let location = locationManager.location?.coordinate else { return }
        let request = createDirectionsRequest(from: location, to: coordinate)
        let directions = MKDirections(request: request)
        self.areaMapView.removeOverlays(self.areaMapView.overlays)
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else { return }
            for route in response.routes {
                self.areaMapView.addOverlay(route.polyline)
                self.areaMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D, to trash_coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        
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
    func fetchData() {
        ref = Database.database().reference().child("Dustbins")
        ref?.observe(.childAdded, with: { (snapshot) in
            if let dictionary  = snapshot.value as? NSDictionary{
                let dustbin = Dustbins()
                let latitude = dictionary["latitude"] as? String ?? "Not found"
                let longitude = dictionary["longitude"] as? String ?? "Not found"
                dustbin.latitude = latitude
                dustbin.longitude = longitude
            }
        })
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
        if annotationView == nil{ annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationViews")
            if let subtitle = annotation.subtitle , subtitle == "Trash"{ annotationView!.image = UIImage(named: "trash-can") }
            annotationView!.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        getDirections(to: view.annotation!.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = UIColor(rgb: 0x71DB90)
        return renderer
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

}

