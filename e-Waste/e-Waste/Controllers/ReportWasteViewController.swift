//
//  ReportWasteViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 29/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase
import SVProgressHUD

class ReportWasteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var takePhoto: UIButton!
    let imagePicker = UIImagePickerController()
    var ref: DatabaseReference!
    let date = Date()
    let calendar = Calendar.current
    var year: Int = 0
    var week: Int = 0
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var location: CLLocationCoordinate2D!
    @IBOutlet weak var wastePhoto: UIImageView!
    @IBOutlet var reportStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportStatus.text = ""
        takePhoto.layer.shadowOpacity = 0.15
        takePhoto.layer.shadowRadius = 1
        takePhoto.layer.shadowColor = UIColor.black.cgColor
        takePhoto.layer.cornerRadius = 1
        wastePhoto.layer.shadowColor = UIColor.black.cgColor
        wastePhoto.layer.cornerRadius = 1
        wastePhoto.layer.masksToBounds = false
        wastePhoto.layer.shadowOpacity = 0.3
        wastePhoto.layer.shadowOffset = CGSize(width: -1.5, height: 1.5)
        wastePhoto.layer.shadowRadius = 2
        wastePhoto.layer.shouldRasterize = true
    }
    
    @IBAction func reportPhoto(_ sender: Any) {

        if(wastePhoto.image == nil){
            reportStatus.text = "Please select a photo"
        } else {
            SVProgressHUD.show(withStatus: "Reporting")
            UIApplication.shared.beginIgnoringInteractionEvents()
            year = calendar.component(.year, from: date)
            week = calendar.component(.weekOfYear, from: date)
            hour = calendar.component(.hour, from: date)
            minutes = calendar.component(.minute, from: date)
            seconds = calendar.component(.second, from: date)
            let date = String(year) + String(week) + String(hour) + String(minutes) + String(seconds)
            let user = Auth.auth().currentUser
            let uid = user!.uid
            ref = Database.database().reference().child("Photos")
            let reference = ref.child(date)
            let storageRef = Storage.storage().reference().child("wastePhoto:" + date)
            if let uploadData = wastePhoto.image?.pngData(){
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    if(error != nil) {
                        print(error!)
                        return
                    } else {
                        storageRef.downloadURL(completion: { (url, error) in
                            guard let downloadURL = url else { return }
                            print(downloadURL)
                            reference.child("Location").child("latitute").setValue(self.location.latitude)
                            reference.child("Location").child("longitute").setValue(self.location.longitude)
                            reference.child("Photo").setValue(downloadURL.absoluteString)
                            reference.child("User").setValue(uid)
                            self.reportStatus.text = "✅ Photo Submitted!"
                        })
                    }
                }
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func takePhoto(_sender: Any){
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            reportStatus.text = "Photo can't be taken"
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let wasteImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        wastePhoto.image = wasteImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

