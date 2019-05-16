//
//  ViewController.swift
//  ES presentation
//
//  Created by Harsh Mehta on 14/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController{


    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var incorrectLogin: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func wrongLogIn(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x - 10, y: incorrectLogin.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x + 10, y: incorrectLogin.center.y))
        
        incorrectLogin.layer.add(animation, forKey: "position")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if(password.text != ""){
            SVProgressHUD.show()
        }
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if(error != nil){
                SVProgressHUD.dismiss()
                self.incorrectLogin.text = "Incorrect Email or Password"
                self.wrongLogIn()
            }
            else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
            
        }
    }
    
    
}

