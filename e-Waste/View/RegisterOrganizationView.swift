//
//  RegisterOrganizationView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 21/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class RegisterOrganizationView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    @IBOutlet var organizationNumber: UITextField!
    @IBOutlet var organizationImage: UIImageView!
    @IBOutlet var organizationName: UITextField!
    @IBOutlet var organizationDescription: UITextView!
    @IBOutlet var registrationStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationStatus.text = ""
        organizationDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        organizationDescription.layer.borderWidth = 1.0;
        organizationDescription.layer.cornerRadius = 5.0;

    }
    
    func wrongSubmit(){
        
        registrationStatus.frame.size.height = 22
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: registrationStatus.center.x - 10, y: registrationStatus.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint(x: registrationStatus.center.x + 10, y: registrationStatus.center.y))
        
        registrationStatus.layer.add(animation, forKey: "position")
        
    }
    
    //MARK: submit button
    @IBAction func organizationSubmitPressed(_ sender: Any) {
        if (organizationDescription.text == ""  ||
            organizationName.text == ""         ||
            organizationNumber.text == ""       ||
            organizationImage.image  == nil
            ){
            wrongSubmit()
            registrationStatus.text = "Please fill all fields"
        }

        else{
            registrationStatus.text = "✅Registration Successful!"
        }
    }
    
    //MARK: image picker
    @IBAction func takePhotoByCamera(_ sender: Any) {
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
            registrationStatus.text = "Photo can't be taken"
        }
    }
    @IBAction func takePhotoByGallery(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let wasteImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        organizationImage.image = wasteImage
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
