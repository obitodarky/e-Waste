//
//  ReportWasteViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 29/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import Foundation
import UIKit

class ReportWasteViewController: ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    

    @IBOutlet weak var wastePhoto: UIImageView!
    
    @IBAction func takePhoto(_sender: Any){
        
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
            print("Camera not available")
        }
        
        
        

        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let wasteImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        wastePhoto.image = wasteImage
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
}

