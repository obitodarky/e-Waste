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

class ReportWasteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var wastePhoto: UIImageView!
    @IBOutlet var reportStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportStatus.text = ""
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
