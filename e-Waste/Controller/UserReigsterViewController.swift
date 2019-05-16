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
    @IBOutlet var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func registerButton(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { (user, error) in
            
            if(error != nil ){
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "signIn", sender: self)
            }
        }
    
    }
    

}
