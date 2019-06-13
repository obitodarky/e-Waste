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
import Firebase
import SVProgressHUD

class CoreLocationViewController: UIViewController {
    var locationManager: CLLocationManager?
    var previousLocation: CLLocation?
    @IBAction func logOut(_ sender: Any) {
        SVProgressHUD.show()
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            let navVC = UINavigationController(rootViewController: viewController!)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
            navigationController?.popToRootViewController(animated: true)
            SVProgressHUD.dismiss()
        } catch { SVProgressHUD.dismiss() }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "report_waste"{
            let viewController = segue.destination as? ReportWasteViewController
            viewController?.location = previousLocation?.coordinate
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    @IBAction func startLocationManager(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            activateLocationServices()
        } else { locationManager?.requestWhenInUseAuthorization() }
    }
    func activateLocationServices() {
        locationManager?.startUpdatingLocation()
    }
}

extension CoreLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways { activateLocationServices() }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if previousLocation == nil {
            previousLocation =  locations.first
        } else {
            guard let latestLocation = locations.first else { return }
            previousLocation = latestLocation
        }
    }
}
