//
//  UserReigsterViewController.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 14/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class UserReigsterViewController: UIViewController {
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userPhoneNumber: UITextField!
    @IBOutlet var userFirstName: UITextField!
    @IBOutlet var userLastName: UITextField!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var error_message: UILabel!
    @IBOutlet var signUpButton: UIButton!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        error_message.text = ""
        signUpButton.layer.shadowOpacity = 0.15
        signUpButton.layer.shadowRadius = 1
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.cornerRadius = 1
    }
    func wrongSignIn() {
        error_message.frame.size.height = 22
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: error_message.center.x - 10, y: error_message.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: error_message.center.x + 10, y: error_message.center.y))
        error_message.layer.add(animation, forKey: "position")
    }
    @IBAction func registerButton(_ sender: Any) {
        if userEmail.text != ""
            && userPassword.text != ""
            && userFirstName.text != ""
            && userLastName.text != ""
            && userPhoneNumber.text != "" {
            SVProgressHUD.show(withStatus: "Signing up")
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (user, error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    self.error_message.text = "Some error occured while Signing up"
                    self.wrongSignIn()
                } else {
                    if Auth.auth().currentUser != nil {
                        self.ref = Database.database().reference()
                        let reference = self.ref!
                        let user = Auth.auth().currentUser
                        let uid = user!.uid
                        let uemail = user!.email
                        reference.child("Users").child(uid).child("first_name").setValue(self.userFirstName.text)
                        reference.child("Users").child(uid).child("last_name").setValue(self.userLastName.text)
                        reference.child("Users").child(uid).child("email").setValue(uemail)
                        reference.child("Users").child(uid).child("number").setValue(self.userPhoneNumber.text)
                    } else {
                        self.wrongSignIn()
                    }
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "signIn", sender: self)
                }
            }
        } else {
            self.error_message.text = "Please fill all fields"
            self.wrongSignIn()
        }

    }
}
